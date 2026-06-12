from db.database import db

class Rank(db.Model):

    __tablename__ = "ranks"
    
    id = db.Column(
        db.Integer,
        primary_key=True
    )
    
    name = db.Column(
        db.String(50),
        unique=True,
        nullable=False
    )

    xp_required = db.Column(
        db.Integer,
        nullable=False
    )
    
def to_dict(self):
    return {
        "id": self.id,
        "name": self.name,
        "xp_required": self.xp_required
    }