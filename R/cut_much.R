#' cut data
#'
#' group data for plot DEG volcano by FDR and logFC
#'
#' @param deg_data a DEG data frame contains logFC and p value
#' @param x which column is log FC
#' @param y which column is P value
#' @param cut_FC a single number character or numeric vector in threshold value of log FC
#' @param cut_P threshold value of P value, can set for every cut_FC number in numeric vector format
#' @param group colname of column save group info
#' @param label symbol word for groups
#' @param label_ns which group is the stable group
#'
#' @importFrom glue glue
#' @importFrom usethis ui_oops ui_info
#' @importFrom stringi stri_rand_strings
#'
#' @return add group column in data frame
#' @export
#'
#' @examples
#' cut_much(DEG_df, x = "log2FoldChange", y = "pvalue", cut_FC = 1,cut_P = 0.05,
#' label = c("Down","Stable","Up"), label_ns = "Stable")
cut_much <- function(deg_data,x, y,cut_FC = 1,cut_P = 0.05,group = 'group',label = c("Down","Stable","Up"), label_ns = "Stable") {

  ## check if name of group useful ----
  if(is.character(group)&&length(group)==1){

    if (group %in% colnames(deg_data)) {
      usethis::ui_oops(glue::glue("{ui_value(group)} is already in the colnames of data.\n{group}"))
      group = paste0(group,".",stringi::stri_rand_strings(1, 5))
      usethis::ui_oops(glue::glue("{ui_value(group)} will be used"))
    }

  } else {

    group = "group"
    group = paste0(group,".",stringi::stri_rand_strings(1, 5))
    usethis::ui_oops(c("Argument {usethis::ui_code('group')} should be a character of length 1.\nYour setting will ignore, {ui_value(group)} will be used to name your column of Group"))

  }
  ## ----

  if (length(cut_FC) == 1) {
    cut_FC <- c(-cut_FC, cut_FC)
  }
  if (length(cut_P) == 1) {
    cut_P <- rep(cut_P,length(cut_FC))
  }

  label_cg <- base::setdiff(label,label_ns)
  names(cut_P) <- label_cg
  deg_data$group <- cut(deg_data[,x],
                        breaks = c(-Inf,cut_FC,Inf),
                        labels = label)
  index = list()
  for (i in label_cg) {
    index[[i]] <- setdiff(which(deg_data$group == i), which(deg_data$group == i & deg_data[,y] < cut_P[i]))
    deg_data$group[index[[i]]] <- label_ns
  }

  ## 报告分组情况
  usethis::ui_done("Group done!")
  usethis::ui_info(glue("The threshold of the FC is {unique(abs(cut_FC))}"))
  usethis::ui_info(glue("The threshold of the FDR is {unique(abs(cut_P))}"))
  usethis::ui_info(paste(label, as.character(table(deg_data$group)),"\n"))

  return(deg_data)
}
