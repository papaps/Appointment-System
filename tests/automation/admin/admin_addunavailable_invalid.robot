*** Settings ***
Documentation    Suite description
Library     BuiltIn
Library     DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${DELAY}    1

*** Test Cases ***
Invalid Unavailable Date Setup
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Add Appointment
    Logout Page

Invalid Unavailable Date
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Add Unavailable Schedule
    Interval Start Contains Appointment
#    Interval Contains Appointment
    Interval End Contains Appointment
    Empty Interval
    Backward Interval
    Logout Page

Invalid Unavailable Date Teardown
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Sleep   1
    Delete Appointment

*** Keywords ***
Add Appointment
    Set Selenium Speed  1
    Sleep   1
    Click Element   add-button
    ${date}=    Check For Date
    Run Keyword If  '${date}'=='Sat'    Action For Add Appointment Sat
    ...     ELSE    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Click Element   date-done
    Input Appointment Details

Action For Add Appointment Sat
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT

Check For Date
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}     result_format=%a
    [Return]        ${date}

Check For Start Date
    ${date}=    Check For Date
    ${today}=    Get Current Date
    ${sat}=     Set Saturday Date
    ${today}=    Convert Date    ${today}     result_format=%B %d, %Y
    ${today}=   Set Variable If  '${date}'=='Sat'   ${sat}
    [Return]        ${today}

Check For End Date
    ${date}=    Check For Date
    ${today}=    Get Current Date
    ${today}=    Convert Date    ${today}     result_format=%B %d, %Y
    [Return]        ${today}

Set Saturday Date
    ${today}=    Get Current Date
    ${today}=    Add Time To Date    ${today}   1 day
    ${today}=    Convert Date    ${today}     result_format=%B %d, %Y
    [Return]  ${today}

Input Appointment Details
    Set Selenium Speed  0.5
    Input Text   add-firstName  Five
    Input Text   add-lastName   Hargreeves
    Input Text   add-contact    09177777777
    Press Keys    None    TAB
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER
    Press Keys    None    TAB
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER

Rest
    Sleep   1

Add Schedule
    Click Element   add-schedule

Add Unavailable Schedule
    Set Selenium Speed  1
    Sleep   1
    Click Element   Daisy-Buchanan-view
    Click Element   unavailable
    Click Element   add-schedule

Delete Added Schedule
    Click Element   delete-unavailable-button-0
    Click Element   remove-unavailable-button

Interval Start Contains Appointment
    ${date}=    Check For Date
    Run Keyword If  '${date}'=='Sat'    Action For Appointment Start Sat
    ...     ELSE    Action For Appointment Start
    Press Keys    None    ENTER
    ${date}=    Check For Start Date
    Textfield Value Should Be   start-date-input    ${date}
    Press Keys    None    ESC

Action For Appointment Start Sat
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT

Action For Appointment Start
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Sleep   1
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT

Interval Contains Appointment
    Click Element   add-schedule
    ${date}=    Check For Date
    Press Keys    None    TAB
    Press Keys  None    ENTER
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Run Keyword If  '${date}'=='Sat'    Action For Contains, End, Backwards Appointment Sat
    ...     ELSE    Press Keys    None    ENTER
    Click Element   add-unavailable-button

#    ${exists}=  Run Keyword and Return Status   Page Should Not Contain Element  schedule-modal
#    Run Keyword If   ${exists}==False
#    ...     Run Keywords
#    ...     Delete Added Schedule
#    ...     Rest
#    ...     Add Schedule
#    ...     ELSE
    Action For Contains Appointment

Action For Contains, End, Backwards Appointment Sat
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER

Action For Contains Appointment
    Wait Until Page Contains   The chosen dates have appointment/s
    Press Keys    None    ESC
    Click Element   add-schedule

Interval End Contains Appointment
    ${date}=    Check For Date
    Press Keys    None    TAB
    Press Keys  None    ENTER
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Run Keyword If  '${date}'=='Sat'    Action For Contains, End, Backwards Appointment Sat
    ...     ELSE    Press Keys    None    ENTER
    Press Keys  None    TAB
    ${date}=    Check For End Date
#    Textfield Value Should Be   end-date-input    ${date}
    Press Keys    None    ESC
#    Click Element   add-unavailable-button
#    Page Should Contain    Please input a valid date

Empty Interval
    Click Element   add-schedule
    Click Element   add-unavailable-button
    Page Should Contain    Please input a valid date
    Press Keys    None    ESC

Backward Interval
    Click Element   add-schedule
    ${date}=    Check For Date
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Run Keyword If  '${date}'=='Sat'    Action For Contains, End, Backwards Appointment Sat
    ...     ELSE    Press Keys    None    ENTER
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Click Element   add-unavailable-button

    ${exists}=  Run Keyword and Return Status   Page Should Not Contain Element  schedule-modal
    Run Keyword If   ${exists}==False   Action For Backward Interval If
    ...     ELSE    Action For Backward Interval

Action For Backward Interval If
    Delete Added Schedule
    Click Element   close-schedule-modal

Action For Backward Interval Else
    Page Should Contain   Please input a valid date
    Press Keys    None    ESC

Delete Appointment
    Set Selenium Speed  0.5
    ${date}=    Check For Date
    Run Keyword If  '${date}'=='Sat'    Action For Delete Appointment Sat
    ...     ELSE    Click Element   next-button
    Click Element   slots-table
    Click Element   date-done-edit
    Click Element   edit-delete-button
    Click Element   edit-continue-button
#TO DO:  Success Delete Message

Action For Delete Appointment Sat
    Click Element   next-button
    Click Element   next-button