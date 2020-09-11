*** Settings ***
Documentation    Suite description
Library     DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Delete Schedule
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Delete Date Schedule

Deleted Schedule Should Reflect
    Deleted Schedule Should Be in Admin View
    Logout Page
    Set Selenium Speed  0.5
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Deleted Schedule Should Be in Secretary View

*** Keywords ***
Get Date
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}     result_format=%a
    [Return]        ${date}

Delete Date Schedule
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
    Click Element   delete-schedule
    Click Element   remove-schedule-button

Deleted Schedule Should Be in Admin View
    ${date}=    Get Date
    Element Text Should Be  class:success   Dentist schedule successfully removed
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
    Table Row Should Contain    schedule-table  1  -

Changed Table Tuesday
    Table Row Should Contain    schedule-table  2  Tuesday
    Table Row Should Contain    schedule-table  2  -

Changed Table Wednesday
    Table Row Should Contain    schedule-table  3  Wednesday
    Table Row Should Contain    schedule-table  3  -

Changed Table Thursday
    Table Row Should Contain    schedule-table  4  Thursday
    Table Row Should Contain    schedule-table  4  -

Changed Table Friday
    Table Row Should Contain    schedule-table  5  Friday
    Table Row Should Contain    schedule-table  5  -

Changed Table Saturday
    Table Row Should Contain    schedule-table  6  Saturday
    Table Row Should Contain    schedule-table  6  -

Deleted Schedule Should Be in Secretary View
    Deleted Schedule Should Reflect In Adding Appointment
    Deleted Schedule Should Reflect in Availablity

Deleted Schedule Should Reflect In Adding Appointment
    Click Element   add-button
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Sun'  Action For Add Appointment Sun
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

Action For Add Appointment Sun
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER

Deleted Schedule Should Reflect in Availablity
    Click Element   filter-dropdown
    Sleep   1
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Mon'     Element Text Should Be  0-1    Unavailable
    ...     ELSE IF     '${date}'=='Tue'     Element Text Should Be  0-2    Unavailable
    ...     ELSE IF     '${date}'=='Wed'     Element Text Should Be  0-3    Unavailable
    ...     ELSE IF     '${date}'=='Thu'     Element Text Should Be  0-4    Unavailable
    ...     ELSE IF     '${date}'=='Fri'     Element Text Should Be  0-5    Unavailable
    ...     ELSE IF     '${date}'=='Sat'     Element Text Should Be  0-6    Unavailable
    ...     ELSE IF     '${date}'=='Sun'     Element Text Should Be  0-1    Unavailable