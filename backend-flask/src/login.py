from flask import Blueprint, request
from src.functions.field_validators import validate_email, success_false
from src.database import User
from werkzeug.security import check_password_hash
from flask_jwt_extended import create_access_token

login_blueprint = Blueprint('login', __name__)


@login_blueprint.route('/login/', methods=['POST'])
def login():
    request_data = request.get_json()
    try:
        email = request_data['email']
        password = request_data['password']

        # to carry further process only if data in post requests are valid
        # first will check if any unwanted format of data is provided
        if len(password) < 6:
            return success_false(msg="Password should be at least 6chars")
        if len(email) > 80:
            return success_false(msg="Email should be less than 80chars")
        if not validate_email(email):
            return success_false(msg="Please enter a valid email address")

        # now moving to database querying if provided registration data format is correct
        trying_user = User.query.filter_by(email=email).first()

        if trying_user:
            # will check password if that user exists
            password_is_correct = check_password_hash(
                trying_user.password, password)

            if password_is_correct:
                access_token = create_access_token(
                    identity=email, expires_delta=False)
                return {"success": "true", "msg": "Login succesful", "access_token": access_token, "name": trying_user.name, "email": trying_user.email}
            # if passoword is wrong
            else:
                return success_false(msg="Please provide correct password")
        # if trying user does not exist
        else:
            return success_false(msg="User with this email does not exist in our system")

    except:
        return success_false()
