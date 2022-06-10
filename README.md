# Sentimento ![Logo](https://play-lh.googleusercontent.com/nAaDRtLZlshur9o3A2XS_K__4I8m_yZ0gvucECrZtGoEGq8NUWE0Zj1vsyjALBui2Q=w35) Mobile Application ![Logo](https://play-lh.googleusercontent.com/1FikpccbOFZsDc5k9x1OQegu8A53tYcY8dkk_neZiCuOcdxWjzUcF3QebE_E9UQNiW4=w40)


**Sentimento**, a social media assisting platform with sentiment analysis feature is a
mobile application built using Flutter for front end, Flask for back end and Multinomial
Naive Bayes Theorem for the algorithmic part.

[![Click here to download from Google Play](./report-documentation/doc-assets/googleplay.png)](https://play.google.com/store/apps/details?id=com.awarself.sentimento)


Undergraduate Final Year Project of student **Prashant Ghimire** at
[![University Logo](./report-documentation/doc-assets/lmu.png)](https://www.londonmet.ac.uk/)
[![College Logo](./report-documentation/doc-assets/islington.png)](https://islington.edu.np/)

## Read Documentation

- [Final Report](./report-documentation/Final%20Report.pdf)
- [Risk Identification and Assessment Document](./report-documentation/Risk%20Identification%20and%20Assessment%20Document.pdf)
- [Software Requirement Specification](./report-documentation/Software%20Requirement%20Specification.pdf)
- [User Manual](./report-documentation/User%20Manual-%20Sentimento.pdf)
- [Weekly Task Information](./report-documentation/Weekly%20Task%20Information.pdf)


## Tech used

Sentimento uses a number of open source projects to work properly:

- [Flutter] - Cross platform application development kit
- [Flask] - Micro web framework written in Python
- [MultinomialNB] - Probabilistic Classifier with discrete features
- [NumPy] - Support for large, multi-dimensional arrays and matrices
- [Tweepy] - For accessing Twitter API
- [Google API Core] - For accessing YouTube API
- [Vs Code] - Used this code editor for the project
- [GitHub] - Used as version control
- [Postman API Platform] - Used to test built API's


## Installation

**Sentimento** [application] can either be used by installing from Google Play
#### **or**
can be used by cloning this [repository]

- To run the frontend application you are expected to have the [Flutter] setup ready on your system.

- To run the backend application, install the python dependencies as listed in requirements file.

```sh
cd backend-flask  # to go inside backend dir
virtualenv env    # to use separate environment to run 
sudo pip install -r requirements.txt # to get packages
source env/bin/activate # to start using environment
flask run --port=80 # to start the backend application
```

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:80
```

## License

Sentimento project as listed here in this [repository] is open source, but the [application] available on Google Play is licensed.

### **Thank you**
Please do email at hello@ghimireprashant.com.np for any purposes.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [Flutter]: <https://flutter.dev/>
   [Flask]: <https://flutter.dev/>
   [MultinomialNB]: <https://scikit-learn.org/stable/modules/generated/sklearn.naive_bayes.MultinomialNB.html>
   [NumPy]: <https://pypi.org/project/numpy/>
   [Tweepy]: <https://pypi.org/project/tweepy/>
   [Google API Core]: <https://pypi.org/project/google-api-core/>
   [VS Code]: <https://code.visualstudio.com/>
   [GitHub]: <https://github.com/>
   [Postman API Platform]: <https://www.postman.com/>
   [application]: <https://play.google.com/store/apps/details?id=com.awarself.sentimento>
   [repository]: <https://github.com/aprashantz/final-year-project-undergrad>
