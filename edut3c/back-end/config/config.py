import os

class Config:
    SQLALCHEMY_DATABASE_URI = (
        f"mysql+pymysql://{os.getenv('DB_USER', 'edut3c_user')}:"
        f"{os.getenv('DB_PASSWORD', '')}@"
        f"{os.getenv('DB_HOST', 'db')}:"
        f"{os.getenv('DB_PORT', '3306')}/"
        f"{os.getenv('DB_NAME', 'edut3c')}"
    )

    SQLALCHEMY_TRACK_MODIFICATIONS = False