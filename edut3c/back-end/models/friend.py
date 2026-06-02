from db.database import db

class Friend(db.Model):

    __tablename__ = "friends"
    
    id = db.Column(
        db.Integer,
        primary_key=True
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("user.id"),
        nullable=False
    )

    friend_id = db.Column(
        db.Integer,
        db.ForeignKey("user.id"),
        nullable=False
    )