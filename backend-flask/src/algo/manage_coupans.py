"""
will store coupan codes in python list
so that users can use sentimento app using coupan code
if they dont want to use their own api keys
For better practice, You can also use a separate file to store keys and assign them in this file
"""

coupan_codes = ["lifeisgood", "happylearning", "opensource"]

"""
Third parties like YouTube, Twitter limits on how much data can be accesed using one API key within certain duration
So, to reduce the chances of consuming full usage of one api key,
multiple keys are used to distribute traffic usage to many keys
"""

def get_youtube_api(user_key):

    if (user_key == coupan_codes[0]):
        return "assign youtube api here"

    if (user_key == coupan_codes[1]):
        return "assign youtube api here"

    if (user_key == coupan_codes[2]):
        return "assign youtube api here"



def get_twitter_api(coupan):
    if (coupan == coupan_codes[2]):
        return {
            "ck": "assign twitter consumer key here",
            "cs": "assign twitter consumer secret here",
            "at": "assign twitter access token here",
            "ats": "assign twitter access token secret here"
        }

