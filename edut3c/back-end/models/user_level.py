from db.database import db

class UserLevel(db.Model):

    __tablename__ = "user_levels"
    
    id = db.Column(
        db.Integer,
        primary_key=True
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("user.id"),
        nullable=False
    )

    level_id = db.Column(
        db.Integer,
        db.ForeignKey("level.id"),
        nullable=False
    )

    completed = db.Column(
        db.Boolean,
        default=False
    )
    
    user = db.relationship(
    "User",
    backref="completed_levels"
    )

    level = db.relationship(
    "Level",
    backref="players"
    )