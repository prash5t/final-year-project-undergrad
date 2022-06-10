from src.algo.MultinomialNaiveBayes import production_multinomial
from src.algo.data_preprocessor import get_clean_texts
from nltk.sentiment.vader import SentimentIntensityAnalyzer


class Sentimento:

    # instance attribute, constructor
    def __init__(self, testing_data):
        self.testing_data = testing_data
        self.preprocessed_testing_data = get_clean_texts(testing_data)
        self.spam_detected_list = production_multinomial(
            self.preprocessed_testing_data, layer="spam")
        self.sarcasm_detected_list = production_multinomial(
            self.preprocessed_testing_data, layer="sarcasm")

    # to get total data taken to analyse
    def data_count(self):
        return len(self.preprocessed_testing_data)

    # to get total sarcasm/spam detected data's
    def layer_count(self):
        spam_count = 0
        sarcasm_count = 0
        layer_count = []
        for each in self.spam_detected_list:
            if each == 1:
                spam_count += 1
        for each in self.sarcasm_detected_list:
            if each == 1:
                sarcasm_count += 1
        layer_count.append(spam_count)
        layer_count.append(sarcasm_count)
        return layer_count  # index 0 for spam count and index 1 for sarcasm count

    # to get dict containing overall polarity, positive/negative count from provided data
    def overall_polarity(self):
        # considering -1 to -0.2 as negative, -0.2 to 0.2 as neutral and 0.2 to 1 as positive
        positive_count = 0
        negative_count = 0
        neutral_count = 0
        overall_polarity = 0.00000
        sid = SentimentIntensityAnalyzer()
        polarity_result = {}
        compound_polarity = 0
        sum_of_all_polarity = 0
        for each in self.preprocessed_testing_data:
            compound_polarity = sid.polarity_scores(each)["compound"]
            sum_of_all_polarity += compound_polarity
            if (compound_polarity <= -0.2):
                negative_count += 1
            elif (compound_polarity >= 0.2):
                positive_count += 1
            else:
                neutral_count += 1
        overall_polarity = (sum_of_all_polarity/self.data_count())
        polarity_result["positive_count"] = positive_count
        polarity_result["negative_count"] = negative_count
        polarity_result["neutral_count"] = neutral_count
        polarity_result["overall_polarity"] = overall_polarity
        return polarity_result
