# backend in monolithic architecture
# middleware file

from flask import Flask
import os
from flask_jwt_extended import JWTManager
from src.register import register_blueprint
from src.login import login_blueprint
from src.report import report_blueprint
from src.profile import profile_blueprint
from src.vacancy import vacancy_blueprint
from src.youtube import youtube_blueprint
from src.twitter import twitter_blueprint
from src.manual import manual_blueprint
from src.database import db


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    if test_config is None:
        app.config.from_mapping(
            SECRET_KEY=os.environ.get("SECRET_KEY"),
            SQLALCHEMY_DATABASE_URI=os.environ.get("SQLALCHEMY_DB_URI"),
            SQLALCHEMY_TRACK_MODIFICATIONS=False,
            JWT_SECRET_KEY=os.environ.get('JWT_SECRET_KEY')
        )

    else:
        app.config.from_mapping(test_config)

    app.register_blueprint(register_blueprint)
    app.register_blueprint(login_blueprint)
    app.register_blueprint(report_blueprint)
    app.register_blueprint(profile_blueprint)
    app.register_blueprint(vacancy_blueprint)
    app.register_blueprint(youtube_blueprint)
    app.register_blueprint(twitter_blueprint)
    app.register_blueprint(manual_blueprint)

    # decorator for index page of the backend
    @app.route("/")
    def index():
        return {
            "Registration": "/register/ [POST]",
            "Login": "/login/ [POST]",
            "User profile": "/profile/ [GET]",
            "YouTube comments analysis": "/red/ [POST]",
            "Tweets analysis": "/blue/ [POST]",
            "User reports": "/report/ [GET/POST]",
            "Vacancy": "/vacancy/ [GET/POST] & /vacancy/all?filter=freelancer or vacancy [GET]",
            "Sentence/Paragraph polarity": "/manual/ [POST]"}

    db.app = app
    db.init_app(app)

    JWTManager(app)

    return app
