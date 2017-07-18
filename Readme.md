# ConStance

This code base provides replication materials for the paper below:

```
@inproceedings{joseph2017constance,
  title={ConStance: Modeling Annotation Contexts to Improve Stance Classification},
  author={Joseph, Kenneth and Friedland, Lisa and Tsur, Oren and Hobbs, William and Lazer, David},
  booktitle={EMNLP},
  year={2017}
}
```

If you use this code or the provided annotation data, (pretty) please reference the paper.  If you have questions about the code or the data (see below for access and details), please email me!

# Structure

- The bulk of the code for all sections of the paper (i.e. the comparison of the baseline methods and the ConStance algorithm) is contained within the jupyter notebook ```modeling.ipynb```. 

- The file ```results.R``` performs the significance tests and generates the image for the gamma parameter in the paper.

- The ```results``` directory gives the results that we generated using this public repository on our system (described below). Anecdotally, we saw slightly different results with a newer version of ```sklearn```, but significance tests nor the underlying conclusions of the paper changed, so we went with what we could consistently replicate on commodity hardware (i.e. my laptop).

- The ```data``` directory contains ...


# Requirements

The modeling code requires the following libraries to be installed from other github repositories:

- ```twitter_dm``` - github.com/kennyjoseph/twitter_dm
- ```vaderSentiment``` - My fork of the VADER sentiment tool - https://github.com/kennyjoseph/vaderSentiment
- Also required are ```sklearn```, ```gensim``` and ```numpy```; versions used (on Mac OSX) are given at the top of ```modeling.ipynb```.

The R code requires several standard libraries, listed at the top of the file

