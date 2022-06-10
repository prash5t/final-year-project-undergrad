from flask import Blueprint, request
from src.database import User, Vacancy, db
from flask_jwt_extended import jwt_required, get_jwt_identity
from src.functions.field_validators import validate_email, success_false

vacancy_blueprint = Blueprint('vacancy', __name__)


@vacancy_blueprint.route('/vacancy/', methods=['POST', 'GET', 'DELETE'])
@jwt_required()
def vacancy():
    if request.method == "GET":
        try:
            user_email = get_jwt_identity()
            current_user = User.query.filter_by(email=user_email).first()
            user_vacancies = Vacancy.query.filter_by(user_id=current_user.id)
            return return_vacancies(user_vacancies, msg_when_zero="You have not posted any open vacancies now")
        except:
            return success_false()

    if request.method == "DELETE":
        try:
            user_email = get_jwt_identity()
            current_user = User.query.filter_by(email=user_email).first()
            post_id = request.args.get('id')
            post = Vacancy.query.get(post_id)
            # will check if user tries to delete other user's post
            if (post.user_id != current_user.id):
                return success_false(msg="You are not authorized")
            # will move further  if user wants to delete own post only
            db.session.delete(post)
            # to update the current open vacancies of the particular user
            current_user.vacancy_count -= 1
            db.session.commit()
            return {"success": "true", "msg": "Post deleted"}
        except:
            return success_false()

    if request.method == "POST":
        try:
            user_email = get_jwt_identity()
            current_user = User.query.filter_by(email=user_email).first()

            # first will check if user already has 5 open vacancies
            if (current_user.vacancy_count == 5):
                return success_false(msg="You already have 5 open posts. Delete previous one to add new")

            request_data = request.get_json()
            title = request_data['title']
            contact_email = request_data['contact_email']
            contact_number = request_data['contact_number']
            description = request_data['description']
            work_hr = request_data['work_hr']
            wage_hr = request_data['wage_hr']
            is_negotiable = request_data['is_negotiable']
            is_vacancy = request_data['is_vacancy']

            # now checking post request values before inserting to db
            if(len(title) > 50 or len(title) < 3):
                return success_false(msg="The length of title must be between 3 to 50")
            if not validate_email(contact_email):
                return {"success": "false", "msg": "Please enter a valid email address"}
            if(len(contact_email) > 80):
                return {"success": "false", "msg": "Email should not be longer than 80chars"}
            if(len(contact_number) > 20 or len(contact_number) < 5):
                return {"success": "false", "msg": "The length of contact number must be between 5 to 20"}
            if(len(description) > 500 or len(description) < 5):
                return {"success": "false", "msg": "Length of description must be between 5 to 120"}
            if (type(work_hr) is not int):
                return {"success": "false", "msg": "Please enter working hour in numeric form"}
            if ((type(is_negotiable) is not bool) or (type(is_vacancy) is not bool)):
                return success_false(msg="Boolean 0 or 1 is only acceptable in negotiability and vacancy status")

            # now moving to db insertion part after post req validation
            vacancy_to_save = Vacancy(
                user_id=current_user.id,
                title=title,
                contact_email=contact_email,
                contact_number=contact_number,
                description=description,
                work_hr=work_hr,
                wage_hr=wage_hr,
                is_negotiable=is_negotiable,
                is_vacancy=is_vacancy
            )

            # saving the vacancy object instance to vacancy table
            current_user.vacancy_count += 1  # to allow only 5 open vacancies per user
            db.session.add(vacancy_to_save)
            db.session.commit()

            # now after saving vacancy, providing response
            return {"success": "true", "msg": "Your posted vacancy is now publicly available."}

        except:
            return success_false()


@ vacancy_blueprint.route('/vacancy/all/', methods=['GET'])
def vacancy_all():
    try:
        type_of_vacancy = request.args.get('filter')
        # if user want to access open vacancies
        if type_of_vacancy == "vacancy":
            open_vacancies = Vacancy.query.filter_by(is_vacancy=1)
            return return_vacancies(open_vacancies, msg_when_zero="There are no any open vacancies at the moment.")
        # if user want to access open freelancers
        if type_of_vacancy == "freelancer":
            available_freelancers = Vacancy.query.filter_by(is_vacancy=0)
            return return_vacancies(available_freelancers, msg_when_zero="There are no any available freelancers at the moment.")
        else:
            return success_false(msg="Please provide valid parameters")
    except:
        return success_false()


# to make it usable in all vacancy or user only vacancy case both
def return_vacancies(retrieved_vacancies, msg_when_zero):
    vacancies = []
    for each in retrieved_vacancies:
        vacancies.append({
            "id": each.id,
            "title": each.title,
            "contact_email": each.contact_email,
            "contact_number": each.contact_number,
            "description": each.description,
            "work_hr": each.work_hr,
            "wage_hr": each.wage_hr,
            "is_negotiable": each.is_negotiable,
            "is_vacancy": each.is_vacancy
        })
    if (len(vacancies) == 0):
        return success_false(msg=msg_when_zero)

    return {"success": "true", "vacancies": vacancies, "msg": "Vacancies loaded succesfully"}
