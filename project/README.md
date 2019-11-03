# Project

Propose a project to do while at The Data Incubator. We want to know
about your ability to think at a high level. Try to think of projects
that users or businesses will care about that are also relatively
unanalyzed. Here are some useful links about data sources [on our
blog](http://blog.thedataincubator.com/tag/data-sources/) as well as the
archive of data sources on Data is Plural. You can see some final
projects of previous Fellows [on our YouTube
Page](https://www.youtube.com/playlist?list=PLOE4k9MRzZanWmZ7MBrJFi7ZekYmVqEIV).

Propose a project that uses a large, publicly accessible
dataset. Explain your motivation for tackling this problem, discuss the
data source(s) you are using, and explain the analysis you are
performing. At a minimum, you will need to do enough exploratory data
analysis to convince someone that the project is viable and generate two
interesting non-trivial plots supporting this. *The most impressive
applicants have even finished a "rough draft" of their projects and have
derived non-obvious meaningful conclusions from their data*. Explain the
plots and give url links to them. For guidance on how to choose a
project, check out [this blog
post](http://blog.thedataincubator.com/2017/01/how-employers-judge-data-science-projects/).

## Project description

Inspection of showed that the company's follower-counts approximately
a linear relation with time (data not shown). For each company I
estimated the follower-counts change-rate and fractional "follower
counts" change-rate using a linear model, separated them by industry
sector, and estimated a z-score based on each sector's
distribution. 

The scatter plot in [Figure
1](https://github.com/sebajara/dataincubator_challenge/tree/master/project/FIG1.png),
puts in evidence that while some companies grow very fast in absolute
follower-counts compared to the rest, they do not necessarily grow
very fast relative to their size (values tend to the center in the
fractional follower-counts change-rate axis). However few companies
scape from this trend. Circled companies in [figure
1]((https://github.com/sebajara/dataincubator_challenge/tree/master/project/FIG1.png))
correspond to cases where the z-score is bigger than 0.5 in both
axis. In particular, those companies are: Aon (Financial Services), Eni
(Oil & Energy), Western Digital (Information Technology and Services),
GGP Inc. (Real Estate), YouTube (Internet), and Telefonica
(Telecommunications).

The aforementioned results suggest that follower-counts grow
approximately proportional to the follower-counts size

### Figures

**Figure 1:**
![Scatter Follower-counts change-rate z-score v/s Fractional-follower-counts change-rate z-score](/FIG1.png)

**Figure 2:**
![Blob plot](/FIG2.png)

### Data source

* [link](https://s3-us-west-2.amazonaws.com/documents.thinknum.com/dataset_dump/flikerqvnk/temp_datalab_records_linkedin_company.zip)

### File size

* 910 Mb

## Personal notes

A few comments specifically about the Linkedin data:
* Follower-rates per industry appear not to follow a Gaussian
  distribution, so the z-score is not the correct metric. Perhaps some
  Exponential, Poisson, or something like that. By parameterizing the
  distributions I could have estimated the likelihood of each value, and
  decide who is a "true" outlier.
* I was not able to use the "employees_on_platform" for anything
  useful. I found that is has a very poor correlation overall with
  "followers" over the same period of time, except for a few companies
  in the Banking industry.
* A general caveat of my approach is that I am looking at the rates
  over dissimilar periods of time. This is partially the limitation of
  the database, but I can't tell how much this may affect the results.
* Additional attributes accessible (in principle) from linkedin that
  could enrich the analysis: foundedOn, organizationStatus,
  organicFollowerCount v/s paidFollowerCount.
* Use cusip and isin in order to map company to economics databases.
* Key question is how fast the size of linkedin users and user active
  usage, and how they split for different industry categories.
  
For practising in the future:
* From the application: As you begin to formulate your capstone project,
  we encourage you to start exploring our blog posts on [data sources](https://blog.thedataincubator.com/tag/data-sources/) and
  [Data is Plural](https://tinyletter.com/data-is-plural/archive). You can see previous project videos on our [Youtube
  page](https://www.youtube.com/playlist?list=PLOE4k9MRzZanWmZ7MBrJFi7ZekYmVqEIV), and this blog post about how employers judge [data science
  projects](https://blog.thedataincubator.com/2017/01/how-employers-judge-data-science-projects/).
* [Data source 1](https://blog.thedataincubator.com/2014/10/data-sources-for-cool-data-science-projects-part-1/), 
  [Data source 2](https://blog.thedataincubator.com/2014/10/data-sources-for-cool-data-science-projects-part-2/),
  [Data source 3](https://blog.thedataincubator.com/2016/10/data-sources-for-cool-data-science-projects-part-3/),
  [Data source 4](https://blog.thedataincubator.com/2016/10/data-sources-for-cool-data-science-projects-part-4/),
  [Data source 5](https://blog.thedataincubator.com/2016/10/data-sources-for-cool-data-science-projects-part-5/)




