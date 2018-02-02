Here is the Notebook:
https://github.com/hning86/pmchallenge/blob/master/02.Classification.ipynb

I took the text column, did the following preprocessing:
1. make all text lower case.
2. remove punctuation
3. stem
4. tokenize

then I applied Term Frequency vectorizer (didn't use IDF). i then tried a few algos (linear regression, tree, SVM), and found linear regression with default parameter actually give good results. Got a 0.95+ AUC so settled on that. Didn't have time to try parameter sweep, nor DNN.
