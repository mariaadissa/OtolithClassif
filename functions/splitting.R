library(tidyverse)

# split full path into folder names
split_path <- function(x){
  if (dirname(x)==x) x else c(basename(x),split_path(dirname(x)))
} 

# split full path and returns corresponding row in csv.data
row_from_path <- function(path, csv.data){
  split.path <- split_path(path)
  serial.no <- split.path[3]
  no.age <- split.path[2]
  a <- unlist(str_split(no.age, "_")) # Nr06 & age08 as output
  no_ <- unlist(str_split(a[1],"r"))[2] 
  age_ <- unlist(str_split(a[2],"e"))[2]
  return(subset(csv.data, age == as.integer(age_) & serialno == as.integer(serial.no) & no == as.integer(no_)))
  
}


