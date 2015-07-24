#Data loaded is that provided in Thesis Appendix A, change dir as appropriate

joined<-read.table("byhostbioclim.txt", header=TRUE)
attach(joined)

#Load necessary packages

library(maps)

#Plot map

map(database= "world", col="lightyellow2", fill=TRUE,xlim=c(-14,32),ylim=c(34,60))

#Add points

points(longitude.x,latitude.x, col="black", cex=1.7, pch=16)
points(longitude.x,latitude.x, col="forestgreen", cex=1.4, pch=16) #OAK ONLY
fruit<-joined[joined$site=="CR"|joined$site=="IGC"|joined$site=="SON",] #FRUIT ONLY
points(fruit$longitude.x,fruit$latitude.x, col="black", cex=1.7, pch=16)
points(fruit$longitude.x,fruit$latitude.x, col="darkred", cex=1.4, pch=16)
both<-joined[joined$site=="PYR"|joined$site=="PAR"|joined$site=="DAV"|joined$site=="PLU",]
points(both$longitude.x,both$latitude.x, col="black", cex=1.7, pch=16)
points(both$longitude.x,both$latitude.x, col="orange", cex=1.4, pch=16)

#Add labels

rect(25.6, 40.24, 29.8, 41.52, border="black",col="white",xpd=FALSE,lwd=1)
text(27.7,40.84,labels="11,12",font=2) #PAR,PYR
rect(24.75, 37.573, 27, 38.683, border="black",col="white",xpd=FALSE,lwd=1)
text(25.9,38.173,labels="13",font=2) #TAX
rect(24.75, 34.953, 27, 36.053, border="black",col="white",xpd=FALSE,lwd=1)
text(25.9,35.553,labels="14",font=2) #CR
rect(-11.7, 41.111, -9.5, 42.311, border="black",col="white",xpd=FALSE,lwd=1)
text(-10.7,41.711,labels="15",font=2) #SON
rect(-12.75, 38.092, -10.45, 39.292, border="black",col="white",xpd=FALSE,lwd=1)
text(-11.63,38.692,labels="16",font=2) #IGC
rect(2.103, 44.147, 4.303, 45.347, border="black",col="white",xpd=FALSE,lwd=1)
text(3.203,44.8,labels="10",font=2) #MB
rect(2.25, 52, 4.103, 53.2, border="black",col="white",xpd=FALSE,lwd=1)
text(3.1,52.63,labels="5",font=2) #UEA
rect(0.8, 50.5, 3.913, 51.7, border="black",col="white",xpd=FALSE,lwd=1)
text(2.4,51.13,labels="8,9",font=2) #DAV,PLU
rect(-4, 54, -0.2, 55.2, border="black",col="white",xpd=FALSE,lwd=1)
text(-2,54.63,labels="1-4",font=2) #TTP,CHO,CRO,LBW
rect(-6.15, 50.5, -2.63, 51.7, border="black",col="white",xpd=FALSE,lwd=1)
text(-4.5,51.13,labels="6,7",font=2) #FRI,OCK

#Add legend

par(xpd=TRUE)
legend(x=-10,y=34,c("Fruit Samples","Oak Samples","Fruit and Oak samples"),col=c("black","black","black"),pch=16, 
       horiz=TRUE,text.width=c(9,9,9),bty="n",pt.cex=1.7)
legend(x=-10,y=34,c("Fruit Samples","Oak Samples","Fruit and Oak samples"),col=c("darkred","green","orange"),pch=16, 
       horiz=TRUE,text.width=c(9,9,9),bty="n",pt.cex=1.4)


