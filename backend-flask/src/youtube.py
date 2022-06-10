from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.database import User, db
from src.algo.extract_data import youtube_comments_extract
from src.algo.Sentimento import Sentimento

youtube_blueprint = Blueprint('youtube', __name__)


@youtube_blueprint.route('/red/', methods=['POST'])
@jwt_required()
def youtube_sentiment():
    request_data = request.get_json()
    try:
        video_id = request_data['video_id']
        api_key = request_data['api_key']
        approx_comments = 0  # declaring outside so that it can be used at this space
        try:
            approx_comments = int(request_data['approx_comments'])
        except:
            return {"success": "false", "msg": "Approx comments should be numeric"}
        if (len(video_id) < 5 or len(video_id) > 50):
            return {"success": "false", "msg": "Please provide valid video source"}
        if (len(api_key) < 5 or len(api_key) > 250):
            return {"success": "false", "msg": "Please provide valid key/coupan"}
        if ((approx_comments < 20) or (approx_comments > 1000)):
            return {"success": "false", "msg": "Comments between 20 to 1000 can only be set at the moment"}

        # after post req validation, moving to youtube sentiment analysis
        youtube_data = youtube_comments_extract(
            video_id, api_key, approx_comments)

        # making object of sentiment result
        sentiment = Sentimento(youtube_data[0])

        # after getting sentiment result, need to increase user's analysis count record
        user_email = get_jwt_identity()
        current_user = User.query.filter_by(email=user_email).first()
        current_user.analysis_count += 1
        db.session.commit()

        # after adding the user's analysis count, need to return sentiment result to user
        return {
            "success": "true",
            "msg": "Analysed given data succesfully",
            "title": youtube_data[2],
            "thumbnail": youtube_data[1],
            "total_data": sentiment.data_count(),
            "spam_count": sentiment.layer_count()[0],
            "sarcasm_count": sentiment.layer_count()[1],
            "positive_count":  sentiment.overall_polarity()["positive_count"],
            "negative_count":  sentiment.overall_polarity()["negative_count"],
            "neutral_count":  sentiment.overall_polarity()["neutral_count"],
            "overall_polarity": round((sentiment.overall_polarity()["overall_polarity"]), 3)
        }

    except:
        return {"success": "false", "msg": "Invalid API request"}
