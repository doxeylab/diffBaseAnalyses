library(ggtree)
library(ggnewscale)

SEQ_NAMES_A <- unlist(readRDS("ALL-names_A.RDS"))
SEQ_NAMES_B <- unlist(readRDS("ALL-names_B.RDS"))

names(SEQ_NAMES_A) <- gsub("^[A-Z][.]", "", names(SEQ_NAMES_A))
names(SEQ_NAMES_B) <- gsub("^[A-Z][.]", "", names(SEQ_NAMES_B))

mdA <- readr::read_delim(
  "tcda-allBLASThits.classified.txt", " ", col_names = FALSE
)
mdB <- readr::read_delim(
  "tcdb-allBLASThits.classified.txt", " ", col_names = FALSE
)

mdA[[1]] <- vapply(strsplit(mdA[[1]], ".", fixed = TRUE), function(x) x[1], character(1))
mdB[[1]] <- vapply(strsplit(mdB[[1]], ".", fixed = TRUE), function(x) x[1], character(1))

colnames(mdA) <- c("Acc", "ToxinSubtype", "PercentIdentity", "Length", "Status")
colnames(mdB) <- c("Acc", "ToxinSubtype", "PercentIdentity", "Length", "Status")

tree <- ape::read.tree("genomeTree.corrected.nwk")

md <- readr::read_tsv("ipg.txt")
md <- md[!is.na(md$Assembly), ]
md$Assembly <- vapply(strsplit(md$Assembly, ".", fixed = TRUE), function(x) x[1], character(1))
md$Acc <- vapply(strsplit(md$Acc, ".", fixed = TRUE), function(x) x[1], character(1))

md2 <- md[, c("Assembly", "Acc")]
md2$Assembly <- gsub("GCF", "GCA", md2$Assembly)

md2A <- dplyr::left_join(mdA, md2, by = c("Acc" = "Acc"))
md2B <- dplyr::left_join(mdB, md2, by = c("Acc" = "Acc"))

md2A <- md2A[!duplicated(md2A$Assembly), ]
md2B <- md2B[!duplicated(md2B$Assembly), ]

cols <- RColorBrewer::brewer.pal(12, "Paired")

# TOXIN A - HIGH STRINGENCY -------------------------------------------------

tipsA1 <- md2A
tipsA1$ToxinSubtype[tipsA1$Status == "PARTIAL" & tipsA1$PercentIdentity >= 99] <- "Partial"
tipsA1$ToxinSubtype[tipsA1$PercentIdentity < 99] <- "Incomplete"
tipsA1 <- tipsA1[!is.na(tipsA1$Assembly), ]
tipsA1 <- data.frame(
  row.names = tipsA1$Assembly,
  SubToxin = tipsA1$ToxinSubtype
)

p <- gheatmap(
  ggtree(tree, branch.length = "none", layout = "circular"),
  tipsA1, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
) +
  scale_fill_manual(
    name = "Toxin A",
    values = c(cols[c(2, 4, 6, 8, 10)], "#000000", "#999999")
  ) +
  ggtitle("Toxin A - High Stringency")

ggsave("figs/ToxinA_HighStringency.pdf", p)

# TOXIN A - LOW STRINGENCY -------------------------------------------------

tipsA1 <- md2A
tipsA1$ToxinSubtype[tipsA1$PercentIdentity < 99] <- "Incomplete"
tipsA1 <- tipsA1[!is.na(tipsA1$Assembly), ]
tipsA1 <- data.frame(
  row.names = tipsA1$Assembly,
  SubToxin = tipsA1$ToxinSubtype
)

p <- gheatmap(
  ggtree(tree, branch.length = "none", layout = "circular"),
  tipsA1, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
) +
  scale_fill_manual(
    name = "Toxin A",
    values = c(cols[c(2, 4, 6, 8, 10)], "#000000")
  ) +
  ggtitle("Toxin A - Low Stringency")

ggsave("figs/ToxinA_LowStringency.pdf", p)

# TOXIN B - HIGH STRINGENCY -------------------------------------------------

tipsB1 <- md2B
tipsB1$ToxinSubtype[tipsB1$Status == "PARTIAL" & tipsB1$PercentIdentity >= 99] <- "Partial"
tipsB1$ToxinSubtype[tipsB1$PercentIdentity < 99] <- "Incomplete"
tipsB1 <- tipsB1[!is.na(tipsB1$Assembly), ]
tipsB1 <- data.frame(
  row.names = tipsB1$Assembly,
  SubToxin = tipsB1$ToxinSubtype
)

p <- gheatmap(
  ggtree(tree, branch.length = "none", layout = "circular"),
  tipsB1, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
) +
  scale_fill_manual(
    name = "Toxin A",
    values = c(cols[1:9], "#000000", cols[10], "#999999")
  ) +
  ggtitle("Toxin B - High Stringency")

ggsave("figs/ToxinB_HighStringency.pdf", p)

# TOXIN B - LOW STRINGENCY -------------------------------------------------

tipsB1 <- md2B
tipsB1$ToxinSubtype[tipsB1$PercentIdentity < 99] <- "Incomplete"
tipsB1 <- tipsB1[!is.na(tipsB1$Assembly), ]
tipsB1 <- data.frame(
  row.names = tipsB1$Assembly,
  SubToxin = tipsB1$ToxinSubtype
)

p <- gheatmap(
  ggtree(tree, branch.length = "none", layout = "circular"),
  tipsB1, offset = 0.5, width = 0.1, colnames = FALSE, legend_title = "Toxin A"
) +
  scale_fill_manual(
    name = "Toxin A",
    values = c(cols[1:9], "#000000", cols[10])
  ) +
  ggtitle("Toxin B - Low Stringency")

ggsave("figs/ToxinB_LowStringency.pdf", p)
