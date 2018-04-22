# 465-BioGeoBEARS
This repository contains the code necessary to run the analysis and create the figures in a Bioinformatics course capstone study which used BioGeoBEARS to reconstrcut the biogeography of New Zealand grasses.
Scripts in order they should be examined or run:
find_subtrees.R loads a New Zealand Poaceae phylogeny and extracts subtree by genus and endemic status.
format_tree_geog.R writes the geography files needed for BioGeoBEARS using write_phylip.R.
run_BioGeoBEARS runs BioGeoBEARS_generic, a script containing 6 model runs, for any input tree, and saves the results.
plot_tree_results.R plots customized trees with BioGeoBEARS results.
plot_occurrence.R plots the occurrence data for a genus on a map of New Zealand.
