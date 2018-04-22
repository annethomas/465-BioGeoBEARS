#Script to plot occurrence points of a given genus in New Zealand (Figure 3)

library(rgdal)#note gdal will load sp
library(dismo)#note dismo will load raster
library(maptools)
library(dplyr)
library(RColorBrewer)

#set up spatial data and projections
proj4stringWRLDSMPL <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0" 
proj4stringNZTM <- proj4string(nzland) 
LAYERS <- ogrListLayers("C:/Users/aet_a/OneDrive/Documents/Rick_Gill_lab/Canyonlands/TTR/old_tutorial/lds-nz-coastlines-and-islands-polygons-topo-150k-SHP") 
nzland <- readOGR("C:/Users/aet_a/OneDrive/Documents/Rick_Gill_lab/Canyonlands/TTR/old_tutorial/lds-nz-coastlines-and-islands-polygons-topo-150k-SHP", LAYERS[[1]])

##prepare raster
r <- raster(nzland) 
r <- extend(r, extent(r)+5000) # this step expands the extent of the Rasterlayer 
res(r) <- 5000 # sets matrix over NZ landscape 
r <- rasterize(nzland,r,1) 
plot(r, legend=F,col="gray87") # plot the raster 
plot(nzland,add=T) # add the polygons

#download, plot, and save occurrence points for eavh species in tree
setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/Poa")
poa.tree = read.tree("Poa_endemic.newick")
colors = palette(rainbow(length(poa.tree$tip.label)))
Poa.points = list()
i=1
for(species in poa.tree$tip.label){
  species_split = strsplit(species,"_")
  presence = gbif(species_split[[1]][1],species=species_split[[1]][2])[,c("lon","lat")]
  presence = presence[complete.cases(presence),] %>% filter(lon > 160, lat < -33, lat > -60)
  coordinates(presence) <- ~ lon + lat
  proj4string(presence) <- proj4stringWRLDSMPL 
  presence.nztm <- spTransform(presence,CRS(proj4stringNZTM)) 
  proj4string(presence.nztm) <- proj4stringNZTM
  points(presence.nztm,pch=18,cex=.2,col=colors[i])
  Poa.points[[species]] = presence.nztm
}
save(Poa.points,file="Poa.points.Rdata")

#to recreate plot after points have been downloaded
png(file="Poa.points.png",width=2000,height=1200)

plot(r, legend=F,col="gray87") # plot the raster 
plot(nzland,add=T,lwd=.01) # add the polygons
colors = palette(rainbow(35))
i=1
for(species in Poa.points){
  points(species,pch=18,cex=.4,col=colors[i])
  i=i+1
}

dev.off()

#to see colors
pie(rep(1,35), col=rainbow(35))
#to see number of points
lapply(Poa.points,length)

#create legend
jpeg("poa_legend.jpeg",width=450,height=1500)
plot(1, type="n", axes=FALSE, xlab="", ylab="") 
legend(1, 1, legend =rev(poa.tree$tip.label), col=rev(colors), lwd=2, cex=2, xjust=0.5, yjust=0.5) 
dev.off()

