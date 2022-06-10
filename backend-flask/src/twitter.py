from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.database import User, db
from src.algo.extract_data import tweets_extract
from src.algo.Sentimento import Sentimento
from src.functions.field_validators import success_false

twitter_blueprint = Blueprint('twitter', __name__)


@twitter_blueprint.route('/blue/', methods=['POST'])
@jwt_required()
def twitter_sentiment():
    request_data = request.get_json()
    try:
        searched_topic = request_data['searched_topic']
        approx_tweets = 0  # declaring outside so that it can be used at this space
        try:
            approx_tweets = int(request_data['approx_data'])
        except:
            return success_false(msg="Approx number of data should be numeric")
        c_key = request_data['c_key']
        c_secret = request_data['c_secret']
        a_token = request_data['a_token']
        a_token_secret = request_data['a_token_secret']
        if (len(c_key) < 5 or len(c_key) > 250):
            return success_false(msg="Please provide valid key/coupan")
        if ((approx_tweets < 20) or (approx_tweets > 1000)):
            return success_false(msg="Data between 20 to 1000 can only be set at the moment")

        # after post req validation, moving to twitter sentiment analysis
        twitter_data = tweets_extract(
            searched_topic, approx_tweets, c_key, c_secret, a_token, a_token_secret)

        # making object of sentiment result
        sentiment = Sentimento(twitter_data)

        # after getting sentiment result, need to increase user's analysis count record
        user_email = get_jwt_identity()
        current_user = User.query.filter_by(email=user_email).first()
        current_user.analysis_count += 1
        db.session.commit()

        # after adding the user's analysis count, need to return sentiment result to user
        return {
            "success": "true",
            "msg": "Analysed given data succesfully",
            "total_data": sentiment.data_count(),
            "spam_count": sentiment.layer_count()[0],
            "sarcasm_count": sentiment.layer_count()[1],
            "positive_count":  sentiment.overall_polarity()["positive_count"],
            "negative_count":  sentiment.overall_polarity()["negative_count"],
            "neutral_count":  sentiment.overall_polarity()["neutral_count"],
            "overall_polarity": round((sentiment.overall_polarity()["overall_polarity"]), 3)
        }

    except:
        return success_false()
