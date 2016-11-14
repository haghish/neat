use neat, clear

summarize v2

// 1/40 is too much
// 1/100 is too little
// 1/80 is alright
// 1/66 is excellent 
capture replace v2 = 1.06 in 1

capture replace v1 = 2.09 in 2


// 1/66 is excellent 
capture replace v2 = 3.06 in 3
capture replace v1 = 3.09 in 8
	
	//can be better done:
	capture replace v2 = 3.040 in 8

scatter v1 v2 , xsize(5.5) ysize(4) //, jitter(5)


//it seems somehow robust to changing the width and height of the graph
*scatter v1 v2 , xsize(4) ysize(4)



//range is fixed! work the xsize

drop if v1 == 10
*replace v2 = 400 if v1==10
*drop if v1 > 2 & v2 < 10
*drop if v1 > 2 

// xsize must be between 1.000 and 20.000

local xsize 11
*local msize 1.0


neat v1 v2 , dsize(5) max(2) save(temp) msize(`msize') xsize(`xsize') //  

scatter v1 v2, xsize(`xsize') msize(`msize')
