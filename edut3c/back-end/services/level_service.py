from db.database import db
from models.user import User
from models.level import Level
from models.user_level import UserLevel


class LevelService:

    BITS_PER_MISTAKE = 10

    @staticmethod
    def register_mistake(user_id, level_id):

        user = User.query.get(user_id)

        if not user:
            return {"message": "Usuario no encontrado."}, 404

        game_level = Level.query.get(level_id)

        if not game_level:
            return {"message": "Nivel no encontrado."}, 404

        progress = UserLevel.query.filter_by(
            user_id=user.id,
            level_id=game_level.id
        ).first()

        if progress and progress.completed:
            return {
                "message": "El nivel ya está completado."
            }, 409

        if not progress:
            progress = UserLevel(
                user_id=user.id,
                level_id=game_level.id,
                completed=False,
                incorrect_answers=0
            )
            db.session.add(progress)

        progress.incorrect_answers += 1

        db.session.commit()

        return {
            "message": "Error registrado.",
            "incorrect_answers": progress.incorrect_answers
        }, 200