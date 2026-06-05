from flask import Blueprint, jsonify, request
from db.database import db
from models.user import User



users_bp = Blueprint(
    "users",
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
        "error": "El usuario ya existe"
    }), 400
        
    existing_email = User.query.filter_by(email=data["email"]).first()
    if existing_email:
        return jsonify({
        "error": "El email ya existe"
    }), 400
    
    
    new_user = User(
        username=data["username"],
        password=data["password"],
        email=data["email"]
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({
        "mensaje": "Usuario creado con éxito"
    }), 201

# SELECT * FROM user WHERE id = X;

@users_bp.route("/users/<int:id>")
def get_user(id):

    user = User.query.get(id)

    if not user:
        return jsonify({
            "error": "Usuario no encontrado"
        }), 404

    return jsonify(user.to_dict())

# UPDATE user SET username, email WHERE id = X;

@users_bp.route("/users/<int:id>", methods=["PUT"])
def modify_user(id):
    
    user = User.query.get(id)
    
    if not user:
        return jsonify({
            "error": "User not found"
        }), 404
    
    data = request.json
    
    user.username = data.get("username", user.username)
    user.email = data.get("email", user.email)

    db.session.commit()

    return jsonify({
        "message": "Usuario actualizado",
        "user": user.to_dict()
    }), 200
    
# DELETE FROM user WHERE id = X;
    
@users_bp.route("/users/<int:id>", methods=["DELETE"])
def delete_user(id):

    user = User.query.get(id)

    if not user:
        return jsonify({
            "error": "Usuario no encontrado"
        }), 404

    db.session.delete(user)

    db.session.commit()

    return jsonify({
        "message": "Usuario eliminado"
    }), 200
    
    

    

