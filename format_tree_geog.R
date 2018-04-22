#Script to write geography files for BioGeoBEARS input

#tree of all of New Zealand Poaceae
tree =read.nexus(np(paste0("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/","\\NZ.Poaceae.2gene.v3.tree")))
source("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/write_phylip.R")

#mrca (matrix of most recent common ancestors) and subtrees generated in find_subtrees.R
load('C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/NZ_poaceae_mrca.Rdata')
load('C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/endemic_subtrees.Rdata')

setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files")

#write the geography phylip file for every endemic clade
for(sub in sub_trees_endemic){
  print(paste("original genus:",sub$genus))
  tr = extract.clade(tree,sub$mrca)
  genera = tr$tip.label%>% strsplit("_") %>% lapply('[[', 1) %>% unique() %>% as.character()
  print(genera)
  write_phylip(tr)
}

tree.files = list.files("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files/")

#find the number of species in each zone for each genus (Table 1)
for(i in 1:length(sub_trees_endemic)){
  print(tree.files[(i*2) - 1])
  tr = read.tree(tree.files[(i*2) - 1])
  tipnames = tr$tip.label
  print(tipnames)
  genera = tr$tip.label%>% strsplit("_") %>% lapply('[[', 1) %>% unique() %>% as.character()
  #print(genera)
  nz_states_genus = nz_states[which(strsplit(as.character(unlist(nz_states[,"Species"])),'\\s') %>% lapply('[[', 1) %in% genera),]
    zones = c()
   for(i in 1:6){
     #zones = c(zones,length(which(nz_states_genus[,i+3]=="X")))
     zones = c(zones,length(which(!is.na(nz_states_genus[,i+3]))))
   }
   print(zones)
}


