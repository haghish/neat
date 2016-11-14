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


the **neat3.dta** includes 2 discrete variables named **v1** and **v2**.
Let's begin by creating a scatter plot in Stata:

    .  use "https://raw.githubusercontent.com/haghish/neat/master/test/neat3.dta", clear
    .  scatter v1 v2 

![](https://raw.githubusercontent.com/haghish/neat/master/test/Weaver-figure/figure_2.png)

Now let's apply the **`neat`** engine. This will change the duplicated
observations in **v1** and **v2** variables.

    .  neat v1 v2
    .  scatter v1 v2

![](https://raw.githubusercontent.com/haghish/neat/master/test/Weaver-figure/figure_3.png)


Author
------
  **E. F. Haghish**  
  Center for Medical Biometry and Medical Informatics
  University of Freiburg, Germany      
  _haghish@imbi.uni-freiburg.de_     
  _http://www.haghish.com/weaver_  
  _[@Haghish](https://twitter.com/Haghish)_   
  

    





