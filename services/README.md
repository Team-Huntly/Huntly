<h1 align="center">ML API </h1> 
<br>
<p>This folder contains the ML api endpoint which uses NLP and K-means clustering for Team Matching.</p>

<br/>

## Benchmark: 
![image](https://user-images.githubusercontent.com/72497928/195684906-1aa69251-c2e3-4921-9ddb-e10ff3d0082c.png)

<p> The model clusters around a 1000 user-profiles in around 4 seconds. It also allocates them into teams of particular team sizes<p>

<br/>

## Workflow: 

### 1. Data Preprocessing:
Here the text is tokenized and then converted into a vector using TF-IDF <i>(term frequency–inverse document frequency)</i> vectorizer.

### 2. K-means Clustering:
The vectorized text is then clustered using K-means clustering algorithm. The optimum number of clusters is determined by the use of silhouette scores evaluation over a range of K- values.

### 3. Huntly Team Allocation:
The clusters are then allocated into teams of particular team sizes. The team allocation is done by the use of a greedy algorithm which allocates the users with the highest similarity scores to the team first.