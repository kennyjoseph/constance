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

- The ```data``` directory would contain the full replication data necessary for the study.  Unfortunately, due to an issue with an NDA associated with the voter records, we are only able to release a partial subset of this data. Note that in order to show replicability, the file ```modeling.ipynb``` is designed to use this full dataset. In the future, we hope to address these issues via other means, we apologize for inconveniences. Below, we describe the ```annotation_data``` section, where we put data we are able to provide publicly.

# Public Annotations Files

Included in this data dump are three .csv files:

1. ```amt_annotations.csv``` contains the annotations for all AMT workers. 
2. ```development_annotations.csv``` contains manual annotations, agreed upon by 2-3 annotators, for a set of 254 development tweets
3. ```validation_annotations.csv``` contains manual annotations, agreed upon by 2-3 annotators, for a set of 318 validation tweets

The columns in each file are described below.

 - tid - Tweet ID of the anchor tweet
 - annotator - ID of the annotator
 - context - The additional context supplied to the annotator for this annotation
 - target -  The target of the tweet (Donald Trump or Hillary Clinton)
 - target_interaction - How the anchor tweet interacted with the target (@mention, text mention or no mention of the target)
 - timestamp - Timestamp of the anchor tweet
 - description - The Twitter user's profile description
 - tweet_text - The text of the anchor tweet
 - prev1 - The text of the most recent tweet from the user before the anchor tweet
 - prev2 - The text of the second most recent tweet from the user before the anchor tweet
 - pol_prev1 - The text of the most recent political tweet from the user before the anchor tweet
 - pol_prev2 - The text of the second most recent political tweet from the user before the anchor tweet
 - tertiary_rating - The tertiary rating of the tweet (collapsing "Definitely Supports/Opposes" with "Probably Supports/Opposes"). -1 imples "Pro-Trump", +1 implies "Pro-Clinton", a 0 is Neutral



# Requirements

The modeling code requires the following libraries to be installed from other github repositories:

- ```twitter_dm``` - http://github.com/kennyjoseph/twitter_dm
- ```vaderSentiment``` - My fork of the VADER sentiment tool - https://github.com/kennyjoseph/vaderSentiment
- Also required are ```sklearn```, ```gensim``` and ```numpy```; versions used (on Mac OSX) are given at the top of ```modeling.ipynb```.

The R code requires several standard libraries, listed at the top of the file

