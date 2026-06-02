from db.database import db

class Level(db.Model):
    
    __tablename__ = "level"
 
    id = db.Column(
        db.Integer,
        primary_key=True,
    )

    name = db.Column(
        db.String(100),
        nullable=False,
    )

    xp_reward = db.Column(
        db.Integer,
        nullable=False,
    )

    bits_reward = db.Column(
        db.Integer,
        nullable=False,
    )