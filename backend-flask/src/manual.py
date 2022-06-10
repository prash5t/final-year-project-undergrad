from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.functions.field_validators import success_false
from src.database import User, db
from nltk.sentiment.vader import SentimentIntensityAnalyzer

manual_blueprint = Blueprint('manual', __name__)


@manual_blueprint.route('/manual/', methods=['POST'])
@jwt_required()
def manual():
    try:
        request_data = request.get_json()
        manual_data = request_data['manual_data']
        if len(manual_data) < 3:
            return success_false(msg="Please enter longer sentence than this")
        if len(manual_data) > 500:
            return success_false(msg="Paragraph with maximum 500chars is only acceptable at the moment")

        # calculating polarity using NLTK library
        sid = SentimentIntensityAnalyzer()
        manual_data_polarity = sid.polarity_scores(manual_data)["compound"]

        # to count/update how many times user has used analysis feature
        user_email = get_jwt_identity()
        current_user = User.query.filter_by(email=user_email).first()
        current_user.analysis_count += 1
        db.session.commit()

        # responding to user's manual polarity
        return {
            "success": "true",
            "msg": "Analysed given data succesfully",
            "polarity": round(manual_data_polarity, 3)
        }

    except:
        return success_false()
