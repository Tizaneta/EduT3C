from db.database import db

class UserItem(db.Model):

    __tablename__ = "user_items"
    
    id = db.Column(
        db.Integer,
        primary_key=True
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("user.id"),
        nullable=False
    )

    item_id = db.Column(
        db.Integer,
        db.ForeignKey("item.id"),
        nullable=False
    )
    
    quantity = db.Column(
    db.Integer,
    default=1
    )
    
    user = db.relationship(
        "User",
        backref="inventory"
    )

    item = db.relationship(
        "Item",
        backref="owners"
    )