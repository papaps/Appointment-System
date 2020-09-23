*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Edit Schedule
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    View Dentist's Schedule

*** Keywords ***
View Dentist's Schedule
    Set Selenium Speed  0.5
    Click Element   Daisy-Buchanan-view