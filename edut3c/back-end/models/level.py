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
    
def to_dict(self):
    return {
        "id": self.id,
        "name": self.name,
        "xp_reward": self.xp_reward,
        "bits_reward": self.bits_reward
    }