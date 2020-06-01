library(ggtree)
library(ggnewscale)

mdA <- readr::read_delim(
  "data/tcda-allBLASThits.classified.txt", " ", col_names = FALSE
)
mdB <- readr::read_delim(
  "data/tcdb-allBLASThits.classified.txt", " ", col_names = FALSE
)

mdA[[1]] <- vapply(strsplit(mdA[[1]], ".", fixed = TRUE), function(x) x[1], character(1))
mdB[[1]] <- vapply(strsplit(mdB[[1]], ".", fixed = TRUE), function(x) x[1], character(1))

colnames(mdA) <- c("Acc", "ToxinSubtype", "PercentIdentity", "Length", "Status")
colnames(mdB) <- c("Acc", "ToxinSubtype", "PercentIdentity", "Length", "Status")

tree <- ape::read.tree("data/genomeTree.corrected.nwk")

md <- readr::read_tsv("data/ipg.txt")
md <- md[!is.na(md$Assembly), ]
md$Assembly <- vapply(strsplit(md$Assembly, ".", fixed = TRUE), function(x) x[1], character(1))
md$Acc <- vapply(strsplit(md$Acc, ".", fixed = TRUE), function(x) x[1], character(1))

md2 <- md[, c("Assembly", "Acc")]
md2$Assembly <- gsub("GCF", "GCA", md2$Assembly)

md2A <- dplyr::left_join(mdA, md2, by = c("Acc" = "Acc"))
md2B <- dplyr::left_join(mdB, md2, by = c("Acc" = "Acc"))

md2A <- md2A[!duplicated(md2A$Assembly), ]
md2B <- md2B[!duplicated(md2B$Assembly), ]

# cols <- RColorBrewer::brewer.pal(13, "Paired")
cols <- c("black","red","blue","orange","dark green","green","purple","cyan","pink","brown","gray","dark blue","dark cyan","white")

# TOXIN A - HIGH STRINGENCY -------------------------------------------------

tipsA1 <- md2A
tipsA1$ToxinSubtype[tipsA1$Status == "PARTIAL" & tipsA1$PercentIdentity >= 99] <- "Partial"
tipsA1$ToxinSubtype[tipsA1$PercentIdentity < 99] <- "Incomplete"
tipsA1 <- tipsA1[!is.na(tipsA1$Assembly), ]
tipsA1 <- data.frame(
  row.names = tipsA1$Assembly,
  SubToxin = tipsA1$ToxinSubtype
)

# TOXIN A - LOW STRINGENCY -------------------------------------------------

tipsA2 <- md2A
tipsA2$ToxinSubtype[tipsA2$PercentIdentity < 99] <- "Incomplete"
tipsA2 <- tipsA2[!is.na(tipsA2$Assembly), ]
tipsA2 <- data.frame(
  row.names = tipsA2$Assembly,
  SubToxin = tipsA2$ToxinSubtype
)

# TOXIN B - HIGH STRINGENCY -------------------------------------------------

tipsB1 <- md2B
tipsB1$ToxinSubtype[tipsB1$Status == "PARTIAL" & tipsB1$PercentIdentity >= 99] <- "Partial"
tipsB1$ToxinSubtype[tipsB1$PercentIdentity < 99] <- "Incomplete"
tipsB1 <- tipsB1[!is.na(tipsB1$Assembly), ]
tipsB1 <- data.frame(
  row.names = tipsB1$Assembly,
  SubToxin = tipsB1$ToxinSubtype
)

# TOXIN B - LOW STRINGENCY -------------------------------------------------

tipsB2 <- md2B
tipsB2$ToxinSubtype[tipsB2$PercentIdentity < 99] <- "Incomplete"
tipsB2 <- tipsB2[!is.na(tipsB2$Assembly), ]
tipsB2 <- data.frame(
  row.names = tipsB2$Assembly,
  SubToxin = tipsB2$ToxinSubtype
)

# TOXIN A + B - HIGH STRINGENCY -------------------------------------------------

tipsA1[tipsA1 == "Incomplete"] <- "Partial"
tipsB1[tipsB1 == "Incomplete"] <- "Partial"

# mdd <- md[, c("Strain", "Assembly")]
# mdd$Assembly <- gsub("GCF", "GCA", mdd$Assembly)
# mdd <- mdd[mdd$Assembly %in% tree$tip.label, ]
# mdd$ToxinASubtype <- tipsA1[mdd$Assembly, , drop = TRUE]
# mdd$ToxinBSubtype <- tipsB1[mdd$Assembly, , drop = TRUE]
# mdd <- rbind(mdd,
#   data.frame(Strain = NA, Assembly = tree$tip.label[!tree$tip.label %in% mdd$Assembly],
#     ToxinASubtype = tipsA1[tree$tip.label[!tree$tip.label %in% mdd$Assembly],, drop = TRUE],
#     ToxinBSubtype = tipsB1[tree$tip.label[!tree$tip.label %in% mdd$Assembly],, drop = TRUE]
#   )
# )
# # mdd <- mdd[!is.na(mdd$Strain), ]
# readr::write_tsv(mdd, "AssemblyToStrain2.tsv")

p <- gheatmap(
  ggtree(tree, branch.length = "none", layout = "circular"),
  tipsA1, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
) +
  scale_fill_manual(
    name = "Toxin A",
    values = c(cols[c(1:3, 8)], "gray90", "white")
  )

p <- gheatmap(
  p + new_scale_fill(),
  tipsB1, offset = 5, width = 0.1, colnames = FALSE, legend_title = "Toxin B"
) +
  scale_fill_manual(
    name = "Toxin B",
    breaks = c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10", "B11", "B12", "Partial", NA),
    values = c(cols[c(1, 8, 12, 9, 10, 6, 2, 4, 5, 7, 3, 11)], "gray90", "white")
  ) +
  ggtitle("Toxin A + B - High Stringency")

ggsave("figs/ToxinAB_HighStringency.pdf", p)

# TOXIN A + B - LOW STRINGENCY -------------------------------------------------

# tipsA2$SubToxin <- factor(tipsA2$SubToxin)
# tipsB2$SubToxin <- factor(tipsB2$SubToxin)
# tipsB2$SubToxin <- factor(tipsB2$SubToxin, levels = gtools::mixedsort(levels(tipsB2$SubToxin)))

# p <- ggtree(tree, branch.length = "none", layout = "circular")
# qq <- readr::read_tsv("./QueryTable.tsv")
# qq$TheLabel <- 1:nrow(qq)
# qq <- dplyr::left_join(qq, md2, by = c(Assembly = "Assembly"))
# p$data <- dplyr::left_join(p$data, qq, by = c(label = "Assembly"))
# p$data$ToLabel <- !is.na(p$data$ToxinType)

# ToLabel <- c("GCA_000009205", "GCA_001995155", "GCA_000027105", "GCA_900243125", "GCA_900243285", "GCA_900243235")
# ToLabel2 <- c("630", "VPI 10463", "R20291", "51680", "SUC36", "CD08-070")
# p$data$ToLabel <- NA_character_
# for (i in seq_along(ToLabel)) {
#   p$data$ToLabel[p$data$label == ToLabel[i]] <- ToLabel2[i]
# }

# mdd <- md[, c("Strain", "Assembly")]
# mdd$Assembly <- gsub("GCF", "GCA", mdd$Assembly)
# mdd <- mdd[mdd$Assembly %in% tree$tip.label, ]
# mdd$ToxinASubtype <- tipsA2[mdd$Assembly, , drop = TRUE]
# mdd$ToxinBSubtype <- tipsB2[mdd$Assembly, , drop = TRUE]
# mdd <- mdd[!is.na(mdd$Strain), ]
# readr::write_tsv(mdd, "AssemblyToStrain.tsv")

# p <- p + geom_tippoint(aes(subset = ToLabel), colour = "red")
# p <- p + geom_tiplab(aes(label = TheLabel, subset = ToLabel, angle = angle), offset = 0.5, size = 3)
# p <- p + ggrepel::geom_label_repel(aes(label = ToLabel))
# p <- p + geom_label(aes(label = ToLabel))
# p

# p <- gheatmap(
#   p,
#   tipsA2, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
# ) +
#   scale_fill_manual(
#     name = "Toxin A",
#     breaks = c("A1", "A2", "A3", "A6", "A7", "Incomplete", NA),
#     values = c(cols[c(1:3, 8, 5)], "gray90", "white")
#   )
#
# p <- gheatmap(
#   p + new_scale_fill(),
#   tipsB2, offset = 5, width = 0.1, colnames = FALSE, legend_title = "Toxin B"
# ) +
#   scale_fill_manual(
#     name = "Toxin B",
#     breaks = c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10", "B11", "B12", "Incomplete", NA),
#     values = c(cols[c(1, 8, 12, 9, 10, 6, 2, 4, 5, 7, 3, 11)], "gray90", "white")
#   ) +
#   ggtitle("Toxin A + B - Low Stringency")
#
# ggsave("figs/ToxinAB_LowStringency.pdf", p)

