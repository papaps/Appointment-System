*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Invalid Reset Schedule
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Click To Edit Schedule

Invalid Regular Daily
    Blank Schedule
    Empty Regular Daily
    Backward Regular Daily
    Short Regular Daily

Invalid Custom Daily
    Empty Custom
    Empty Custom Daily
    Backward Custom Daily
    Duplicate Custom Daily
    Overlap Schedule Custom
    Short Custom Daily

Invalid Regular Recurrence
    Empty Regular Recurrence
    Backward Regular Recurrence
    Short Regular Recurrence

Invalid Custom Recurrence
    Empty Custom Recurrence
    Backward Custom Recurrence
    Duplicate Custom Recurrence
    Overlap Schedule Recurrence
    Short Custom Recurrence

*** Keywords ***
Click To Edit Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    Click Element   add-schedule

Click Repeat Daily
    Click Element   daily-field

Click Custom Hours
    Click Element   custom-field

Click Recurrence
    Click Element   repeat-field

Click Dates
    Click Element   mon
    Click Element   wed
    Click Element   fri

Delete Regular Input
    Set Selenium Speed  0.3
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Set Selenium Speed  0.5

Delete Custom Input
    Set Selenium Speed  0.3
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   start
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Double Click Element   end
    Press Keys  None    DELETE
    Double Click Element   start-add
    Press Keys  None    DELETE
    Double Click Element   start-add
    Press Keys  None    DELETE
    Double Click Element   start-add
    Press Keys  None    DELETE
    Double Click Element   start-add
    Press Keys  None    DELETE
    Double Click Element   end-add
    Press Keys  None    DELETE
    Double Click Element   end-add
    Press Keys  None    DELETE
    Double Click Element   end-add
    Press Keys  None    DELETE
    Set Selenium Speed  0.5

Blank Schedule
    Click Element   add-schedule-button
    Page Should Contain     Please choose an occurence
    Page Should Contain     Please input a valid time

Empty Regular Daily
    Click Repeat Daily
    Click Element   add-schedule-button
    Page Should Contain     Please input a valid time

Backward Regular Daily
    Input Text  start   9:00
    Input Text  end     8:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Short Regular Daily
    Delete Regular Input
    Input Text  start   8:00
    Input Text  end     8:00
    Click Element   add-header
    Click Element   add-schedule-button
    Wait Until Page Contains    Time interval is too short

Empty Custom
    Delete Regular Input
    Click Repeat Daily
    Click Custom Hours
    Click Element   add-schedule-button
    Page Should Contain     Please choose an occurence
    Page Should Contain     Please input a valid time

Empty Custom Daily
    Click Repeat Daily
    Click Element   add-schedule-button
    Page Should Contain     Please input a valid time

Backward Custom Daily
    Input Text  start   9:00
    Input Text  end     8:00
    Input Text  start-add   10:00
    Input Text  end-add     11:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Duplicate Custom Daily
    Delete Custom Input
    Input Text  start  8:00
    Input Text  end    9:00
    Input Text  start-add  8:00
    Input Text  end-add   9:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Overlap Schedule Custom
    Delete Custom Input
    Input Text  start  8:00
    Input Text  end    9:00
    Input Text  start-add  8:30
    Input Text  end-add   10:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain    Invalid time interval

Short Custom Daily
    Delete Custom Input
    Input Text  start   8:00
    Input Text  end     9:00
    Input Text  start-add   9:00
    Input Text  end-add     10:00
    Click Element   add-header
    Click Element   add-schedule-button
    Wait Until Page Contains    Time interval is too short

Empty Regular Recurrence
    Delete Custom Input
    Click Repeat Daily
    Click Custom Hours
    Click Recurrence
    Click Element   add-schedule-button
    Page Should Contain     Please input a valid time
    Page Should Contain     Please choose a specific day of reoccurence

Backward Regular Recurrence
    Input Text  start   9:00
    Input Text  end     8:00
    Click Element   add-header
    Click Dates
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Short Regular Recurrence
    Delete Regular Input
    Input Text  start   8:00
    Input Text  end     8:00
    Click Element   add-header
    Click Element   add-schedule-button
    Wait Until Page Contains    Time interval is too short

Empty Custom Recurrence
    Delete Regular Input
    Click Custom Hours
    Click Dates
    Click Element   add-schedule-button
    Page Should Contain     Please input a valid time
    Page Should Contain     Please choose a specific day of reoccurence

Backward Custom Recurrence
    Input Text  start   9:00
    Input Text  end     8:00
    Input Text  start-add   10:00
    Input Text  end-add     11:00
    Click Element   add-header
    Click Dates
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Duplicate Custom Recurrence
    Delete Custom Input
    Input Text  start  8:00
    Input Text  end    9:00
    Input Text  start-add  8:00
    Input Text  end-add   9:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain     Invalid time interval

Overlap Schedule Recurrence
    Delete Custom Input
    Input Text  start  8:00
    Input Text  end    9:00
    Input Text  start-add  8:30
    Input Text  end-add   10:00
    Click Element   add-header
    Click Element   add-schedule-button
    Page Should Contain    Invalid time interval

Short Custom Recurrence
    Delete Custom Input
    Input Text  start   8:00
    Input Text  end     9:00
    Input Text  start-add   9:00
    Input Text  end-add     10:00
    Click Element   add-header
    Click Element   add-schedule-button
    Wait Until Page Contains    Time interval is too short



