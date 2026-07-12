from datetime import datetime

from models.achievements import Achievement
from models.user_achievement import UserAchievement
from db.database import db


class AchievementService:

    @staticmethod
    def check_xp_achievements(user):

        achievements = Achievement.query.all()

        unlocked = []

        for achievement in achievements:

            if user.xp < achievement.xp_required:
                continue

            exists = UserAchievement.query.filter_by(
                user_id=user.id,
                achievement_id=achievement.id
            ).first()

            if exists:
                continue

            db.session.add(

                UserAchievement(
                    user_id=user.id,
                    achievement_id=achievement.id,
                    obtained_at=datetime.utcnow()
                )

            )

            unlocked.append(achievement.name)

        return unlocked