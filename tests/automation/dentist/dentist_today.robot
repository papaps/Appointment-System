*** Settings ***
Documentation    Suite description
Library  DateTime
Library  String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Today Button Should Work
    Login Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Click Next Week Button
    Click Next Week Button
    Click Today Button
    Date Should Be Today

*** Keywords ***
Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Get Today
    ${date}=    Get Current Date
    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%A, ${day} %B %Y
    [Return]        ${date}

Click Next Week Button
    Click Element   next-button

Click Today Button
    Click Element   today

Date Should Be Today
    ${today}=   Get Today
    Element Should Contain  weekly-status   ${today}