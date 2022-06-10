from src.algo.manage_coupans import coupan_codes, get_youtube_api, get_twitter_api
import googleapiclient.discovery
import tweepy
from datetime import date, timedelta


# function to return list of wanted youtube comments
# the source of reference in making this function is below
# https://developers.google.com/youtube/v3/docs/commentThreads/list
def youtube_comments_extract(video_id, user_given_key, max_comments):
    api_service_name = "youtube"
    api_version = "v3"
    # to get required api key from another file
    developer_key = user_given_key
    if (user_given_key in coupan_codes):
        developer_key = get_youtube_api(user_given_key)
        # this will use my api keys if user provides coupan code

    extracted_comments = []  # will append all collected comments here
    data_to_return = []  # will store comments, title, thumnbnail

    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, developerKey=developer_key)

    request = youtube.commentThreads().list(
        part="snippet",
        maxResults=max_comments,
        order="relevance",
        videoId=video_id,
    )
    thumbnail_title_request = youtube.videos().list(part="snippet", id=video_id)

    thumbnail_title_response = thumbnail_title_request.execute()
    response = request.execute()

    filtered_response = response["items"]
    filtered_thumnail_response = thumbnail_title_response["items"]

    for each in filtered_response:
        extracted_comments.append(
            each["snippet"]["topLevelComment"]["snippet"]["textOriginal"])

    thumbnail = filtered_thumnail_response[0]["snippet"]["thumbnails"]["medium"]["url"]
    video_title = filtered_thumnail_response[0]["snippet"]["title"]

    while (("nextPageToken" in response) & (max_comments > 100)):
        request = youtube.commentThreads().list(
            part="snippet",
            maxResults=100,
            order="relevance",
            videoId=video_id,
            pageToken=response["nextPageToken"],
        )
        response = request.execute()
        filtered_response = response["items"]

        for each in filtered_response:
            extracted_comments.append(
                each["snippet"]["topLevelComment"]["snippet"]["textOriginal"])

        if (len(extracted_comments) >= max_comments):
            break

    data_to_return.append(extracted_comments)
    data_to_return.append(thumbnail)
    data_to_return.append(video_title)
    return data_to_return


# function to return list of wanted tweets
# referenced from tweepy documentation
# source: https://docs.tweepy.org/en/stable/api.html
def tweets_extract(searched_topic, max_tweets, c_key, c_secret, a_token, a_token_secret):
    extracted_tweets = []

    # authentication task here
    auth = tweepy.OAuthHandler(
        c_key, c_secret)
    auth.set_access_token(a_token,
                          a_token_secret)
    api = tweepy.API(auth, wait_on_rate_limit=True)

    coupens = coupan_codes
    #first the API tokens are taken from user
    ck = c_key
    cs = c_secret
    at = a_token
    ats = a_token_secret
    
    #if user has provided coupon instead of API token, the system will take default API tokens
    if((c_key in coupens) and ((c_key == c_secret) and (c_secret == a_token) and (a_token == a_token_secret))):
        # to use my keys if user uses coupan code
        keys = get_twitter_api(c_key)
        ck = keys["ck"]
        cs = keys["cs"]
        at = keys["at"]
        ats = keys["ats"]

    auth = tweepy.OAuthHandler(
            ck, cs)
    auth.set_access_token(at,ats)
    api = tweepy.API(auth, wait_on_rate_limit=True)

    # auth task done above either by coupan or by user's own keys
    query = searched_topic + " -filter:retweets -filter:links"
    yestarday_date = ((date.today()) - (timedelta(days=2)))
    for tweet in tweepy.Cursor(api.search_tweets, q=query,  # count=100,
                               lang="en",
                               tweet_mode="extended",
                               since=yestarday_date).items(max_tweets):
        extracted_tweets.append(tweet.full_text)

    return extracted_tweets
