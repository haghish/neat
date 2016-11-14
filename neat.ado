/*** DO NOT EDIT THIS LINE -----------------------------------------------------
Version: 1.0.0
Title: neat
Description: a layout engine that alters the duplicated observations in 2 variables 
in order to display them in a geometrically appealing way within scatter plots 
instead of adding random noise using the {help scatter##jitter_options:jitter} 
option. 
----------------------------------------------------- DO NOT EDIT THIS LINE ***/


/***
Syntax
======

{p 8 16 2}
{cmd: neat} {varlist} [{cmd:,} {it:options}]
{p_end}

{* the new Stata help format of putting detail before generality}{...}
{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt l:ayout(name)}}defines the layout engine, which can be 
{bf:geo} (default) or {bf:size}{p_end}
{synopt:{opt s:ave(name)}}saves the new dataset{p_end}
{synopt:{opt dsize(num)}}changes the distance scale between the duplicated observations. 
the default is {bf:5} {p_end}
{synopt:{opt msize(num)}}takes the size (numeric only) of the marker into account. 
the default value is {bf:1.5}{p_end}
{synopt:{opt xsize(num)}}takes the size of the X-axis into account. The 
default value is {bf:5.5}{p_end}
{synopt:{opt ysize(num)}}takes the size of the Y-axis into account. The default 
value is {bf:4}.{p_end}
{synoptline}
{p2colreset}{...}

__msize__, __xsize__, and __ysize__ are influencing the calculations 
for altering the variables. They should be identical to the values specified 
in the {help scatter} plot, since they can influence data visualization. For 
example, increasing the width of the scatter plot using the __xsize__ will 
enlarge the distance between the observations in the X-axis. Specifying these 
options helps the __neat__ engine to prepare the variables for a scatter plot 
with a particular scale.

Description
===========

duplicated observations will appear as a single point in scatter plot. Stata 
provide the {help scatter##jitter_options:jitter} option in scatter plot to add 
random noise to the data, which help to see the duplicated data near one another, 
but disrupts the overall pattern of the scatter plot if the data is discreet. 

The __neat__ engine deals with visualizing the duplicated observations by providing 
two layout solutions. The default layout is __geo__ which creates geometric 
shapes with duplicated observations. The engine can illustrate up to seven 
duplicated observations. If the duplications are more than 7 they appear the 
same as 7 duplications. Therefore, this engine is best when the data is not 
including many duplications. 

When number of duplications is so high, the __neat__ engine provides the 
__size__ layout that uses the amount of duplications as a weight for enlarging 
the points with duplications. As a result, the scatter plot will have points 
with different size, based on how many observations are in each point. 
to draw such a scatter plot you need to use the 
[multiscatter](http://www) command (see the examples below). 

Example
=================

The examples can be found on [GitHub](http://www). 

Author
======

E. F. Haghish   
Department of Mathematics and Computer Science (IMADA)    
University of Southern Denmark    

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/




cap program drop neat
program neat
	version 12
	syntax varlist, [Layout(name) xsize(numlist max=1) ysize(numlist max=1)		///
	dsize(numlist max=1)  msize(numlist max=1) Save(name) ] 
	
	// Defaults
	// -----------------------------------------------------------------------

	if missing("`dsize'") {
		scalar x = 0.05
	}
	else {
		scalar x = `dsize'/100
	}
	if missing("`layout'") {
		local layout geo
	}
	if missing("`xsize'") {
		local xsize 5.5
	}
	else if "`xsize'" == "1" {
		local xsize 2 						//minimum! 
	}
	if missing("`ysize'") {
		local ysize 4
	}
	if missing("`msize'") {
		local msize 1.5
	}
	// get variables
	local v1 `1'
	local v2 `2'
	
	local magnifier 1.25
	
	// Engine
	// -----------------------------------------------------------------------
	tempvar dup
	quietly duplicates tag v1 v2, generate(`dup')
	
	if "`layout'" == "geo" {
		
		quietly summarize `v1'
		local rangey = `r(max)' - `r(min)' 
		quietly summarize `v2'
		local rangex = `r(max)' - `r(min)' 
		
		//make sure it works even if range is 0
		if "`rangex'" == "0" | "`rangey'" == "0" {
			di as err "range of `v1' or `v2' is zero"
			err 198
		}
		
		
		
		sort `dup' `varlist' 
		
		local N 1
		
		//ignore observations with no duplicates
		while `dup'[`N'] == 0 {
			local N = `++N'
		}
		
		//if dup == 1 sort them on X-axis
		while `dup'[`N'] == 1 {
			local next = `N'+1
			scalar obs2 = `v2'[`N']
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			
			local x1 = `x1'*0.75
			
			capture replace `v2' = (obs2 - `x1') in `N'
			capture replace `v2' = (obs2 + `x1') in `next'
			local N = `N'+2
		}
		
		//if dup == 2 sort the first 2 on X and the 3rd between them but up
		while `dup'[`N'] == 2 {
			local next = `N'+1
			local next2 = `N'+2
			scalar obs1 = `v1'[`N']
			scalar obs2 = `v2'[`N']
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			local y1 = ((x*`rangey')/`ysize')*((`msize'/1.5))
			
			local x1 = `x1'*0.75
			local y1 = `y1'*0.75
			
			capture replace `v2' = (obs2 - `x1') in `N'
			capture replace `v2' = (obs2 + `x1') in `next'
	
			//push the other points down
			capture replace `v1' = (obs1 - `y1') in `N'
			capture replace `v1' = (obs1 - `y1') in `next'
			
			//the other point keeps its X, but gets a Y shift
			capture replace `v1' = (obs1 + `y1') in `next2'
			
			local N = `N'+3
		}
		
		//if dup == 3 sort the first and second 2 obs with just diff Ys 
		while `dup'[`N'] == 3 {
			local next = `N'+1
			local next2 = `N'+2
			local next3 = `N'+3
			scalar obs1 = `v1'[`N']
			scalar obs2 = `v2'[`N']
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			local y1 = ((x*`rangey')/`ysize')*((`msize'/1.5))
			
			local x1 = `x1'*0.85
			local y1 = `y1'*0.85
			
			capture replace `v2' = (obs2 - `x1') in `N'
			capture replace `v1' = (obs1 - `y1') in `N'
			
			capture replace `v2' = (obs2 + `x1') in `next'
			capture replace `v1' = (obs1 - `y1') in `next'
			
			capture replace `v2' = (obs2 - `x1') in `next2'
			capture replace `v1' = (obs1 + `y1') in `next2'
			
			capture replace `v2' = (obs2 + `x1') in `next3'
			capture replace `v1' = (obs1 + `y1') in `next3'
			
			local N = `N'+4
		}
		
		
		//if dup == 4 create the first flower!
		while `dup'[`N'] == 4 {
			local next = `N'+1
			local next2 = `N'+2
			local next3 = `N'+3
			local next4 = `N'+4
			scalar obs1 = `v1'[`N']
			scalar obs2 = `v2'[`N']
			*scalar x = x + 0.015
			scalar x = x*`magnifier'
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			local y1 = ((x*`rangey')/`ysize')*((`msize'/1.5))
			
			local x1 = `x1'*0.8
			local y1 = `y1'*0.8
			
			//ignore the first observation!
			
			capture replace `v2' = (obs2 - `x1') in `next'
			capture replace `v1' = (obs1 - `y1') in `next'
			
			capture replace `v2' = (obs2 + `x1') in `next2'
			capture replace `v1' = (obs1 + `y1') in `next2'
			
			capture replace `v2' = (obs2 - `x1') in `next3'
			capture replace `v1' = (obs1 + `y1') in `next3'
			
			capture replace `v2' = (obs2 + `x1') in `next4'
			capture replace `v1' = (obs1 - `y1') in `next4'
			local N = `N'+5
		}
		
		//if dup == 5 divide the X and Y for duplicates
		while `dup'[`N'] == 5 {
			local next = `N'+1
			local next2 = `N'+2
			local next3 = `N'+3
			local next4 = `N'+4
			local next5 = `N'+5
			scalar obs1 = `v1'[`N']
			scalar obs2 = `v2'[`N']
			scalar x = x*`magnifier'
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			local y1 = ((x*`rangey')/`ysize')*((`msize'/1.5))
			
			local x1 = `x1'*0.85
			local y2 = `y1'
			local y1 = `y1'*0.5
			
			capture replace `v2' = (obs2 - (`x1')) in `N'
			capture replace `v1' = (obs1 - (`y1')) in `N'
			
			capture replace `v2' = (obs2 + (`x1')) in `next'
			capture replace `v1' = (obs1 - (`y1')) in `next'
			
			capture replace `v2' = (obs2 - (`x1')) in `next2'
			capture replace `v1' = (obs1 + (`y1')) in `next2'
			
			capture replace `v2' = (obs2 + (`x1')) in `next3'
			capture replace `v1' = (obs1 + (`y1')) in `next3'
			
			capture replace `v1' = (obs1 + `y2') in `next4'
			capture replace `v1' = (obs1 - `y2') in `next5'
			
			local N = `N'+6
		}
		
		
		//if dup == 6
		while `dup'[`N'] == 6 {
			local next = `N'+1
			local next2 = `N'+2
			local next3 = `N'+3
			local next4 = `N'+4
			local next5 = `N'+5
			scalar obs1 = `v1'[`N']
			scalar obs2 = `v2'[`N']
			*scalar x = x*`magnifier'
			local x1 = ((x*`rangex')/`xsize')*((`msize'/1.5))
			local y1 = ((x*`rangey')/`ysize')*((`msize'/1.5))
			
			local x1 = `x1'*0.85
			local y2 = `y1'
			local y1 = `y1'*0.5
			
			capture replace `v2' = (obs2 - (`x1')) in `N'
			capture replace `v1' = (obs1 - (`y1')) in `N'
			
			capture replace `v2' = (obs2 + (`x1')) in `next'
			capture replace `v1' = (obs1 - (`y1')) in `next'
			
			capture replace `v2' = (obs2 - (`x1')) in `next2'
			capture replace `v1' = (obs1 + (`y1')) in `next2'
			
			capture replace `v2' = (obs2 + (`x1')) in `next3'
			capture replace `v1' = (obs1 + (`y1')) in `next3'
			
			capture replace `v1' = (obs1 + `y2') in `next4'
			capture replace `v1' = (obs1 - `y2') in `next5'
			
			local N = `N'+7
		}
		
		
		
	}
	else if "`layout'" == "size" {
		//don't do anything, just use the duplicates as weight for size variable
	}
	
	
	
	
	
	// save the dataset
	if !missing("`save'") {
		if "`layout'" == "geo" {
			capture rename `dup' __geo
		}
		else if "`layout'" == "size" {
			replace `dup' = `dup' + 1
			capture rename `dup' __size
		}
		save "`save'", replace
	}

end


markdoc neat.ado, exp(sthlp) replace

