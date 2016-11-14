# `colorcode` : a module to return RGB, CMYK, and HSV values for Stata colors


If you have [github](https://github.com/haghish/github) command installed, you can simply install 
the package by typing:

```{js}
github install haghish/colorcode
```

Otherwise, you can install it using `net install` command as shown below:

```{js}
net install github, replace from("https://raw.githubusercontent.com/haghish/github/master/")
```

### Syntax

The command simply takes a _stata color name_ and returns the values for RGB, CMYK, and HSV as __rclass__ macros. 

### Example

Say, you want to obtain the RGB code of a Stata color e.g. `bluishgray`:

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
  

    





