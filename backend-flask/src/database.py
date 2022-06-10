from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(55), nullable=False)
    email = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.Text(), nullable=False)
    purpose = db.Column(db.String(30), nullable=False)
    analysis_count = db.Column(db.Integer, default=0)
    vacancy_count = db.Column(db.Integer, default=0)
    reports = db.relationship('Report', backref="user")
    vacancies = db.relationship('Vacancy', backref="user")

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def __repr__(self) -> str:
        return 'User>>> {self.email}'


class Report(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    analysis_datetime = db.Column(db.DateTime, default=datetime.now())
    platform = db.Column(db.String(20), nullable=False)
    data = db.Column(db.String(120), nullable=False)
    data_count = db.Column(db.Integer, nullable=False)
    spam_count = db.Column(db.Integer, nullable=False)
    sarcasm_count = db.Column(db.Integer, nullable=False)
    positive_count = db.Column(db.Integer, nullable=False)
    negative_count = db.Column(db.Integer, nullable=False)
    neutral_count = db.Column(db.Integer, nullable=False)
    overall_polarity = db.Column(db.String(5), nullable=False)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def __repr__(self) -> str:
        return 'Report>> {self.data}'


class Vacancy(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    title = db.Column(db.String(50), nullable=False)
    contact_email = db.Column(db.String(80), nullable=False)
    contact_number = db.Column(db.String(20), nullable=False)
    description = db.Column(db.String(120), nullable=False)
    work_hr = db.Column(db.Integer, nullable=False)
    wage_hr = db.Column(db.Text, nullable=False)
    is_negotiable = db.Column(db.Boolean, default=True, nullable=False)
    is_vacancy = db.Column(db.Boolean, default=True, nullable=False)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def __repr__(self) -> str:
        return 'Vacancy>> {self.title}'
