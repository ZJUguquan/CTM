# CTM
:exclamation: This is a read-only mirror of the CRAN R package repository.  CTM — A Text Mining Toolkit for Chinese Document  

### Notes
Thx Jim Liu, this package CTM is very useful in text mining for Chinese under the circumstances 
that the function "DocumentTermMatrix" in the "tm" pacakge always  goes wrong for Chinese characters. 
However, when I use your CTM, I have fond that the "for loop" running very slow  to generate a "segMatrix", 
and when computing "tfidf" there exists some repetition calculation which influences the computational efficiency. 
So I improve your code by using vectorization operation and some other ways. 

### Test Result
I have tested the efficiency of my code. When computing a DTM with 10000 docs including 2640 different terms on my PC(i74720-hq CPU&12G RAM), the elapsed time can be  reduced from 350s to 6s.

