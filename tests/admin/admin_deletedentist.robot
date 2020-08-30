*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${FIRST_NAME}   Jack
${LAST_NAME}    Skellington
${USERNAME}     skellington
${PASSWORD}     1234567890

*** Test Cases ***
Remove Dentist
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Delete Dentist

*** Keywords ***
Delete Dentist
    Click Element   data-name=delete data-firstname=Jack data-lastname=Skellington

Dentist Should Not Exist in Table
    Element Should Not Contain  table   ${FIRST_NAME} ${LASTNAME}   message=None    ignore_case=False

Deleted Dentist Cannot Login
    Input Username  ${USERNAME}
    Input Password  ${PASSWORD}
    Submit Credentials
    Logout Page