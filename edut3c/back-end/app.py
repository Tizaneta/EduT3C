from flask import Flask
from flask_cors import CORS
from db.database import db
from config.config import Config
from api.users import users_bp, items_bp, levels_bp, achievements_bp
from flask_migrate import Migrate

#imports de la base de datos
from models.user import User
from models.friend import Friend
from models.level import Level
from models.user_level import UserLevel
from models.rank import Rank
from models.item import Item
from models.user_item import UserItem
from models.achievements import Achievement
from models.user_achievement import UserAchievement

app = Flask(__name__)

CORS(app)

app.config.from_object(Config)

db.init_app(app)

app.register_blueprint(users_bp)

app.register_blueprint(items_bp)

app.register_blueprint(levels_bp)

app.register_blueprint(achievements_bp)

migrate = Migrate(
    app,
    db
)

@app.route("/")
def home():
    return  {
        "message": "Backend funcionando al parecer"
    }
     

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
        )

