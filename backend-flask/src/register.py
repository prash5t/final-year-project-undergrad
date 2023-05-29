from flask import Blueprint, request
from werkzeug.security import generate_password_hash
from src.database import User, db
from src.functions.field_validators import validate_email, success_false
from flask_jwt_extended import create_access_token

register_blueprint = Blueprint('register', __name__)


@register_blueprint.route('/register/', methods=['POST'])
def register():
    request_data = request.get_json()
    try:
        name = request_data['name']
        email = request_data['email']
        password = request_data['password']
        purpose = request_data['purpose']

        # to carry further process only if data in post requests are valid
        # first will check if any unwanted format of data is provided
        if len(name) > 55:
            return success_false(msg="Name should be less than 55chars")
        elif len(name) < 5:
            return success_false(msg="Name should be at least 5chars")
        elif len(password) < 6:
            return success_false(msg="Password should be at least 6chars")
        elif len(email) > 80:
            return success_false(msg="Email should be less than 80chars")
        elif len(purpose) > 30:
            return success_false(msg="Purpose should be less than 30chars")
        elif not validate_email(email):
            return success_false(msg="Please enter a valid email address")

        # now moving to database querying if provided registration data format is correct
        elif User.query.filter_by(email=email).first() is not None:
            # if user with this email already exist
            return success_false(msg="This email is already in use")

        # if registration request is valid, moving to registration stage from here
        hashed_password = generate_password_hash(password)
        user_to_register = User(name=name, email=email,
                                password=hashed_password, purpose=purpose)
        # inserting user data to user table
        db.session.add(user_to_register)
        db.session.commit()  # saving database instance

        access_token = create_access_token(
            identity=email, expires_delta=False)

        # responding user that user is now registered
        return {"success": True, "msg": "User is now registered", "email": email, "name": name, "access_token": access_token}

    except:
        return success_false()
