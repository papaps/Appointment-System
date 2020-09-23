*** Settings ***
Documentation    Suite description
Library  DateTime
Library  String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Next Week Button Should Work
    Login Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Next Week Button
    Date Should Be Next Week Date

*** Keywords ***
Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Get Next Week Date
    ${date}=    Get Current Date
    ${date}=    Add Time To Date    ${date}  7 days
    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%A, ${day} %B %Y
    [Return]        ${date}

Click Next Week Button
    Click Element   next-button

Date Should Be Next Week Date
    ${next}=   Get Next Week Date
    Element Should Contain  weekly-status   ${next}