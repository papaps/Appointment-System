*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
View Dentist Unavailable Date
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Set Unavailable Date
    View Dentist's Unavailable Schedule
    Delete Dentist's Unavailable Schedule

*** Keywords ***
Set Unavailable Date
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    Click Element   unavailable
    Click Element   add-schedule
    Sleep   1
    Press Keys    None    ENTER
    Sleep   1
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    ${start}=  Get Value    start-date-input
    ${end}=    Get Value    end-date-input
    Set Suite Variable  ${START DATE}   ${start}
    Set Suite Variable  ${END DATE}   ${end}
    Click Element   add-unavailable-button
    Click Element   close-schedule-modal

View Dentist's Unavailable Schedule
    Click Element   Daisy-Buchanan-view
    Click Element   unavailable
    Table Should Contain    schedule-table      ${START DATE} - ${END DATE}

Delete Dentist's Unavailable Schedule
    Click Element   delete-unavailable-button-0
    Click Element   remove-unavailable-button
