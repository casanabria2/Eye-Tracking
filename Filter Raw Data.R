# This R script gets rid of the "Rectangle" variables and binds the timestamp from the original Eye tracking data

setwd("/Users/csanabria/Dropbox/Data\ Science/UCI/Eye\ Tracking/Raw\ Data")
#File Name with no extension. Extension has to be CSV.
InputFileName_Data = "Midtest\ Form\ B\ 112917"
InputFileName_TimeStamp = "midtest\ B\ timstamp"
# DONT CHANGE BELOW

rawdata <- read.table(
  file = paste(InputFileName_Data, ".CSV", sep = ""),
  header = TRUE,
  sep = ","
)


filtered_data <- rawdata[ , -which(startsWith(names(rawdata),"AOI.Rectangle"))]
timestamp_data <- read.table(
  file = paste(InputFileName_TimeStamp, ".CSV", sep = ""),
  header = TRUE,
  sep = ","
)

library(dplyr)

timestamp_data <- filter(
  .data = timestamp_data,
  RecordingTimestamp > 0
)

filtered_data <- cbind(filtered_data, timestamp_data[,"RecordingTimestamp"])

colnames(filtered_data)[length(colnames(filtered_data))] <- "RecordingTimestamp"

filtered_data <- mutate(
  .data = filtered_data,
  ParticipantNameShort = as.integer(sapply(strsplit(as.character(ParticipantName), "_"), "[", 2))
)

filtered_data <- filtered_data[ , -which(names(filtered_data) %in% c("ParticipantName"))]

colnames(filtered_data)[length(colnames(filtered_data))] <- "ParticipantName"
colnames(filtered_data)[1] <- "Form"

write.csv(filtered_data,
          file = paste(InputFileName_Data, "\ filtered\ by\ R.csv", sep = ""),
          row.names = FALSE
)
