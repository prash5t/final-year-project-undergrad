from flask import Blueprint
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.database import User
from src.functions.field_validators import success_false

profile_blueprint = Blueprint('profile', __name__)


@profile_blueprint.route('/profile/', methods=['GET'])
@jwt_required()
def profile():
    try:
        user_email = get_jwt_identity()
        current_user = User.query.filter_by(email=user_email).first()
        return {
            "success": "true",
            "name": current_user.name,
            "email": current_user.email,
            "purpose": current_user.purpose,
            "analysis_count": str(current_user.analysis_count),
            "vacancy_count": str(current_user.vacancy_count)}
    except:
        return success_false()
