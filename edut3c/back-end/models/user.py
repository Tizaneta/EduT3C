from db.database import db

class User(db.Model):
    
    __tablename__ = "user"
    
    id = db.Column(
        db.Integer,
        primary_key = True,
        )
    
    username = db.Column(
        db.String(30),
        unique = True,
        nullable = False,
        )
    
    password = db.Column(
        db.String(128),
        nullable = False,
    )
    
    email = db.Column(
        db.String(128),
        unique = True,
        nullable = False,
    )
    
    xp = db.Column(
        db.Integer,
        default=0,
    )
    
    bits = db.Column(
        db.Integer,
        default=0,
    )
    
    def to_dict(self):

        return {
        "id": self.id,
        "username": self.username,
        "email": self.email,
        "xp": self.xp,
        "bits": self.bits,
        "xp_multiplier": self.xp_multiplier,
        "xp_boost_until": self.xp_boost_until
        }
    
    rank = db.relationship(
        "Rank",
        backref="users"
    )
    
    rank_id = db.Column(
        db.Integer,
        db.ForeignKey("ranks.id")
    )
    
    equipped_frame_id = db.Column(
        db.Integer,
        db.ForeignKey("item.id")
    )

    equipped_avatar_id = db.Column(
        db.Integer,
        db.ForeignKey("item.id")
    )

    equipped_title_id = db.Column(
        db.Integer,
        db.ForeignKey("item.id")
    )
    
    xp_multiplier = db.Column(
        db.Float,
        default=1.0
    )

    xp_boost_until = db.Column(
        db.DateTime,
        nullable=True
    )
    

    
    
    