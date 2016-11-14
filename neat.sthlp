{smcl}
{right:version 1.0.0}
{title:Title}

{phang}
{cmd:neat} {hline 2} a layout engine that alters the duplicated observations in 2 variables in order to display them in a geometrically appealing way within scatter plots 
 instead of adding random noise using the {help scatter##jitter_options:jitter} 
 option. 
 

{title:Syntax}

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
{synopt:{opt msize(num)}}takes the size (numeric only) of the marker into account. {p_end}
{synopt:{opt xsize(num)}}takes the size of the X-axis into account. {p_end}
{synopt:{opt ysize(num)}}takes the size of the Y-axis into account. {p_end}
{synoptline}
{p2colreset}{...}

{p 4 4 2}
{bf:msize}, {bf:xsize}, and {bf:ysize} are influencing the calculations 
for altering the variables. They should be identical to the values specified 
in the {help scatter} plot, since they can influence data visualization. For 
example, increasing the width of the scatter plot using the {bf:xsize} will 
enlarge the distance between the observations in the X-axis. Specifying these 
options helps the {bf:neat} engine to prepare the variables for a scatter plot 
with a particular scale.


{title:Description}

{p 4 4 2}
duplicated observations will appear as a single point in scatter plot. Stata 
provide the {help scatter##jitter_options:jitter} option in scatter plot to add 
random noise to the data, which help to see the duplicated data near one another, 
but disrupts the overall pattern of the scatter plot if the data is discreet. 

{p 4 4 2}
The {bf:neat} engine deals with visualizing the duplicated observations by providing 
two layout solutions. The default layout is {bf:geo} which creates geometric 
shapes with duplicated observations. The engine can illustrate up to seven 
duplicated observations. If the duplications are more than 7 they appear the 
same as 7 duplications. Therefore, this engine is best when the data is not 
including many duplications. 

{p 4 4 2}
When number of duplications is so high, the {bf:neat} engine provides the 
{bf:size} layout that uses the amount of duplications as a weight for enlarging 
the points with duplications. As a result, the scatter plot will have points 
with different size, based on how many observations are in each point. 
to draw such a scatter plot you need to use the 
{browse "http://www":multiscatter} command (see the examples below). 


{title:Example}

{p 4 4 2}
The examples can be found on  {browse "http://www":GitHub}. 


{title:Author}

{p 4 4 2}
E. F. Haghish     {break}
Department of Mathematics and Computer Science (IMADA)      {break}
University of Southern Denmark      {break}

    {hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 

