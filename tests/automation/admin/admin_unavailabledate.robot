*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${START DATE}
${END DATE}
${COUNT SLOT}

*** Test Cases ***
Dentist Unavailable Date
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    View Dentist's Schedule
    Set Unavailable Date

Dentist Should Be Unavailable
    Dentist Should Be Listed Unavailable in Admin Page
    Logout Page
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Unavailable For Start Date
    Unavailable For Dates Between and End

*** Keywords ***
View Dentist's Schedule
    Set Selenium Speed  0.5
    Click Element   Daisy-Buchanan-view

Set Unavailable Date
    Click Element   unavailable
    Click Element   add-schedule
    Wait Until Page Contains     add-unavailable-modal
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    ${START DATE}=  Get Text    start-date
    ${END DATE}=    Get Text    end-date
    Click Element   add-unavailable-button

Dentist Should Be Listed Unavailable in Admin Page
    Element Text Should Be     class:success   Dentist unavailable date successfully added
    Table Should Contain    schedule-table      ${START DATE} - ${END DATE}
    Click Element   close-schedule-modal

Dentist Should Be Unavailable in Creating Appointments
    Sleep   1
    Click Element   add-button
    Sleep   1
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   cancel-appointment
    Sleep   1
    Click Element   discard

Unavailable For Start Date
    FOR     ${i} IN RANGE   10
        Exit For Loop If    focus-date-header == ${START DATE}
        Click Element   next-button
    Dentist Should Be Unavailable in Creating Appointments

Unavailable For Dates Between and End
    FOR     ${i} IN RANGE   10
        Exit For Loop If    focus-date-header == ${END DATE}
        Click Element   next-button
        Dentist Should Be Unavailable in Creating Appointments
    Dentist Should Be Unavailable in Creating Appointments

Unavailable in Availability Table
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN

