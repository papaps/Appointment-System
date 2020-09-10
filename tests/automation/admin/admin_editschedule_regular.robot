*** Settings ***
Documentation    Suite description
Library     DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Edit Schedule Regular
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Edit Date Schedule
    Input New Schedule

New Schedule Should Be Set
    New Schedule Should Be in Admin View
    Logout Page
    Set Selenium Speed  0.5
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    New Schedule Should Be in Secretary View

*** Keywords ***
Get Date
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}     result_format=%a
    Log To Console  date ${date}
    [Return]        ${date}

Edit Date Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Mon'     Click Element   Monday-edit
    ...     ELSE IF     '${date}'=='Tue'     Click Element   Tuesday-edit
    ...     ELSE IF     '${date}'=='Wed'     Click Element   Wednesday-edit
    ...     ELSE IF     '${date}'=='Thu'     Click Element   Thursday-edit
    ...     ELSE IF     '${date}'=='Fri'     Click Element   Friday-edit
    ...     ELSE IF     '${date}'=='Sat'     Click Element   Saturday-edit
    ...     ELSE IF     '${date}'=='Sun'     Click Element   Monday-edit

Input New Schedule
    Set Selenium Speed  0.3
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-start
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Double Click Element   edit-end
    Press Keys  None    DELETE
    Input Text  edit-start  11:00
    Input Text  edit-end    17:30
    Set Selenium Speed  0.5
    Click Element   editing-schedule-modal
    Click Element   save-changes-schedule

New Schedule Should Be in Admin View
    ${date}=    Get Date
    Element Text Should Be  class:success   Dentist schedule successfully edited
    Run Keyword If  '${date}'=='Mon'     Changed Table Monday
    ...     ELSE IF     '${date}'=='Tue'     Changed Table Tuesday
    ...     ELSE IF     '${date}'=='Wed'     Changed Table Wednesday
    ...     ELSE IF     '${date}'=='Thu'     Changed Table Thursday
    ...     ELSE IF     '${date}'=='Fri'     Changed Table Friday
    ...     ELSE IF     '${date}'=='Sat'     Changed Table Saturday
    ...     ELSE IF     '${date}'=='Sun'     Changed Table Monday
    Click Element   close-schedule-modal

Changed Table Monday
    Table Row Should Contain    schedule-table  1  Monday
    Table Row Should Contain    schedule-table  1  11:00 - 17:30

Changed Table Tuesday
    Table Row Should Contain    schedule-table  2  Tuesday
    Table Row Should Contain    schedule-table  2  11:00 - 17:30

Changed Table Wednesday
    Table Row Should Contain    schedule-table  3  Wednesday
    Table Row Should Contain    schedule-table  3  11:00 - 17:30

Changed Table Thursday
    Table Row Should Contain    schedule-table  4  Thursday
    Table Row Should Contain    schedule-table  4  11:00 - 17:30

Changed Table Friday
    Table Row Should Contain    schedule-table  5  Friday
    Table Row Should Contain    schedule-table  5  11:00 - 17:30

Changed Table Saturday
    Table Row Should Contain    schedule-table  6  Saturday
    Table Row Should Contain    schedule-table  6  11:00 - 17:30

New Schedule Should Be in Secretary View
    Click Element   add-button
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Sun'  Press Keys    None    ARROW_RIGHT
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

#TO DO: New Schedule Should Reflect in Availablity