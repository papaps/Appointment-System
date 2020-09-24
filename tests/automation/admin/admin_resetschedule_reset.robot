*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
Reset Dentist Schedule
    Login Admin
    Set Selenium Speed  0.5
    Sleep   1
    Reset Dentist
    Schedule Should Be Reset

*** Keywords ***
Login Admin
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Click View Dentist Schedule
    Click Element   Daisy-Buchanan-view

Click Reset Schedule
    Click Element   add-schedule

Click Repeat Daily
    Click Element   daily-field

Click Confirm
    Click Element   add-schedule-button

Click Outside
    Click Element   add-header

Input Start Time
    Input Text  start     8:00

Input End Time
    Input Text  end       18:00

Reset Dentist
    Click View Dentist Schedule
    Click Reset Schedule
    Click Repeat Daily
    Input Start Time
    Input End Time
    Click Outside
    Click Confirm

Schedule Should Be Reset
    Table Row Should Contain    schedule-table  1  8:00 - 18:00
    Table Row Should Contain    schedule-table  2  8:00 - 18:00
    Table Row Should Contain    schedule-table  3  8:00 - 18:00
    Table Row Should Contain    schedule-table  4  8:00 - 18:00
    Table Row Should Contain    schedule-table  5  8:00 - 18:00
    Table Row Should Contain    schedule-table  6  8:00 - 18:00