library(rgdal)#note gdal will load sp
library(dismo)#note dismo will load raster
library(maptools)
library(dplyr)
library(RColorBrewer)

proj4stringWRLDSMPL <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0" 
proj4stringNZTM <- proj4string(nzland) 

LAYERS <- ogrListLayers("C:/Users/aet_a/OneDrive/Documents/Rick_Gill_lab/Canyonlands/TTR/old_tutorial/lds-nz-coastlines-and-islands-polygons-topo-150k-SHP") 
nzland <- readOGR("C:/Users/aet_a/OneDrive/Documents/Rick_Gill_lab/Canyonlands/TTR/old_tutorial/lds-nz-coastlines-and-islands-polygons-topo-150k-SHP", LAYERS[[1]])
#ogrInfo("lds-nz-coastlines-and-islands-polygons-topo-150k-SHP", LAYERS)
proj4string(nzland) = CRS(proj4stringWRLDSMPL)
##raster stuff
r <- raster(nzland) 
r <- extend(r, extent(r)+5000) # this step expands the extent of the Rasterlayer 
res(r) <- 5000 # sets matrix over NZ landscape 
r <- rasterize(nzland,r,1) 
plot(r, legend=F,col="gray87") # plot the raster 
plot(nzland,add=T) # add the polygons
#points(PoaAnceps.nztm,pch=18,cex=.2,col="blue")

colors = palette(rainbow(35))
colors=brewer.pal(35,"Spectral")
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

png(file="Poa.points.png",width=)

plot(r, legend=F,col="gray87") # plot the raster 
plot(nzland,add=T,lwd=.01) # add the polygons
colors = palette(rainbow(35))
i=1
for(species in Poa.points){
  points(species,pch=18,cex=.4,col=colors[i])
  i=i+1
}

dev.off()

pie(rep(1,35), col=rainbow(35))
lapply(Poa.points,length)

jpeg("poa_legend.jpeg",width=450,height=1500)
plot(1, type="n", axes=FALSE, xlab="", ylab="") 
legend(1, 1, legend =rev(poa.tree$tip.label), col=rev(colors), lwd=2, cex=2, xjust=0.5, yjust=0.5) 
dev.off()

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
  Poa.points[[species]] = presence.nztm
}

PoaAnceps = gbif("Poa",species="anceps")[,c("lon","lat")]
PoaAnceps = PoaAnceps[complete.cases(PoaAnceps),] %>% filter(lon > 160, lat < -33, lat > -50)
coordinates(PoaAnceps) <- ~ lon + lat
proj4stringWRLDSMPL <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0" 
proj4string(PoaAnceps) <- proj4stringWRLDSMPL 
proj4stringNZTM <- proj4string(nzland) 
PoaAnceps.nztm <- spTransform(PoaAnceps,CRS(proj4stringNZTM)) 
proj4string(PoaAnceps.nztm) <- proj4stringNZTM
