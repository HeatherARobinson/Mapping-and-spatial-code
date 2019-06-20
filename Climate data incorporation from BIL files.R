
#Use bioclim tiff OR bil files downloaded from www.worldclim.org/bioclim and put in working directory (or access them directly online)

library(raster)		#Load necessary packages
library(rgdal)

#Stack a raster with environmental variables
#N.B.Temperature values in Celsius are given multipled by 10 for BIOCLIM variables.

bioclim<-stack(raster('bio1.bil'),raster('bio2.bil'),raster('bio3.bil'),raster('bio4.bil'),raster('bio5.bil'),raster('bio6.bil'),raster('bio7.bil'),raster('bio8.bil'),raster('bio9.bil'),raster('bio10.bil'),raster('bio11.bil'),raster('bio12.bil'),raster('bio13.bil'),raster('bio14.bil'),raster('bio15.bil'),raster('bio16.bil'),raster('bio17.bil'),raster('bio18.bil'),raster('bio19.bil'))
#Check visually that variation seems correct. N.B.'warmer'colours are used for smaller values on default plot settings

#BIO1 = Annual Mean Temperature
#BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
#BIO3 = Isothermality (BIO2/BIO7) (* 100)
#BIO4 = Temperature Seasonality (standard deviation *100)
#BIO5 = Max Temperature of Warmest Month
#BIO6 = Min Temperature of Coldest Month
#BIO7 = Temperature Annual Range (BIO5-BIO6)
#BIO8 = Mean Temperature of Wettest Quarter
#BIO9 = Mean Temperature of Driest Quarter
#BIO10 = Mean Temperature of Warmest Quarter
#BIO11 = Mean Temperature of Coldest Quarter
#BIO12 = Annual Precipitation
#BIO13 = Precipitation of Wettest Month
#BIO14 = Precipitation of Driest Month
#BIO15 = Precipitation Seasonality (Coefficient of Variation)
#BIO16 = Precipitation of Wettest Quarter
#BIO17 = Precipitation of Driest Quarter
#BIO18 = Precipitation of Warmest Quarter
#BIO19 = Precipitation of Coldest Quarter


l=sampledata$longitude
a=sampledata$latitude

#Produces a text output file 'climdata.txt'

climdata<-file(paste("climdata.txt"), open="w")
cat("hostName","latitude","longitude","Xannualtemp","xdiurnalrange","isothermality","tempseasonality","maxtemp","mincoldtemp","xtemprange","xtempwetquart","xtempdryquart","xtemphotquart","xtempcoldquart","xprec","precwetmonth","precdrymonth","precseasonality","precwetquart","precdryquart","prechotquart","preccoldquart","\n", file="climdata.txt",append=TRUE)

for (n in 1:166){
  c <-c(l[n],l[n]+0.01,a[n],a[n]+0.01)
  e<-extent(c)						
  zoom<-crop(bioclim, e)					
  
  #Crop the raster to a single pixel with each permutation and extract information 
  
  cat((paste(sampledata$hostName[n])),ymin(zoom),xmin(zoom),minValue(zoom$bio1), minValue(zoom$bio2),minValue(zoom$bio3),minValue(zoom$bio4),minValue(zoom$bio5), minValue(zoom$bio6), minValue(zoom$bio7), minValue(zoom$bio8), minValue(zoom$bio9), minValue(zoom$bio10), minValue(zoom$bio11), minValue(zoom$bio12), minValue(zoom$bio13), minValue(zoom$bio14), minValue(zoom$bio15), minValue(zoom$bio16), minValue(zoom$bio17), minValue(zoom$bio18), minValue(zoom$bio19), "\n", file="climdata.txt", sep="\t", fill=FALSE, labels=NULL, append=TRUE)
} 

#Data should match field order set above. Wait for file writing to be complete before proceeding


#Append the climate data into the master table:
joined<-merge(sampledata,climdata, by="hostName")
attach(joined)
length(sampledata)
length(climdata)
length(joined)						
#Should be the sum of the factors in both source tables minus 1 
length(joined$hostName)					
#Should be the same length as climdata and sampledata 
head (joined)							


byhostbioclim<-file(paste("byhostbioclim.txt"), open="w")
cat("hostName", "ScerCount","SparCount","otherAmplifiedITScount","otherGrowthCount","sampleCount","
    site","species","hostType","latitude.x","longitude.x","latitude.y","longitude.y","elevation","circum","pH","Xannualtemp","tempseasonality","maxtemp","xprec","precdrymonth","precseasonality","\n", sep="\t",file="byhostbioclim.txt",append=TRUE)
for (n in 1:166){
  cat((paste(joined$hostName[n])),(paste(joined$ScerCount[n])),(paste(joined$SparCount[n])), (paste(joined$otherAmplifiedITScount[n])),(paste(joined$otherGrowthCount[n])),(paste(joined$sampleCount[n])),(paste(joined$site[n])),(paste(joined$species[n])), (paste(joined$hostType[n])),(paste(joined$latitude.x[n])),(paste(joined$longitude.x[n])),(paste(joined$latitude.y[n])),(paste(joined$longitude.y[n])),(paste(joined$elevation[n])),(paste(joined$circum[n])),(paste(joined$pH[n])),(paste(joined$Xannualtemp[n])),(paste(joined$tempseasonality[n])),(paste(joined$maxtemp[n])), (paste(joined$xprec[n])),(paste(joined$precdrymonth[n])),(paste(joined$precseasonality[n])),"\n", file="byhostbioclim.txt", sep="\t", fill=FALSE, labels=NULL, append=TRUE)
}   
