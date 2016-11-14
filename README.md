# `neat` : a Stata layout module to create geometric shapes out of replicates in scatter plot


If you have [github](https://github.com/haghish/github) command installed, you can simply install 
the package by typing:

```{js}
github install haghish/neat
```

Otherwise, you can install it using `net install` command as shown below:

```{js}
net install github, replace from("https://raw.githubusercontent.com/haghish/neat/master/")
```

### Syntax

The command simply takes 2 Stata variables along with the options required for adjusting the size of 
a scatterplot graph in Stata. The command alters the values of the variables in a way to create 
geometrically appealing shapes out of replicated observations in scatter plots. Therefore, the command 
should be followed by a scatterplot command in Stata.  

### Example

Let's load an example dataset that has replicated observations for 2 variables. 

```
. colorcode bluishgray

rgb  217 230 235
hsv  197 .08 .92
cmyk 18 5 0 20

. return list

macros:
                r(rgb) : "217 230 235"
                r(hsv) : "197 .08 .92"
               r(cmyk) : "18 5 0 20"
```


Author
------
  **E. F. Haghish**  
  Center for Medical Biometry and Medical Informatics
  University of Freiburg, Germany      
  _haghish@imbi.uni-freiburg.de_     
  _http://www.haghish.com/weaver_  
  _[@Haghish](https://twitter.com/Haghish)_   
  

    





