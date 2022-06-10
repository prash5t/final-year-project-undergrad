from src.algo.stopwords import customStopWords
from nltk.tokenize import RegexpTokenizer
from nltk.stem.porter import PorterStemmer


# function that takes list of raw texts and returns list of clean texts
def get_clean_texts(list_of_texts):
    list_of_clean_texts = []
    for each in list_of_texts:
        cleaned_text = text_cleaner(each)
        if (cleaned_text != ''):
            list_of_clean_texts.append(cleaned_text)
    return list_of_clean_texts


# function that takes a raw text and return clean text
def text_cleaner(text):
    tokenizer = RegexpTokenizer(r'\w+')
    ps = PorterStemmer()
    tokenized_text = tokenizer.tokenize(text.lower())
    clean_tokenized_text = []  # will add words after filtering stopwords
    for each_token in tokenized_text:
        if each_token not in customStopWords():
            # to remove stopword tokens
            clean_tokenized_text.append(each_token)
    stemmed_text = []
    for token in clean_tokenized_text:
        # appending the stemmed words in stemmed data
        stemmed_text.append(ps.stem(token))
    clean_data = " ".join(stemmed_text)  # changing tokens into one sentence
    return clean_data
