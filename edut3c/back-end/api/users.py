from flask import Blueprint, jsonify, request
from db.database import db
from models.user import User
from models.item import Item
from models.user_item import UserItem
from models.level import Level
from models.user_level import UserLevel
from models.friend import Friend
from models.achievements import Achievement
from models.user_achievement import UserAchievement
from datetime import datetime, timedelta, timezone
from services import PlayerService

# Para migrar los modelos nuevos a la base de datos:
# flask db migrate -m "X" (es como un git add .)
# flask db upgrade (es como un git commit)

items_bp = Blueprint(
    "items",
    __name__
)

users_bp = Blueprint(
    "users",
    __name__
)

levels_bp = Blueprint(
    "levels",
    __name__
)

achievements_bp = Blueprint(
    "achievements",
    __name__
)

# SELECT * FROM user;

@users_bp.route("/users")
def get_users():
    users = User.query.all()
    return jsonify([user.to_dict() for user in users])
    
# INSERT INTO user (tal y tal) VALUES (tal y tal);

@users_bp.route("/users", methods=["POST"])
def create_users():
    print("POST recibido")
    data = request.json
    
    if not data:
         return jsonify({
                "error": "No se recibieron datos"
            }), 400
         
    
    if not data.get("username") \
        or not data.get("email") \
        or not data.get("password"):
            return jsonify({
                "error": "Faltan datos"
            }), 400
            
    existing_user = User.query.filter_by(username=data["username"]).first()
    if existing_user:
        return jsonify({
        "error": "Ese nombre de usuario ya existe."
    }), 400
        
    existing_email = User.query.filter_by(email=data["email"]).first()
    if existing_email:
        return jsonify({
        "error": "El email ya está registrado, prueba a iniciar sesión."
    }), 400
    
    
    new_user = User(
        username=data["username"],
        password=data["password"],
        email=data["email"]
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({
        "mensaje": "Usuario creado con éxito."
    }), 201

# SELECT * FROM user WHERE id = X;

@users_bp.route("/users/<int:id>")
def get_user(id):

    user = User.query.get(id)

    if not user:
        return jsonify({
            "error": "Usuario no encontrado."
        }), 404

    return jsonify(user.to_dict())

# UPDATE user SET username, email WHERE id = X;

@users_bp.route("/users/<int:id>", methods=["PUT"])
def modify_user(id):
    
    user = User.query.get(id)
    
    if not user:
        return jsonify({
            "error": "Usuario no encontrado."
        }), 404
    
    data = request.json
    
    user.username = data.get("username", user.username)
    user.email = data.get("email", user.email)
    user.password = data.get("password", user.password)

    db.session.commit()

    return jsonify({
        "message": "Datos de usuario actualizado.",
        "user": user.to_dict()
    }), 200
    
# DELETE FROM user WHERE id = X;
    
@users_bp.route("/users/<int:id>", methods=["DELETE"])
def delete_user(id):

    user = User.query.get(id)

    if not user:
        return jsonify({
            "error": "Usuario no encontrado."
        }), 404

    db.session.delete(user)

    db.session.commit()

    return jsonify({
        "message": "Usuario eliminado."
    }), 200
    
# Endpoint para items /GET

@items_bp.route("/items")
def get_items():

    items = Item.query.all()

    return jsonify([item.to_dict() for item in items])

# Endpoint para obtener todos los objetos del inventario del jugador /GET

@items_bp.route("/users/<int:id>/items")
def get_inventory(id):

    inventory = UserItem.query.filter_by(
        user_id=id
    ).all()

    return jsonify([
        user_item.item.to_dict()
        for user_item in inventory
    ])
    
# Endpoint para obtener todos los niveles del juego /GET
    
@levels_bp.route("/levels")
def get_levels():
    levels = Level.query.all()

    return jsonify([
        level.to_dict()
        for level in levels
    ])
    
# Endpoint importante para la relación de nivel completo entre jugador y nivel, decide si se entrega recompensa.

@levels_bp.route("/levels/<int:id>/complete", methods=["POST"])
def complete_level(id):

    data = request.json

    user = User.query.get(data["user_id"])

    if not user:
        return jsonify({
            "message": "Usuario no encontrado."
        }), 404

    game_level = Level.query.get(id)

    if not game_level:
        return jsonify({
            "message": "Nivel no encontrado."
        }), 404

    completed_level = UserLevel.query.filter_by(
        user_id=user.id,
        level_id=game_level.id,
        completed=True
    ).first()

    if completed_level:
        return jsonify({
            "message": "Nivel ya completado, no se recibirá recompensas."
        }), 200

    bits_reward = game_level.bits_reward
    xp_reward = PlayerService.apply_boost(
    user,
    game_level.xp_reward
)
    user.bits += bits_reward

    new_completion = UserLevel(
        user_id=user.id,
        level_id=game_level.id,
        completed=True
    )

    db.session.add(new_completion)
    db.session.commit()

    return jsonify({
        "message": "Nivel completado",
        "xp_gained": xp_reward,
        "bits_gained": bits_reward,
        "user": user.to_dict()
    }), 200
    
# Endpoint para compra de objetos en la tienda.
    
@items_bp.route("/users/<int:id>/items", methods=["POST"])
def buy_item(id):
    
    user = User.query.get(id)

    if not user:
        return jsonify({
            "message": "Usuario no encontrado."
        }), 404

    data = request.json

    if "item_id" not in data:
        return jsonify({
        "message": "Falta item_id."
    }), 400
    
    item = Item.query.get(data["item_id"])
    

    if not item:
        return jsonify({
            "message": "Objeto no encontrado."
        }), 404
    
    if user.bits < item.price:
        return jsonify({
            "message": "No tienes suficientes bits"
        }), 400
        
    existing_item = UserItem.query.filter_by(user_id=user.id, item_id=item.id).first()

    if existing_item:
        if item.is_stackable:
            existing_item.quantity += 1

        else:
            return jsonify({
                "message": "Ya tienes este objeto."
            }), 400
    else:
        user_item = UserItem(
            user_id=user.id,
            item_id=item.id,
            quantity=1
            )
        db.session.add(user_item)
        
    user.bits -= item.price

    db.session.commit()

    return jsonify({
        "message": "Objeto comprado."
    }), 200
    
# Endpoint para login

@users_bp.route("/login", methods=["POST"])
def login():

    data = request.json

    print(data)

    user = User.query.filter_by(
        email=data["email"]
    ).first()

    if not user:
        return jsonify({
            "message": "El correo electrónico no está registrado."
        }), 401

    if user.password != data["password"]:
        return jsonify({
            "message": "La contraseña es incorrecta."
        }), 401

    return jsonify({
        "message": "Inicio de sesión exitoso.",
        "user": user.to_dict()
    }), 200
    
# Endpoint para añadir amigos.

@users_bp.route("/users/<int:id>/friends", methods=["POST"])
def add_friend(id):

    data = request.json

    friend = User.query.get(data["friend_id"])

    if not friend:
        return jsonify({
            "message": "Usuario no encontrado."
        }), 404

    existing_friend = Friend.query.filter_by(
        user_id=id,
        friend_id=friend.id
    ).first()

    if existing_friend:
        return jsonify({
            "message": "Ya son amigos."
        }), 400
        
    if id == friend.id:
        return jsonify({
        "message": "No puedes agregarte a ti mismo."
    }), 400

    new_friend = Friend(
        user_id=id,
        friend_id=friend.id
    )

    db.session.add(new_friend)
    db.session.commit()

    return jsonify({
        "message": f"Ahora {friend.username} es tu amigo"
    }), 201
    
# Endpoint para eliminación de amigos.
    
@users_bp.route("/users/<int:id>/friends/<int:friend_id>", methods=["DELETE"])
def delete_friend(id, friend_id):

    friendship = Friend.query.filter_by(
        user_id=id,
        friend_id=friend_id
    ).first()

    if not friendship:
        return jsonify({
            "message": "Amigo no encontrado."
        }), 404

    db.session.delete(friendship)
    db.session.commit()

    return jsonify({
        "message": "Amigo eliminado."
    }), 200
    
# Endpoint para ver tus amigos.

@users_bp.route("/users/<int:id>/friends")
def get_friends(id):

    friends = Friend.query.filter_by(
        user_id=id
    ).all()

    return jsonify([
        User.query.get(friend.friend_id).to_dict()
        for friend in friends
    ])
    
# Endpoint para consumir boosts.

@items_bp.route("/users/<int:id>/use-item", methods=["POST"])
def use_item(id):

    data = request.json

    user = User.query.get(id)

    if "item_id" not in data:
        return jsonify({
        "message": "Falta item_id."
    }), 400
    
    item = Item.query.get(data["item_id"])

    if not user or not item:
        return jsonify({
            "message": "Usuario u objeto no encontrado."
        }), 404

    inventory_item = UserItem.query.filter_by(
        user_id=user.id,
        item_id=item.id
    ).first()

    if not inventory_item:
        return jsonify({
            "message": "No tienes este objeto."
        }), 400

    if item.type != "boost":
        return jsonify({
            "message": "Este objeto no es consumible."
        }), 400

    # Asignamos el multiplicador según la poción.

    if item.name == "Pocion XP x1.5":
        user.xp_multiplier = 1.5

    elif item.name == "Pocion XP x2":
        user.xp_multiplier = 2.0

    elif item.name == "Pocion XP x3":
        user.xp_multiplier = 3.0

    else:
        return jsonify({
            "message": "Potenciador desconocido."
        }), 400

    # Duración del boost: 15 minutos.
    user.xp_boost_until = (
        datetime.now()
        + timedelta(minutes=15)
    )

    # Consumimos una unidad del objeto.
    inventory_item.quantity -= 1

    if inventory_item.quantity <= 0:
        db.session.delete(inventory_item)

    db.session.commit()

    return jsonify({
        "message": "Potenciador utilizado.",
        "multiplier": user.xp_multiplier,
        "active_until": user.xp_boost_until.isoformat()
    }), 200
    
# Endpoint para equipar objetos.

@items_bp.route("/users/<int:id>/equip", methods=["POST"])
def equip_item(id):

    data = request.json

    user = User.query.get(id)

    if "item_id" not in data:
        return jsonify({
        "message": "Falta item_id."
    }), 400
    
    item = Item.query.get(data["item_id"])

    if not user or not item:
        return jsonify({
            "message": "Usuario u objeto no encontrado."
        }), 404

    inventory_item = UserItem.query.filter_by(
        user_id=user.id,
        item_id=item.id
    ).first()

    if not inventory_item:
        return jsonify({
            "message": "No tienes este objeto."
        }), 400

    if item.type == "frame":
        user.equipped_frame_id = item.id

    elif item.type == "avatar":
        user.equipped_avatar_id = item.id

    elif item.type == "title":
        user.equipped_title_id = item.id

    else:
        return jsonify({
        "message": "Este objeto no se puede equipar."
    }), 400

    db.session.commit()

    return jsonify({
        "message": "Objeto equipado."
    })
    
# Endpoint de los logros

@achievements_bp.route("/achievements")
def get_achievements():
    achievements = Achievement.query.all()
    return jsonify([
        achievement.to_dict() 
        for achievement in achievements])

# Endpoint de los logros de los usuarios

@achievements_bp.route("/users/<int:id>/achievements")
def get_achievements_user(id):
    
    user_achievements = UserAchievement.query.filter_by(user_id=id).all()
    
    if not user_achievements:
        return jsonify({
        "message": "El usuario no tiene logros."
    }), 404
    
    return jsonify([user_achievement.achievement.to_dict() for user_achievement in user_achievements])
    
    
    
@achievements_bp.route("/users/<int:id>/achievements", methods=["POST"])
def unlock_achievement(id):
    
    data = request.json

    achievement_id = data["achievement_id"]
    
    achievement = Achievement.query.get(achievement_id)
    
    if not achievement:
        return jsonify({
        "message": "El logro no existe."
    }), 404

    # Verificar que no lo tenga ya

    exists = UserAchievement.query.filter_by(
        user_id=id,
        achievement_id=achievement_id
    ).first()

    if exists:
        return jsonify({
            "message": "El usuario ya posee este logro."
        }), 400

    new_achievement = UserAchievement(
        user_id=id,
        achievement_id=achievement_id,
        obtained_at=datetime.utcnow()
    )

    db.session.add(new_achievement)
    db.session.commit()

    return jsonify({
        "message": "Logro desbloqueado."
    }), 201