## R package-CTM
CTM — A Text Mining Toolkit for Chinese Document  

### Notes
This package CTM is created by Jim Liu.Thx him and it is very useful in text mining for Chinese under the circumstances 
that the function "DocumentTermMatrix" in the "tm" pacakge always goes wrong for Chinese characters. 
However, when I use this package, I have fond that the "for loop" running very slow to generate a "segMatrix", 
and when computing "tfidf" there exists some repetition calculation which influences the computational efficiency. 
So I improve his code by using vectorization operation and some other ways. 

### Test Result
I have tested the efficiency of my code. When computing a DTM with 10000 docs including 2640 different terms on my PC(i74720-hq CPU&12G RAM), the elapsed time can be  reduced from 350s to 6s.

### How to use
- download zip and uncompress the zip file, for example, the folder is on your Desktop and file path is "c:/users/yourname/desktop/CTM-master"
- open your R and type such code below
```
install.packages("roxygen2")
roxygen2::roxygenise("c:/users/yourname/desktop/CTM-master")
devtools::install_local("c:/users/yourname/desktop/CTM-master")
#ok!
library(CTM)
````
