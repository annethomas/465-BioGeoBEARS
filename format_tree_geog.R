length(which(!is.na(nz_states$Zone1)))
#[1] 69
length(which(!is.na(nz_states$Zone2)))
#[1] 92
length(which(!is.na(nz_states$Zone3)))
#[1] 101
length(which(!is.na(nz_states$Zone4)))
#[1] 101
length(which(!is.na(nz_states$Zone5)))
#[1] 111
length(which(!is.na(nz_states$Zone6)))
#[1] 36

load('C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/NZ_poaceae_mrca.Rdata')
load('C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/endemic_subtrees.Rdata')
tree =read.nexus(np(paste0("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/","\\NZ.Poaceae.2gene.v3.tree")))
source("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/write_phylip.R")

setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files")
for(sub in sub_trees_endemic){
  print(paste("original genus:",sub$genus))
  tr = extract.clade(tree,sub$mrca)
  genera = tr$tip.label%>% strsplit("_") %>% lapply('[[', 1) %>% unique() %>% as.character()
  print(genera)
  write_phylip(tr)
  #nz_states_genus = nz_states[which(strsplit(as.character(unlist(nz_states[,"Species"])),'\\s') %>% lapply('[[', 1) == genera),]
  # zones = c()
  # for(i in 1:6){
  #   zones = c(zones,length(which(!is.na(nz_states_genus[,i+3]))))
  #   #print(length(which(!is.na(nz_states_genus[,i+3]))))
  # }
  # print(zones)
}

tree.files = list.files("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/tree_phylip_files/")

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


