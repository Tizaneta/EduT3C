from db.database import db

class Item(db.Model):

    __tablename__ = "item"
    
    id = db.Column(
        db.Integer,
        primary_key=True
    )

    name = db.Column(
        db.String(100),
        nullable=False
    )

    price = db.Column(
        db.Integer,
        nullable=False
    )
    
    description = db.Column(
        db.String(255),
        nullable=False
    )
    
    icon = db.Column(
        db.String(255),
        nullable=False
    )

    is_stackable = db.Column(
        db.Boolean,
        default=False
    )

    type = db.Column(
    db.String(50),
    nullable=False
    )
    
    def to_dict(self):
        return {
        "id": self.id,
        "name": self.name,
        "description": self.description,
        "price": self.price,
        "equipped_frame_id": self.equipped_frame_id,
        "equipped_avatar_id": self.equipped_avatar_id,
        "equipped_title_id": self.equipped_title_id

        }