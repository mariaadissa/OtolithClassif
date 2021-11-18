library(tidyverse)

# split full path into folder names
split_path <- function(x){
  if (dirname(x)==x) x else c(basename(x),split_path(dirname(x)))
} 

# split full path and returns corresponding row in csv.data
row_from_path <- function(path, csv.data){
  split.path <- split_path(path)
  year <- split.path[4] 
  serial.no <- split.path[3]
  no.age <- split.path[2]
  a <- unlist(str_split(no.age, "_")) # Nr06 & age08 as output
  no_ <- unlist(str_split(a[1],"r"))[2] 
  age_ <- unlist(str_split(a[2],"e"))[2]
  # if folder is Del
  if(nchar(serial.no)!=5){
    serial.no.final <- unlist(str_split(serial.no, "_"))[1] # "70425"
    return(subset(csv.data, age == as.integer(age_) & serialno == as.integer(serial.no.final) & no == as.integer(no_) 
           & substr(as.character(csv.data$cruise),1,4) == year & samplenumber == 2))
  } else {
    return(subset(csv.data, age == as.integer(age_) & serialno == as.integer(serial.no) & no == as.integer(no_)
                  & substr(as.character(csv.data$cruise),1,4) == year & samplenumber == 1))
  }
 
  
}


# subset(csv.data, age == 1 & serialno == 70425 & no == 1 & substr(as.character(csv.data$cruise),1,4) == year)