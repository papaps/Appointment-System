*** Settings ***
Documentation    Suite description
Library  DateTime
Library  String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
Last Week Button Should Work
    Login Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Last Week Button
    Date Should Be Last Week Date

*** Keywords ***
Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Get Last Week Date
    ${date}=    Get Current Date
    ${date}=    Subtract Time From Date    ${date}  7 days
    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%A, ${day} %B %Y
    [Return]        ${date}

Click Last Week Button
    Click Element   prev-button

Date Should Be Last Week Date
    ${last}=   Get Last Week Date
    Element Should Contain  weekly-status   ${last}