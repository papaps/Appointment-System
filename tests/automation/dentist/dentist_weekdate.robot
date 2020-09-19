*** Settings ***
Documentation    Suite description
Library  DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Week Date Button Should Work
    Login Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Sunday Button
    Click Monday Button
    Click Tuesday Button
    Click Wednesday Button
    Click Thursday Button
    Click Friday Button
    Click Saturday Button

*** Keywords ***
Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Click Sunday Button
    Click Element   Sunday
    Element Should Contain  weekly-status   Sunday

Click Monday Button
    Click Element   Monday
    Element Should Contain  weekly-status   Monday

Click Tuesday Button
    Click Element   Tuesday
    Element Should Contain  weekly-status   Tuesday

Click Wednesday Button
    Click Element   Wednesday
    Element Should Contain  weekly-status   Wednesday

Click Thursday Button
    Click Element   Thursday
    Element Should Contain  weekly-status   Thursday

Click Friday Button
    Click Element   Friday
    Element Should Contain  weekly-status   Friday

Click Saturday Button
    Click Element   Saturday
    Element Should Contain  weekly-status   Saturday