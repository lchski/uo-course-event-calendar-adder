library(xfun)
library(tidyverse)

inputEvents <- read_csv("course-events.csv")

convertNumberOfWeeksToHumanString <- function(numberOfWeeks) {
  convertedString <- ""
  
  if (numberOfWeeks == 0) {
    return(convertedString)
  } else if (numberOfWeeks == 1) {
    convertedString <- paste(numbers_to_words(numberOfWeeks), "week")
  } else {
    convertedString <- paste(numbers_to_words(numberOfWeeks), "weeks")
  }
  
  return(paste("(", convertedString,")", sep = ""))
}

generateSubject <- function(course, event, prefix, numberOfWeeks = 0) {
  trimws(paste(prefix, " ", course, ": ", event, " ", convertNumberOfWeeksToHumanString(numberOfWeeks), sep = ""))
}

eventVector <- function(subject, date) {
  tibble(subject, startDate = date, endDate = date, allDay = TRUE)
}

processEvent <- function(course, date, event, importance) {
  switch(importance,
    {
      list(
        eventVector(generateSubject(course, event, "D!"), date)
      )
    },
    {
      list(
        eventVector(generateSubject(course, event, "D!!"), date),
        eventVector(generateSubject(course, event, "!", 1), date - 7)
      )
    },
    {
      list(
        eventVector(generateSubject(course, event, "D!!"), date),
        eventVector(generateSubject(course, event, "!", 1), date - 7),
        eventVector(generateSubject(course, event, "", 2), date - 14)
      )
    },
    {
      list(
        eventVector(generateSubject(course, event, "D!!!"), date),
        eventVector(generateSubject(course, event, "!!", 1), date - 7),
        eventVector(generateSubject(course, event, "!", 2), date - 14),
        eventVector(generateSubject(course, event, "", 3), date - 21)
      )
    },
    {
      list(
        eventVector(generateSubject(course, event, "D!!!"), date),
        eventVector(generateSubject(course, event, "!!", 1), date - 7),
        eventVector(generateSubject(course, event, "!", 2), date - 14),
        eventVector(generateSubject(course, event, "", 3), date - 21),
        eventVector(generateSubject(course, event, "", 4), date - 28)
      )
    }
  )
}
