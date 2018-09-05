# Course events to calendar events

Each term, I enter my various coures assignments into my calendar as all-day events. Depending on the importance of
a given assignment, I create events in the preceding weeks, so I know to start thinking about it. This script automates that work: I input the assignment details and importance, and it generates the events for me to import into Google Calendar.

## Usage

The R file creates a function, `processFile` that takes an input filename and an output filename. The input filename should be a CSV in [the format described by the schema section](#schema). Running the function generates a new CSV in a format that can be [imported to Google Calendar](https://support.google.com/calendar/answer/37118?hl=en). 

Running the entire R file will run the function with the default parameters.

### Default parameters (configurable as function parameters)

* Input CSV filename: `course-events.csv`
* Output CSV filename: `calendar-events.csv`

## Example

Take this sample input. It has a test for the course with code "XYZ1000", scheduled for October 13th, at an importance level of `4`:

```
course,date,event,importance
XYZ1000,2018-10-13,Test,4
```

This is the output, once passed through the script:

```
Subject,Start Date,End Date,All Day Event
D!!! XYZ1000: Test,2018-10-13,2018-10-13,True
!! XYZ1000: Test (one week),2018-10-06,2018-10-06,True
! XYZ1000: Test (two weeks),2018-09-29,2018-09-29,True
XYZ1000: Test (three weeks),2018-09-22,2018-09-22,True
```

The output CSV can then be [imported to Google Calendar](https://support.google.com/calendar/answer/37118?hl=en).


## Schema

* `course`: The course code.
* `date`: The date, ideally in ISO-8601 format (e.g. "2018-10-13" for October 13, 2018).
* `event`: The name of the assignment (e.g. "Test").
* `importance`: How far in advance to create events. Choose from one of:
    * `1`: lowest importance, creates a "D!" event the day-of
    * `2`: low importance, creates a "D!!" event the day-of, and a "!" event the week before
    * `3`: middling importance, creates a "D!!" event the day-of, a "!" event the week before, and a "" event two weeks before
    * `4`: higher importance, creates a "D!!!" event the day-of, a "!!" event the week before, a "!" event two weeks before, and a "" event three weeks before
    * `5`: highest importance, creates a "D!!!" event the day-of, a "!!" event the week before, a "!" event two weeks before, a "" event three weeks before, and a "" event four weeks before
