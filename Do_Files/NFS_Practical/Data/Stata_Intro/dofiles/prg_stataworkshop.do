* Teagasc Stata workshop
* REDP, Teagasc, Athenry
* 10th & 11th October, 2013
 			
* Production and cost functions in Stata
*
*- Presenter:	Patrick R. Gillespie
*     		Walsh Fellow
*     		patrick.gillespie@teagasc.ie





* ---------------------------------------------------------------
* Introduction
* ---------------------------------------------------------------

/*

- By now, Fiona Thorne will have taken you through some of the  
   theory of the firm. 

- Our goal for the next hour will be to apply this theory, our
   knowledge of econometrics, and routines available in Stata 
   to analyse production and estimate efficiency in our panel of
   farms. 

- The family of models we'll use are called Stochastic Frontier (SF)
   models, also called Stochastic Frontier Analysis (SFA). The word
   "stochastic"  means "random", and frontier refers to the types of 
   functions we estimate, i.e. the functions which describe the 
   efficient frontier of production. 

- There are other ways to carry out this sort of analysis, but we 
   won't be concerned with those today.				

*/ 



* ---------------------------------------------------------------
* Background on setting up
* ---------------------------------------------------------------

/*

- From the previous discussion of theory, we know that production
   can be described as a process which transforms inputs into
   outputs. 

- This process can be summarised as a function y=f(x), with the x 
   representing quantities of inputs, the y representing
   quantities of output, and the f(.) part just meaning that
   there is some mathematical rule that will give us an answer 
   for how much y we get from a given amount of x. We tell the 
   function f( ) how much x we have, and it tells us y we should
   get back.

- We won't get into any more mathematical detail than we need to
   about these functions, but we do need to touch on the concept
   of linearity. The standard regression, Ordinary Least Squares,
   is one example of a linear model. Linear models have + signs
   in between their terms, and if you do and X-Y plot of one, you
   get a straight line. 

- The problem with using this sort of model is that we don't
   expect a linear production relationship generally. For
   example, theory gives us the law of diminishing marginal
   returns, so as we increase a given input by itself, we get a
   smaller and smaller increase in output. THAT'S NOT A LINE,
   THAT'S A CURVE!

- By far the most recognised function we use to describe
   production is the Cobb-Douglas production function, and we
   note that it is a non-linear function (the inputs are
   multiplied, and the parameters are exponents). The
   Cobb-Douglas (CD) is more aligned with economic theory than a
   linear function of inputs would be, but we cannot estimate a
   CD function in a standard linear model. We can, however,
   estimate a linear model of a "log transformed" CD function. 

- By "transform" we mean to carry out some mathematical operation
   on the variables on both sides of the equation we want to
   estimate. For example if we multiply all the variables on both
   sides by the same amount then the equation will remain
   "balanced" and everything is fine (and hopefully more
   convenient). It would be convenient to transform our
   production function in such a way that we could estimate its 
   parameters in a linear model. 

- The particular transformation that accomplishes this is the
   log transformation. Briefly put, a log is the power you must
   raise some base number to to arrive at a target number. For
   example, the log in base 10 of the number 100 is 2, because
   10^2 is 100. We don't generally use 10 as the base number; we
   usually use Euler's number (e) as the base. This sort of log is
   known as the natural log and it is abbreviated ln(), and you 
   will see it used in the code below. 
   
   Crucially, a log transformation of the CD changes it from this
   non-linear function... 

 	y = K^Beta_K * L^Beta_L

   to this linear one...

	ln(y) = Beta_K*ln(K) + Beta_L*ln(L).

  As a rule, when you are estimating production or cost
   functions, you will be using this type of specification,
   called the log-log specification because you have performed a
   log transformation on both sides of the equation. 

  The only other important aspect to consider concerning the
   log-log is the interpretation of the resulting parameter
   estimates (the Beta estimates), but we'll get into that when
   we go over the output of our model. 

*/





* ---------------------------------------------------------------
* Loading the dataset
* ---------------------------------------------------------------

* Let's give the usual header commands we're used to by now.


clear
clear matrix
set mem 500m
set matsize 800
set more off



/*
 Let's navigate Stata to the correct folder for our work. 
*/



cd D:\Data\Stata_Intro



/*
 We'll use the same data we've been using thus far. We should have
  a folder on D:\ called origdata, and in there we should have the
  dataset called nfspractical.dta. If there are spaces in either
  the folders or filenames you're specifying, you would then need
  to put the path to the file in "". 

 We've changed to D:\, so we can leave that bit off if we like. 
*/


use origdata/nfspractical.dta, clear 





* ---------------------------------------------------------------
* Setting up the data
* ---------------------------------------------------------------

/*

 Let's suppose that we want to estimate a CD production function
  for dairying. Again, this function will describe the output
  in terms of inputs, so we need measures of output and input
  quantities. In our data we can utilise the following: 

	- doslmkgl 	= Milk sales (in litres/gallons)
	- dpnolu   	= Dairy livestock units (herd size) 
	- daforare 	= Dairy forage area
	- HOURS_WORKED  = Labour

 We can think of these in terms of the traditional input
  decomposition from microeconomics of land (forage area),
  labour (labour), and capital (herd size in LUs).

 The first three variables are specific to the dairy enterprise,
  but total labour can be devoted to multiple enterprises on the
  farm, so we'll want to only count some fraction of that towards
  dairying. We can create an allocation weight on the basis of
  livestock units, as this is likely more representative of work
  time than e.g. gross output which can vary without any change
  in labour allocation. 

*/


* Let's start recording our work in a log, but first make sure 
*  that you close any open log with the following
capture log close
log using "production.txt", replace text

		* <capture> forces Stata to ignore an error from a 
		*  command. In this case, if no log is open 
		*  <log close> would give an error which we can safely 
		*  ignore. If a log is open, we won't get an error, 
		*  and the log will be closed before we try to open our 
		*  new log (exactly what we want to happen).

		
* Now let's create our allocation weight and label it.		
gen dpnolu_sh = dpnolu/ftotallu
label var dpnolu_sh "Share of dairy LU's (allocation weight)"



/*
 Now apply this allocation weight to labour to get hours devoted
 to dairying, and all of our variables will be at the enterprise
 level, i.e. the dairy business and only the dairy business. 
*/



gen dylabour =  HOURS_WORKED * dpnolu_sh 
label var dylabour "Total hours of work allocated to dairy"



/*
 Since we know that we'll be using a log-log specification, we 
  should generate the logged variables for the model, but we'll
  need to do a bit of data cleaning first. 

 You can't take the log of any number that is <= 0, so we need
  to drop such observations from the data first.
*/



* Get some basic info on the dataset
describe, short
* Drop the 0 and negative obs
drop if doslmkgl <= 0
drop if dpnolu   <= 0
drop if daforare <= 0
drop if dylabour <= 0
* Get info again for comparison
describe, short



/*
 Now that we have the data cleaned up, we can go ahead and 
  generate our logged vars. It's a good idea to keep most of the
  variable name of the original variable intact, and add 
  something like "ln" at the front or back of the name to
  indicate that it's a logged variable. The convention for most 
  of the code I've seen in REDP puts the ln at the front. Let's 
  start with volume of milk output.
*/



gen lndoslmkgl = ln(doslmkgl)
* It's good practice to label vars as you create them.
label var lndoslmkgl "Logged Milk sales (quantity)"

 
/*
 We see that the syntax for creating a logged variable is very 
  easy; it's just the usual gen command, and we use the function
  ln(varname) to calculate the logged value for each observation
  of dotomkgl. 

 We can move on to inputs. For dairy farms, important outputs 
  will include feed, fertiliser  herd size, and dairy forage
  area. 
*/



gen lndaforare  = ln(daforare)
label var lndaforare 	"Logged dairy forage area (hectares)"

gen lndylabour	= ln(dylabour)
label var lndylabour 	"Logged dairy labour (hours)"

gen lndpnolu 	= ln(dpnolu)
label var lndpnolu		"Logged dairy LU's"




* ---------------------------------------------------------------
* Models of production functions and frontiers
* ---------------------------------------------------------------

/*
 With log transformed variables in hand, let's estimate a simple 
  production function using just the typical the standard panel
  models. 
*/



* A fixed effect model of production
xtreg lndoslmkgl lndaforare lndylabour lndpnolu, fe
* Use <predict> to record predicted values of xb and u 
predict xb_fe, xb
predict u_fe, u



* A random effect model of production 
xtreg lndoslmkgl lndaforare lndylabour lndpnolu, re
* Record this model's estimates of xb and u. 
predict xb_re, xb
predict u_re, u



/*
 The models above describe the "average" production relationship 
  between inputs and output for all farms in the sample. If we
  want to move to estimating a production frontier, then we can
  change our command from <xtreg> to <xtfrontier> which is
  Stata's preloaded panel SF command. <xtfrontier>, requires us
  to specify one of two options (at a minimum). These are "ti"
  (time-invariant) or "tvd" (time-varying decay), which refer to
  the assumptions we make about the nature of inefficiency (the u
  parameter).
*/



* Review the help file for the command.
*help xtfrontier



* Time-invariant SF model
xtfrontier lndoslmkgl lndaforare lndylabour lndpnolu, ti
* Record this model's estimates of xb,  u (inefficiency), and te. 
predict xb_sf_ti, xb
predict u_sf_ti, u
* For <predict> now has the te option to obtain TE estimates.
predict te_sf_ti, te
* But we have to use the following to get estimates of v.
gen v_sf_ti = lndoslmkgl - xb_sf_ti + u_sf_ti



* Time-varying decay model
xtfrontier lndoslmkgl lndaforare lndylabour lndpnolu, tvd
* Record this model's estimates of xb and u. 
predict xb_sf_tvd, xb
predict u_sf_tvd, u
predict te_sf_tvd, te
gen v_sf_tvd = lndoslmkgl - xb_sf_ti + u_sf_ti


* A handy option for running tests on the coefficients ... 
xtfrontier lndoslmkgl lndaforare lndylabour lndpnolu, tvd coeflegend

* you should now see the codes you use to access coefficient 
*  estimates. It is, however, much easier to use the <lincom> 
*  command

* help lincom

lincom lndaforare + lndylabour + lndpnolu 

* Let's test for CRS...
lincom lndaforare + lndylabour + lndpnolu - 1

* If we feel justified, we can impose CRS by first defining the
*  constraint...
constraint 1 lndaforare + lndylabour + lndpnolu = 1

* ... and then rerunning the model as a constrained optimisation 
*xtfrontier lndoslmkgl lndaforare lndylabour lndpnolu, tvd constraints(1)

* You can try the constrained model above by removing the leading
*  "*" from the line, but you'll find that the model doesn't 
*  converge - it can't find the parameters that give the maximum
*  likelihood because the likelihood function has the wrong shape.
*  This is what Stata is trying to tell you when it says "not concave". 
*  When this happens press the Break button at the top (red circle
*  with an X). You'll need to change the specification in some 
*  way to get your results.

*****************************************************************
* NOTE: The messages "not concave" and "backed up" will show
*  up from time to time as your model iterates. This is okay, 
*  provided that 
	* it doesn't happen on EVERY iteration (as it does above)
	* it eventually stops and 
	* the LAST ITERATION has neither message attached to it. 
* You can't trust the output when you get one of these warnings
*  on the very last iteration, even though the model seemed to 
*  finish. Instead, go back and respecify your model.
*****************************************************************





* ---------------------------------------------------------------
* Interpretting the results, and some postestimation
* ---------------------------------------------------------------

/* 

 The interpretation of the beta coefficients is the same as it
  is for a typical log-log model, i.e. the coefficients are
  elasticities. Simply put, the beta for a given variable
  represents the percentage change observed in the dependent
  variable (milk output here) for a 1 percent increase in the
  coefficient's variable (e.g. lndaforare which is dairy
  forage area). 

 The interpretation changes slightly if we have untransformed
  variables on the right side (these will be control variables,
  not parts of the actual production function). We might for
  instance include dummy variables for different soil types, as
  production from one soil type to another may be fundamentally
  different. In this we must exponentiate the coefficient to
  interpret its magnitude on output using the exp() function in
  Stata, as in

*display exp(insertcoefficienthere)

 This will be the case for all untransformed variables in any
  log-log model. 

 If we compare the beta estimates (the slope parameters) for the
  standard panel models and the SF models, we see that they are
  very highly correlated. This is by design, as we assume the
  magnitude of the effects of inputs on outputs are basically the
  same for the most efficient producers as they are for the rest
  of the sample; it's the intercepts where they differ due to
  their unobserved "inefficiency". This leads the linear
  projection of output to be highly correlated for all models.

*/
corr xb*

/*
 Despite this, and despite the similarity of the commands (and
  to some degree, the output) there are important differences in
  the interpretation of the parameters. In normal FE and RE 
  models "u" is the individual effect, and it can be either
  positive of negative. In SF models ,however, "u"  represents
  inefficiency, and its sign will depend on whether we're
  estimating a production (stictly negative sign) or cost
  function (strictly positive sign); this is a direct consequence
  of production theory. We can see this in the correlation matrix
  of the estimates of u. 
*/
corr u*


/* 
 SF models require assumptions about the distribution of both the
  inefficiency term and the random error term. The ineffiency
  term is always assumed to be one-sided (usually half-normal or
  truncated normal), whereas the random noise components is
  assumed to be normal with mean 0. We can see this by generating 
  a few stata plots of the terms. 
*/



* Create a kernel density plot (similar to a histogram)
kdensity u_sf_ti

* save the graph in Stata format (only viewable in Stata)
graph save dist_u_sf_ti, replace

* export it to pdf (viewable in any pdf viewer)
graph export dist_u_sf_ti.wmf, replace

* same as above, but this time plotting v, rather than u
kdensity v_sf_ti
graph save dist_v_sf_ti, replace
graph export dist_v_sf_ti.wmf, replace

* Close the last graph you saved (it's still active now)
graph drop _all



/* 
 If you look in the root of your D:\ drive you'll find the 
  plots waiting for your inspection.

 An important thing to check is that the u parameter's
  distribution is right-skewed (has a longer right tail). This
  shows that more producers will have low inefficiency than will
  have high inefficiency, which is in line with theory. If the u
  term  has the wrong skew, we have doubts as to whether we are
  accurately depicting production at all. Some software won't
  even allow completion of the model in this case, and instead
  throws an error. 

 Unlike the standard panel models for "average" production and
  cost functions, SF models of frontier functions give us the
  ability to estimate average, and even firm level efficiency. We
  did this above using the <predict> command with the option "te".
  TE is technical efficiency, and it describes the proportion of
  output that a producer achieves relative to what a perfectly
  efficiency producer would have achieved in the same
  circumstances. Having predicted this variable means that we can
  now investigate relationships between TE and other variables in
  our data.
*/


* Stats of TE for farmers with/without contact with Teagasc advisory
tabstat te_sf_ti, by(teagasc) stats(mean p50 min max)


/*
 Contact with teagasc advisors seems to be positively associated
 with higher levels of efficiency. We can test this hypothesis
 using a t test. 
*/
ttest te_sf_ti, by(teagasc)



/*
 And we can see that indeed the null hypothesis of no difference
  in the mean efficiency for each group is rejected, hence we
  accept the alternative hypothesis that TE differs across the
  two groups. Note that we are not implying causality, we are
  merely demonstrating that there is in fact a difference. In
  fact, we can say that the group with contact from an advisor
  has higher TE scores on average, as that hypothesis was also
  tested by the command. To establish whether or not contact with
  an advisor is driving efficiency we need to employ regression
  techniques.

 Identifying the drivers of efficiency is a topic of much
  interest, and early attempts at tackling this question simply
  regressed the estimates of TE on a selection of potential
  explanatory variables. However, this 2 step procedure has been 
  shown to be biased, hence recent approaches have estimated the
  frontier function and the efficiency effects in a single step.
  However, Stata does not have that capability "out-of-the-box".
  Instead, we must use a user-written package called <sfpanel>.
  We won't have time to review this today, but the package is
  easily installed with the following command

* findit sfpanel

  ... and clicking on the appropriate links in the Stata pop-up
  window. 

 There is a good help file included, and a pdf is also available
  online, but if you've gotten this far, then you'll want to
  spend more time reading Coelli et al (2005) or Lovell and
  Kumbhakar (2000) before moving on. The challenge is in 
  understanding the theory behind these models; the commands 
  themselves are similar to the ones we've already learned, and
  any additional options made available to you are easy to pick
  up from the help files.

*/





* ---------------------------------------------------------------
* Models of cost functions and frontiers
* ---------------------------------------------------------------

/*

 Much of the preceding discussion applies equally to cost models
  as it does to production models. In fact, the commands are 
  exactly the same for the standard panel models, and you can get
  a cost frontier from <xtfrontier> or <sfpanel> simply by adding
  the "cost" option to the commmand (all this does is change the
  sign of the u term... see discussion above).

 The biggest difference in specifying a cost function is the
  selection of variables that enter the specification. Recall the
  general form of the production function was 

	y=f(x)

  For a cost function, we relate expenditure (E) to output
   quantities (y) and input prices (w). So we would have, 

 	E = c(w,y)

  or in english, expenditure is a function c of w and y.
 
 Therefore, we can't simply take our production function from
  above and add the "cost" option, because this would be
  meaningless. We should instead find a selection of input prices
  we want to specify (e.g. wages, land rental or land value, and
  net stock changes). 

 Once we've selected our measures of expenditure (in some
  currency), volume of y, and input prices (again in currency),
  the estimation of the model proceeds as above, with the cost
  option added for the SF models as in, 

 xtfrontier varlist, ti  cost

 or...

 xtfrontier varlist, tvd cost

 where varlist is your list of appropriate variables.

 Interpretation of the results is identical with one exception.
  Our measure of efficiency is now cost efficiency (CE). Cost 
  efficiency is just TE but adjusted for how efficiently (or not)
  a firm chooses its inputs to minimise cost (i.e. chooses the
  lowest cost inputs to achieve technically efficienct production).

  CE is what's reported by Stata when you use <predict> with the
   te option after estimating a cost frontier (the calculation is
   the same, it's only the interpretation that's different). At
   best, a firm's CE = TE if it's perfectly efficient, but in 
   most cases CE<TE indicating some excess cost at the stage of
   choosing the "correct" input bundle.

*/

log close
