Here is the Notebook:
https://github.com/hning86/pmchallenge/blob/master/01.Regression.ipynb

I split the data into 3 column groups:
1. 3 categorical columns: I applied one-hot encoding
2. 1 text column: I applied term-frequency vectorization
3. 103 integer columns: I normalized them to 0-1.

Then I tried a few algos and found gradient boosted tree regression gives decent performance. I didn't have time to go into parameter tunining. Just used the default parameters and got a ~1.2 L1 error.
