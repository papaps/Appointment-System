*** Settings ***
Documentation    Suite description
Library  DateTime
Library  String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Calendar Should Work
    Login Dentist
    Set Selenium Speed  0.5
    Sleep   1
    Calendar Past Date Should Work
    Click Today Button
    Calendar Future Date Should Work

*** Keywords ***
Login Dentist
    Input Username  ${VALID DENTIST}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Click Calendar Dropdown
    Click Element   standard_calendar

Click Today Button
    Click Element   today

Get Past Date
    ${date}=    Get Current Date
    ${date}=    Subtract Time From Date    ${date}  2 days
    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%A, ${day} %B %Y
    [Return]        ${date}

Get Future Date
    ${date}=    Get Current Date
    ${date}=    Add Time To Date    ${date}  2 days
    ${day}=     Convert Date    ${date}     result_format=%d
    ${day}=     Replace String Using Regexp    ${day}    ^0    ${EMPTY}
    ${date}=    Convert Date    ${date}     result_format=%A, ${day} %B %Y
    [Return]        ${date}

Date Should Be Changed Date
    [Arguments]  ${date}
    Element Should Contain  weekly-status   ${date}

Calendar Past Date Should Work
    Click Calendar Dropdown
    Press Keys  None    ARROW_LEFT
    Press Keys  None    ARROW_LEFT
    Press Keys  None    ENTER
    ${date}=    Get Past Date
    Date Should Be Changed Date  ${date}

Calendar Future Date Should Work
    Click Calendar Dropdown
    Press Keys  None    ARROW_RIGHT
    Press Keys  None    ARROW_RIGHT
    Press Keys  None    ENTER
    ${date}=    Get Future Date
    Date Should Be Changed Date  ${date}