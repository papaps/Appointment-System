*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
View Dentist Schedule Should Be Correct
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    View Dentist's Schedule
    Schedule Table Should Be Correct

*** Keywords ***
View Dentist's Schedule
    Set Selenium Speed  0.05
    Click Element   Daisy-Buchanan-view

Schedule Table Should Be Correct
    Table Row Should Contain    schedule-table  1  Monday
    Table Row Should Contain    schedule-table  1  8:00 - 18:00
    Table Row Should Contain    schedule-table  2  Tuesday
    Table Row Should Contain    schedule-table  2  8:00 - 18:00
    Table Row Should Contain    schedule-table  3  Wednesday
    Table Row Should Contain    schedule-table  3  8:00 - 18:00
    Table Row Should Contain    schedule-table  4  Thursday
    Table Row Should Contain    schedule-table  4  8:00 - 18:00
    Table Row Should Contain    schedule-table  5  Friday
    Table Row Should Contain    schedule-table  5  8:00 - 18:00
    Table Row Should Contain    schedule-table  6  Saturday
    Table Row Should Contain    schedule-table  6  8:00 - 18:00