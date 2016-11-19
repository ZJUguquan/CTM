#' @title Term Document Matrix
#' @description Constructs Term-Document Matrix from Chinese Text Documents.
#'
#' @param doc The Chinese text document.
#' @param weighting Available weighting function with matrix are tf, tfidf.
#' @param shortTermDeleted Deltected short word when nchar <2.
#' @author Jim Liu, GuQuQ
#' @details
#' This function run a Chinese word segmentation by jiebeR and build
#' term-document matrix, and there is two weighting function with matrix,
#' term frequency and term frequency inverse document frequency.
#'
#'
#' @export
#' @import jiebaR
#' @examples
#' library(CTM)
#' a <- "hello taiwan"
#' b <- "world of tank"
#' c <- "taiwan weather"
#' d <- "local weather"
#' text <- t(data.frame(a,b,c,d))
#' tdm <- CTDM(doc = text, weighting = "tfidf", shortTermDeleted = FALSE)

CTDM <- function(doc,weighting,shortTermDeleted){
  ###jiebaR
  cutter <- jiebaR::worker()
  dataText <- doc
  
  segs <- sapply(dataText,USE.NAMES = F,FUN = function(x){
    temp=(cutter <= x)
    temp[nchar(temp)>0]
  })
  
  allTerms=unlist(segs)
  lens=sapply(segs,length)                               #count of terms in different id
  allIds=rep(1:length(segs),lens)
  segMatrix <- data.frame(id=allIds,term=allTerms,stringsAsFactors = F)
  ###plyr
  it_freq <- plyr::count(segMatrix,vars = c("id","term"))#count of different terms in each id, "it" means id_terms
  
  term <- unique(segMatrix$term)
  if(shortTermDeleted){
    term <- term[nchar(term)>=2]
  }

  dtm <- matrix(nrow = length(dataText),ncol = length(term),0)#likely to be sparse matrix, also can use Matrix::Matrix
  
  if(weighting=="tf"){
    for(i in 1:length(term)){
      find1 <- it_freq[it_freq$term==term[i],c("id","freq")]
      find2 <- lens[find1$id]
      dtm[find1$id,i] <- find1$freq/find2
    }
  }

  if(weighting=="tfidf"){
    n_row=nrow(dtm)
    for(i in 1:length(term)){
      find1 <- it_freq[it_freq$term==term[i],c("id","freq")]
      find2 <- lens[find1$id]
      dtm[find1$id,i] <- find1$freq/find2
      dtm[,i] <- dtm[,i]*log(n_row/(1+nrow(find1)))  
    }
  }
  colnames(dtm) <- term
  tdm=t(dtm)
  tdm
}




#' @title Document Term Matrix
#' @description Constructs Document-Term Matrix from Chinese Text Documents.
#'
#' @param doc The Chinese text document.
#' @param weighting Available weighting function with matrix are tf, tfidf.
#' @param shortTermDeleted Deltected short word when nchar <2.
#' @author Jim Liu, GuQuQ
#' @details
#' This function run a Chinese word segmentation by jiebeR and build document-term matrix
#' and there is two weighting function with matrix,
#' term frequency and term frequency inverse document frequency.
#'
#'
#' @export
#' @import jiebaR
#' @examples
#' library(CTM)
#' a <- "hello taiwan"
#' b <- "world of tank"
#' c <- "taiwan weather"
#' d <- "local weather"
#' text <- t(data.frame(a,b,c,d))
#' dtm <- CDTM(doc = text, weighting = "tfidf", shortTermDeleted = FALSE)

CDTM <- function(doc,weighting,shortTermDeleted){
  ###jiebaR
  cutter <- jiebaR::worker()
  dataText <- doc
  
  segs <- sapply(dataText,USE.NAMES = F,FUN = function(x){
    temp=(cutter <= x)
    temp[nchar(temp)>0]
  })
  
  allTerms=unlist(segs)
  lens=sapply(segs,length)                               #count of terms in different id
  allIds=rep(1:length(segs),lens)
  segMatrix <- data.frame(id=allIds,term=allTerms,stringsAsFactors = F)
  ###plyr
  it_freq <- plyr::count(segMatrix,vars = c("id","term"))#count of different terms in each id, "it" means id_terms
  
  term <- unique(segMatrix$term)
  if(shortTermDeleted){
    term <- term[nchar(term)>=2]
  }

  dtm <- matrix(nrow = length(dataText),ncol = length(term),0)#likely to be sparse matrix, can use Matrix::Matrix
  
  if(weighting=="tf"){
    for(i in 1:length(term)){
      find1 <- it_freq[it_freq$term==term[i],c("id","freq")]
      find2 <- lens[find1$id]
      dtm[find1$id,i] <- find1$freq/find2
    }
  }

  if(weighting=="tfidf"){
    n_row=nrow(dtm)
    for(i in 1:length(term)){
      find1 <- it_freq[it_freq$term==term[i],c("id","freq")]
      find2 <- lens[find1$id]
      dtm[find1$id,i] <- find1$freq/find2
      dtm[,i] <- dtm[,i]*log(n_row/(1+nrow(find1)))  
    }
  }
  colnames(dtm) <- term
  dtm
}





#' @title Term Count
#' @description Computing term count from text documents
#'
#' @param doc The Chinese text document.
#' @param shortTermDeleted Deltected short word when nchar <2.
#' @author Jim Liu
#' @details
#' This function run a Chinese word segmentation by jiebeR and
#' compute term count from these text document.
#'
#'
#' @export
#' @import jiebaR
#' @examples
#' library(CTM)
#' a <- "hello taiwan"
#' b <- "world of tank"
#' c <- "taiwan weather"
#' d <- "local weather"
#' text <- t(data.frame(a,b,c,d))
#' count <- termCount(doc = text, shortTermDeleted = FALSE)



termCount <- function(doc,shortTermDeleted){
  ###jiebaR
  cutter <- worker()
  cutfunc <- function(s){
    return(cutter <= s)
  }
  dataText <- doc
  res <- data.frame(table(unlist(lapply(dataText, cutfunc))))
  res[,1] <- as.character(res[,1])
  if(shortTermDeleted){
    res <- res[which(nchar(res[,1])>1),]
  }
  res <- res[order(-res$Freq),]
}


