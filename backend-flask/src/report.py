from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.database import User, Report, db
from src.functions.field_validators import success_false

report_blueprint = Blueprint('report', __name__)


@report_blueprint.route('/report/', methods=['POST', 'GET'])
@jwt_required()
def report():
    if request.method == "GET":
        try:
            user_email = get_jwt_identity()
            current_user = User.query.filter_by(email=user_email).first()
            user_reports = Report.query.filter_by(
                user_id=current_user.id)
            reports = []
            for each in user_reports:
                reports.append({
                    "id": each.id,
                    "analysis_time": each.analysis_datetime,
                    "platform": each.platform,
                    "data": each.data,
                    "data_count": each.data_count,
                    "spam_count": each.spam_count,
                    "sarcasm_count": each.sarcasm_count,
                    "positive_count": each.positive_count,
                    "negative_count": each.negative_count,
                    "neutral_count": each.neutral_count,
                    "overall_polarity": each.overall_polarity,
                })
            if (len(reports) == 0):
                return success_false(msg="You have not saved any sentiment reports yet")
            return {"success": True, "reports": reports[::-1], "msg": "Here are your saved reports"}

        except:
            return success_false()

    elif request.method == "POST":
        try:
            request_data = request.get_json()
            platform = request_data['platform']
            data = request_data['data']
            overall_polarity = request_data['overall_polarity']
            try:
                data_count = request_data['data_count']
                spam_count = request_data['spam_count']
                sarcasm_count = request_data['sarcasm_count']
                positive_count = request_data['positive_count']
                negative_count = request_data['negative_count']
                neutral_count = request_data['neutral_count']
            except:
                return success_false(msg="Please enter numeric values in numeric fields")

            # to carry further process only if data in post requests are valid
            # first will check if any unwanted format of data is provided
            if ((len(platform) > 20) or (len(platform) < 3)):
                return success_false(msg="Platform name size to be between 3 to 20")
            elif ((len(data) > 120) or (len(data) < 2)):
                return success_false(msg="Data source size to be between 2 to 20")
            elif ((len(overall_polarity) > 6) or (overall_polarity == "")):
                return success_false(msg="Invalid overall polarity format")

            # now if provided post request is valid
            user_email = get_jwt_identity()
            current_user = User.query.filter_by(email=user_email).first()

            report_to_save = Report(
                user_id=current_user.id,
                platform=platform,
                data=data,
                data_count=data_count,
                spam_count=spam_count,
                sarcasm_count=sarcasm_count,
                positive_count=positive_count,
                negative_count=negative_count,
                neutral_count=neutral_count,
                overall_polarity=overall_polarity
            )

            # saving the report object instance to report table
            db.session.add(report_to_save)
            db.session.commit()

            # now after saving report, providing response
            return {"success": True, "msg": "Report succesfully saved."}
        except:
            return success_false()
