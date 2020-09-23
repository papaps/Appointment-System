*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Delete Dentist Unavailable Date
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Delete Dentist's Unavailable Schedule

*** Keywords ***
Delete Dentist's Unavailable Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    Click Element   unavailable
    ${date}=    Get Table Cell  schedule-table  1   1
    Click Element   delete-unavailable-button-0
    Page Should Contain Element     confirmation-modal
    Click Element   remove-unavailable-button
    Element Text Should Be  class:success   Unavailable date successfully deleted
    Element Should Not Contain    schedule-table  ${date}
