import re


# function to validate email
def validate_email(email):
    regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    if(re.fullmatch(regex, email)):
        return True
    else:
        return False


# function that heps to send error msg when request is bad
def success_false(msg="Invalid API request"):
    return {"success": False, "msg": msg}
