import joblib
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
import pandas as pd
from src.algo.data_preprocessor import text_cleaner


# for production level, we need shorter processing time as much as possible
# so, making joblib's pickle file of the training model instead of performing calculation every time
def production_multinomial(testing_data, layer):
    # Deserializing CV's pkl file to object in runtime env
    pickled_count_vectorizer = CountVectorizer()
    if (layer == "sarcasm"):
        pickled_count_vectorizer = joblib.load(
            'src/algo/sarcasmpickle_countvectorizer.pkl')
    if (layer == "spam"):
        pickled_count_vectorizer = joblib.load(
            'src/algo/spampickle_countvectorizer.pkl')
    X_test = pickled_count_vectorizer.transform(testing_data)

    # decerializing MN's pkl file to object in runtime env
    pickled_multinomial_nv = MultinomialNB()
    if (layer == "sarcasm"):
        pickled_multinomial_nv = joblib.load(
            'src/algo/sarcasmpickle_multinomial.pkl')
    if (layer == "spam"):
        pickled_multinomial_nv = joblib.load(
            'src/algo/spampickle_multinomial.pkl')
    prediction_of_each_data = pickled_multinomial_nv.predict(
        X_test).tolist()  # converted numpyarray to list
    # returns list of 1 or 0 items where 1 for yes and 0 for no
    return prediction_of_each_data


# this debug function is needed to update our training model if new data are added to Sentimento's training datasets
# this function will perform count vectoization calculation for training data too which takes longer time than using pickled data
def debug_multinomial(testing_data, layer):
    training_data = None
    preprocessed_training_data = []
    training_label = []
    if (layer == "spam"):
        training_data = pd.read_csv('src.algo.spam_training.csv').values
        for each in training_data:
            preprocessed_training_data.append(text_cleaner(each[3]))
            training_label.append(each[4])
    if (layer == "sarcasm"):
        training_data = pd.read_csv('src.algo.sarcasm_training.csv').values
        for each in training_data:
            preprocessed_training_data.append(text_cleaner(each[0]))
            training_label.append(each[1])

    # now count vectorizing part
    cv = CountVectorizer(ngram_range=(1, 2))
    X_train = cv.fit_transform(preprocessed_training_data)

    # serialization
    # Save the model as a pickle in a file
    # unccoment this parts to dump in pickle file for production use
    if(layer == "spam"):
        joblib.dump(cv, 'spampickle_countvectorizer.pkl')
    if (layer == "sarcasm"):
        joblib.dump(cv, 'sarcasmpickle_countvectorizer.pkl')

    X_test = cv.transform(testing_data)
    mn = MultinomialNB()
    mn.fit(X_train, training_label)

    # serialization
    # unccoment this parts to dump in pickle file for production use
    if(layer == "spam"):
        joblib.dump(mn, 'spampickle_multinomial.pkl')
    if (layer == "sarcasm"):
        joblib.dump(mn, 'sarcasmpickle_multinomial.pkl')

    prediction_of_each_data = mn.predict(X_test).tolist()
    return prediction_of_each_data
