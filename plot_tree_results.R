#plot customized trees from BioGeoBEARS runs

source('C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/my_plot_BioGeoBEARS_results.R')

#clean out past runs
rm(list=ls(pattern="^res"))

#Chionochloa
# Setup
setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/Chionochloa")
load("Chionochloa_BAYAREALIKE+J_M0_unconstrained_v1.Rdata")
results_object = res
tr=read.tree("Chionochloa_endemic.newick")
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

png(file="ChionochloaTree.png",2000,1600)
analysis_titletxt = "Chionochloa: BAYAREALIKE+J most probable ancestral states"

# States
#res1 = plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text", label.offset=0.45, tipcex=1, statecex=0.9, splitcex=0.3, titlecex=2, plotsplits=FALSE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)
plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text",
                         label.offset=0.45, tipcex=2.3, statecex=1.8, titlecex=2.5,
                         axiscex = 1.8,axispadj = .7,plotsplits=FALSE, cornercoords_loc=scriptdir,
                         include_null_range=TRUE, tr=tr, tipranges=tipranges)
#dev.off()
#Pie chart
#plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="pie", label.offset=0.45, tipcex=0.7, statecex=0.7, splitcex=0.6, titlecex=0.8, plotsplits=TRUE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)

dev.off()

#Rytidosperma

# Setup
setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/Rytidosperma")
load("Rytidosperma_BAYAREALIKE+J_M0_unconstrained_v1.Rdata")
results_object = res
tr=read.tree("Rytidosperma_endemic.newick")
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

png(file="RytidospermaTree.png",2000,1200)
analysis_titletxt = "Rytidosperma: BAYAREALIKE+J most probable ancestral states"

# States
#res1 = plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text", label.offset=0.45, tipcex=1, statecex=0.9, splitcex=0.3, titlecex=2, plotsplits=FALSE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)
plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text",
                         label.offset=0.45, tipcex=2.3, statecex=1.8, titlecex=2.5,
                         axiscex = 1.8,axispadj = .7,plotsplits=FALSE, cornercoords_loc=scriptdir,
                         include_null_range=TRUE, tr=tr, tipranges=tipranges)
#dev.off()
#Pie chart
#plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="pie", label.offset=0.45, tipcex=0.7, statecex=0.7, splitcex=0.6, titlecex=0.8, plotsplits=TRUE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)

dev.off()
#Poa (Figure 2)
# Setup
setwd("C:/Users/aet_a/OneDrive/Documents/BYU/2018a Winter/Bio465/465-BioGeoBEARS/Poa")
load("Poa_DEC+J_M0_unconstrained_v1.Rdata")
results_object = res
tr=read.tree("Poa_endemic.newick")
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

png(file="PoaTree.png",2000,1700)
analysis_titletxt = "Poa: DEC+J most probable ancestral states"

# States
#res1 = plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text", label.offset=0.45, tipcex=1, statecex=0.9, splitcex=0.3, titlecex=2, plotsplits=FALSE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)
plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text",
                         label.offset=0.45, tipcex=2.3, statecex=1.8, titlecex=2.5,
                         axiscex = 1.8,axispadj = .7,plotsplits=FALSE, cornercoords_loc=scriptdir,
                         include_null_range=TRUE, tr=tr, tipranges=tipranges)
#dev.off()
#Pie chart
#plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="pie", label.offset=0.45, tipcex=0.7, statecex=0.7, splitcex=0.6, titlecex=0.8, plotsplits=TRUE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)

dev.off()
