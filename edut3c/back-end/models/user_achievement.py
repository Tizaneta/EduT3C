from db.database import db

class UserAchievement(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("user.id"),
        nullable=False
    )

    achievement_id = db.Column(
        db.Integer,
        db.ForeignKey("achievements.id"),
        nullable=False
    )

    obtained_at = db.Column(
        db.DateTime
    )
    
    user = db.relationship(
        "User",
        backref="achievements_player"
    )

    achievement = db.relationship(
        "Achievement",
        backref="owners_achievement"
    )