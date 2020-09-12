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
    New Schedule Should Reflect In Adding Appointment
    New Schedule Should Reflect in Availablity

New Schedule Should Reflect In Adding Appointment
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

New Schedule Should Reflect in Availablity
    Click Element   filter-dropdown
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Mon'     Click Element  0-1
    ...     ELSE IF     '${date}'=='Tue'     Click Element  0-2
    ...     ELSE IF     '${date}'=='Wed'     Click Element  0-3
    ...     ELSE IF     '${date}'=='Thu'     Click Element  0-4
    ...     ELSE IF     '${date}'=='Fri'     Click Element  0-5
    ...     ELSE IF     '${date}'=='Sat'     Click Element  0-6
    ...     ELSE IF     '${date}'=='Sun'     Click Element  0-1
    Set Selenium Speed  0.05
    Table Cell Should Contain   availability-modal-table  2  2  Unavailable
    Table Cell Should Contain   availability-modal-table  3  2  Unavailable
    Table Cell Should Contain   availability-modal-table  4  2  Unavailable
    Table Cell Should Contain   availability-modal-table  5  2  Unavailable
    Table Cell Should Contain   availability-modal-table  6  2  Unavailable
    Table Cell Should Contain   availability-modal-table  7  2  Unavailable
#    Table Cell Should Contain   availability-modal-table  8  2  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  9  2  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  10  2  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  11  2  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  12  2  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  2  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  3  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  4  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  5  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  6  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  7  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  8  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  9  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  10  4  ${EMPTY}
#    Table Cell Should Contain   availability-modal-table  11  4  ${EMPTY}
    Table Cell Should Contain   availability-modal-table  11  4  Unavailable