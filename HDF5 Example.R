## Install the R HDF5 package from bioconductor
## Lecture github link: https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/02_02_readingHDF5/index.md

##source("http://bioconductor.org/biocLite.R")
##biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created

## More Examples can be found at: http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")

## Create a subgroup of "foo"
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

## Create a Matrix
A = matrix(1:10,nr=5,nc=2)

## Write data to the matrix
h5write(A, "example.h5","foo/A")

##Create a multidimensional arrray
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"

##Write the array to the subgroup
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")


## Write a data set
df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")


## Reading Data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")
readA


## Writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")


## More resources:
## http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
## http://www.hdfgroup.org/HDF5/

