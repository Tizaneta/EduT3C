from datetime import datetime

class PlayerService:

    XP_PER_LEVEL = 100

    @staticmethod
    def apply_boost(user, xp_reward):

        if (
            user.xp_boost_until is not None
            and user.xp_boost_until > datetime.now()
        ):
            return int(xp_reward * user.xp_multiplier)

        user.xp_multiplier = 1.0

        return int(xp_reward)

    @staticmethod
    def calculate_level(total_xp):

        level = 1
        xp_needed = PlayerService.XP_PER_LEVEL

        while total_xp >= xp_needed:

            total_xp -= xp_needed

            level += 1

            xp_needed += PlayerService.XP_PER_LEVEL

        return level

    @staticmethod
    def add_xp(user, xp_amount):

        previous_level = user.level

        user.xp += xp_amount

        user.level = PlayerService.calculate_level(
            user.xp
        )

        return user.level > previous_level