from db.database import db

class Achievement(db.Model):
    
    __tablename__ = "achievements"
    
    id = db.Column(
        db.Integer,
        primary_key = True,
    )
    name = db.Column(
        db.String(20),
        unique = True,
        nullable = False
    )
    xp_required = db.Column(
        db.Integer,
        unique = True,
        nullable = False
    )
    achievement_icon = db.Column(
        db.String(30),
        unique = True,
        nullable = True
    )
    
    def to_dict(self):

        return {
        "id": self.id,
        "name": self.name,
        "xp_required": self.xp_required,
        "achievement_icon": self.achievement_icon
        }