library(dplyr)
library(stringr)

trfn = np(paste0("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/","\\NZ.Poaceae.2gene.v3.tree"))

# Look at the raw Newick file:
moref(trfn)

# Look at your phylogeny:
tree = read.nexus(trfn)
pdf("tree.pdf",cex=.1)
plot(tree)
#title("Example Psychotria phylogeny from Ree & Smith (2008)")
axisPhylo() # plots timescale
dev.off()

#get most recent common ancestors for whole tree
mrca = mrca(tree)
save(mrca, file='NZ_poaceae_mrca.Rdata')
poaceae = read.csv("NZ.Poaceae.csv",skip=3,header=T)

endemics = filter(poaceae,Biostatus=="E")
#endemics[,4] = paste(unlist(strsplit(as.character(unlist(endemics[,"Species"])),'\\s')),collapse="_")

reformat = function(x){
  return(paste(unlist(strsplit(as.character(unlist(x),'\\s')),collapse="_")))
}
# ddply(endemics[,"Species"],reformat(x))
# 
# agrostis_lachnagrostis=extract.clade(tree,665)
genera = strsplit(as.character(unlist(endemics[,"Species"])),'\\s') %>% lapply('[[', 1) %>% unique() %>% as.character()
tree_names = row.names(mrca) %>% strsplit("_")

#find most recent common ancestor for each endemic genera
sub_trees = list()
for(genus in genera){
  print(genus)
  idx = which(lapply(tree_names,'[[', 1) == genus)
  if(length(idx) > 1){
    sub_matrix = mrca[idx,idx]
    sub_matrix[upper.tri(sub_matrix, diag = TRUE)] <- NA
    ancestors = unique(c(sub_matrix))
    lca = min(ancestors,na.rm = TRUE)
    sub_tree = list(genus=genus, sub_matrix = sub_matrix,ancestors=ancestors,mrca=lca)
    #assign(genus,list(sub_matrix = sub_matrix,ancestors=ancestors,mrca=lca))
    sub_trees = c(sub_trees,list(sub_tree))
  }else print("1 or fewer")
}


#find most recent common ancestor of endemic species within each genera
all_species = str_replace_all(row.names(mrca),"_"," ")
sub_trees_endemic = list()
for(genus in genera){
  print(genus)
  idx = which(lapply(tree_names,'[[', 1) == genus)
  endemic_idx = sapply(idx,function(x){if(str_replace_all(all_species[x]," sub","") %in% endemic_species) return(TRUE) 
    else return(FALSE)},simplify=TRUE)
  if(!all(endemic_idx)) {
    print("excluding non endemics:")
    print(all_species[idx[!endemic_idx]])
  }
  idx = idx[endemic_idx]
  if(length(idx) > 1){
    sub_matrix = mrca[idx,idx]
    sub_matrix[upper.tri(sub_matrix, diag = TRUE)] <- NA
    ancestors = unique(c(sub_matrix))
    lca = min(ancestors,na.rm = TRUE)
    sub_tree = list(genus=genus, sub_matrix = sub_matrix,ancestors=ancestors,mrca=lca)
    #assign(genus,list(sub_matrix = sub_matrix,ancestors=ancestors,mrca=lca))
    sub_trees_endemic = c(sub_trees_endemic,list(sub_tree))
  }else print("1 or fewer")
}

lapply(sub_trees_endemic,'[[', 1)

pdf("endemic_subtrees.pdf")

for(tr in sub_trees_endemic){
  print(tr$genus)
  mrca.idx = tr$mrca
  extracted = extract.clade(tree,mrca.idx)
  
  species = extracted$tip.label
  species = str_replace_all(species,"_"," ")
  idx = sapply(species,function(x){if(str_replace_all(x," sub","") %in% endemic_species) return(TRUE) 
    else return(FALSE)},simplify=TRUE)
  write(tr$genus,append=TRUE,sep=",", file="endemic_breakdown.csv")
  if(length(species[idx]) > 0){
    write(species[idx],append=TRUE,sep=",",ncolumns = length(species[idx]), file="endemic_breakdown.csv")
  }else{
    write("no endemics",append=TRUE,sep=",", file="endemic_breakdown.csv")
  }
  if(length(species[!idx]) > 0){
    write(species[!idx],append=TRUE,sep=",",ncolumns = length(species[!idx]), file="endemic_breakdown.csv")
  }else{
    write("no nonendemics",append=TRUE,sep=",", file="endemic_breakdown.csv")
  }
  
  print(paste("Non endemics grouping in",tr$genus))
  print(species[!idx])
  
  #plot(extracted,cex=.5)
  #axisPhylo()
}
dev.off()

#exclude extra nodes in Hierochloe subtree (drops one Hierochloe)
sub_trees_endemic[[8]]$mrca = 633

save(sub_trees_endemic,file="endemic_subtrees.Rdata")

#do chionochloa
sub_trees_endemic[[4]]$mrca
ch.tree = extract.clade(tree,502)
ch.tree=drop.tip(ch.tree,"Chionochloa_beddiei_sub")
ch.tree=drop.tip(ch.tree,"Chionochloa_nivifera")
ape::write.tree(ch.tree,file="chionochloa.newick")


trfn = "chionochloa.newick"
ch.tree = read.tree("chionochloa.newick")

#rytidosperma

ry.tree = extract.clade(tree,sub_trees_endemic[[14]]$mrca)