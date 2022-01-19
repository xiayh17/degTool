#
#
# rep_ids <- function(data,ids) {
#
#   rownames(data) %in% ids
#
#
# }
#
# data = counts_input
# rownames(data) = gid
# data = data[,-1]
#
# library(AnnoProbe)
# ids = annoGene(gid,'ENSEMBL')
#
#
# rm(list = ls())
# library(data.table)
# counts_input = fread(file = "dev/GSE186581/GSE186581_All.HTSeq.counts.txt",
#                      data.table = F)
# group_list = rep(c("autophagy","control"),each =2);group_list
#
# counts_input = na.omit(counts_input)
#
# mat = counts_input[,-1]
# mat[1:4,1:4]
# dim(mat)
# keep_feature <- rowSums (mat > 1) > 1
# table(keep_feature)
# counts_input=counts_input[keep_feature,]
# gid=counts_input$AccID
#
# library(AnnoProbe)
# ids = annoGene(gid,'ENSEMBL')
# ids[1:4,1:4]
# dim(ids)
# counts_input = counts_input[gid %in% ids$ENSEMBL,]
# gid=counts_input$AccID
#
# length(unique(ids$SYMBOL))
# gs = ids[match(gid,ids$ENSEMBL),1]
# length(unique(gs))
#
# kp= !duplicated(gs)
# table(kp)
# counts_input = counts_input[kp,-1]
# rownames(counts_input) = gs[kp]
# counts_input[1:4,1:4]
#
# group_list = rep(c("autophagy","control"),each =2);group_list
# save(counts_input,group_list,file = 'input.Rdata')
