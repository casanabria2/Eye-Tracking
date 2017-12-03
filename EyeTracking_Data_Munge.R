filePrefix <- "PostTest_Form_B_"
setwd("/Users/csanabria/Dropbox/Data\ Science/UCI/Eye\ Tracking")
participantData <- read.table(
  file = paste(filePrefix, "Input.csv", sep = ""),
  header = TRUE,
  sep = ","
)
library(dplyr)
ItemTypeTable <- read.table(
  file = "ItemTypeTable.csv",
  header = TRUE,
  sep = ","
)
ItemType <- function (form, item) {
  code <- ItemTypeTable %>%
    filter(
      Form == form,
      Item == item
    ) %>%
    select (ItemTypeNumber) %>%
    as.data.frame
    return(code[1,1])
  }
temp <- mutate(
  .data = participantData,
  Child_ID = ParticipantName,
  ItemNumber = substr(AOI,5,7),
  ShortForm = substr(Form,6,7),
  TotalReadTime = TotalFixationDuration_1stFixation_last + RereadingTime_last,
  GazeDuration = TotalFixationDuration_1stFixation_last,
  RereadingTime = RereadingTime_last,
  FirstFixationDuration = FirstFixationDuration_last
  )

#Process Task 1
temp2 <- filter(
  .data = temp,
  substr(ItemNumber,1,1) == 1
)
temp3 <- temp2 %>%
  rowwise() %>%
  mutate(ItemType0word1nonword = ItemType(ShortForm,ItemNumber)) %>%
  as.data.frame()
df_Task_1 <- select(
  .data = temp3,
  Child_ID, ItemNumber, ItemType0word1nonword, GazeDuration, FirstFixationDuration, RereadingTime, TotalReadTime
  )
write.csv(df_Task_1,
  file = paste(filePrefix, "Task_1.csv", sep = ""),
  row.names = FALSE
  )

#Process Task 2
temp2 <- filter(
  .data = temp,
  substr(ItemNumber,1,1) == 2
)
temp3 <- temp2 %>%
  rowwise() %>%
  mutate(ItemType0English1Spanish = ItemType(ShortForm,ItemNumber)) %>%
  as.data.frame()
df_Task_2 <- select(
  .data = temp3,
  Child_ID, ItemNumber, ItemType0English1Spanish, GazeDuration, FirstFixationDuration, RereadingTime, TotalReadTime
)
write.csv(df_Task_2,
          file = paste(filePrefix, "Task_2.csv", sep = ""),
          row.names = FALSE
)

#Process Task 3
temp2 <- filter(
  .data = temp,
  substr(ItemNumber,1,1) == 3
)
temp3 <- temp2 %>%
  rowwise() %>%
  mutate(ItemType0familiar1unfamiliar = ItemType(ShortForm,ItemNumber)) %>%
  as.data.frame()
df_Task_3 <- select(
  .data = temp3,
  Child_ID, ItemNumber, ItemType0familiar1unfamiliar, GazeDuration, FirstFixationDuration, RereadingTime, TotalReadTime
)
write.csv(df_Task_3,
          file = paste(filePrefix, "Task_3.csv", sep = ""),
          row.names = FALSE
)

#Process Task 4
temp2 <- filter(
  .data = temp,
  substr(ItemNumber,1,1) == 4
)
temp3 <- temp2 %>%
  rowwise() %>%
  mutate(ItemType0plausible1implausible = ItemType(ShortForm,ItemNumber)) %>%
  as.data.frame()
df_Task_4 <- select(
  .data = temp3,
  Child_ID, ItemNumber, ItemType0plausible1implausible, GazeDuration, FirstFixationDuration, RereadingTime, TotalReadTime
)
write.csv(df_Task_4,
          file = paste(filePrefix, "Task_4.csv", sep = ""),
          row.names = FALSE
)
