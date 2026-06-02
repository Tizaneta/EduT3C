from flask import Flask
from flask_cors import CORS
from db.database import db
from config.config import Config
from api.users import users_bp

#imports de la base de datos
from models.user import User
from models.friend import Friend
from models.level import Level
from models.user_level import UserLevel
from models.rank import Rank
from models.item import Item
from models.user_item import UserItem

app = Flask(__name__)

CORS(app)

app.config.from_object(Config)

db.init_app(app)

app.register_blueprint(users_bp)


@app.route("/")
def home():
    return  {
        "message": "Backend funcionando al parecer"
    }
    
with app.app_context():
    db.create_all()
    

if __name__ == "__main__":
    app.run(debug=True)

