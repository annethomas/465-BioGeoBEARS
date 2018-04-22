library(dplyr)
library(stringr)

nz_states = read.csv("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/NZ_poaceae_endemics_areas.csv",na.strings=c("", "NA"),skip=3,header=TRUE)[1:191,]

write_phylip = function(tree){
  genera = tree$tip.label%>% strsplit("_") %>% lapply('[[', 1) %>% unique() %>% as.character()
  nz_states_genus = nz_states[which(strsplit(as.character(unlist(nz_states[,"Species"])),'\\s') %>% lapply('[[', 1) %in% genera),]
  
  phylip_fn = paste0("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files/",
                     glue::collapse(genera,sep="_"),"_geog.phylip")
  #add line pruning nonendemics first so that file has right number of species in header
  write(paste(length(tree$tip.label),6,"(A B C D E F)",sep="   "),file = phylip_fn)
  for(r in 1:nrow(nz_states_genus)){
    presence_str = paste(as.numeric(!is.na(nz_states_genus[r,4:9])),collapse="")
    species = str_replace_all(trimws(nz_states_genus[r,"Species"])," ","_")
    found = FALSE
    #look for species_sub labels and add to phylip to match tree
    for(sp in tree$tip.label){
      if(grepl(species,sp)){
        found = TRUE
        if(nchar(species) < nchar(sp)){
          species = sp
        }
      }
    }
    if(!found) {
      print(paste(species,"not found in tree"))
      next
    }
    write(paste(species,presence_str,sep="   "),file = phylip_fn, append=TRUE)
  }
  geo = read.table(paste0(glue::collapse(genera,sep="_"),"_geog.phylip"),skip=1)
  nonendemic = setdiff(tree$tip.label,as.character(geo[,1]))
  if(length(nonendemic)>0){
    print("pruning nonendemics")
    print(nonendemic)
    tipnames = tree$tip.label
    for(t in tipnames){
      if(t %in% nonendemic){
        tree = drop.tip(tree,t)
      }
    }
  }
  
  ape::write.tree(tree,paste0("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files/",
                              glue::collapse(genera,sep="_"),"_endemic.newick"))
}

