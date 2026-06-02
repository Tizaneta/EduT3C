from flask import Blueprint
from db.database import db
from models.user import User



users_bp = Blueprint(
    "users",
    __name__
)

@users_bp.route("/users")
def get_users():
    return {"message": "API funcionando"}

