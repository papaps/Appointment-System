*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${CUR_PASS}   1234567890
${NEW_PASS}   0123456789

*** Test Cases ***
Reset Admin Password
    Input Username    admin
    Input Password    1234567890
    Submit Credentials
    Reset Admin
    Logout Page
    Input Username    admin
    Input Password    0123456789
    Submit Credentials
    Revert Admin
    Logout Page

#Invalid Edit Password
#    [Tags]                      CUR_PASSWORD    NEW_PASSWORD
#    Wrong Current Password      ${NEW_PASS}     ${CUR_PASS}


*** Keywords ***
Reset Admin
    Set Selenium Speed  0.1
    Click Element   resetAdmin
    Input Text    current-password        ${CUR_PASS}
    Input Text    new-password            ${NEW_PASS}
    Input Text    confirm-new-password    ${NEW_PASS}
    Click Element   save-password

Revert Admin
    Click Element   resetAdmin
    Input Text    current-password        ${NEW_PASS}
    Input Text    new-password            ${CUR_PASS}
    Input Text    confirm-new-password    ${CUR_PASS}
    Click Element   save-password

#Reset Admin with Incorrect Inputs
#    [Arguments]  ${tag}     ${curr_password}    ${new_password}
#    Input Text    current-password        ${curr_password}
#    Input Text    new-password            ${new_password}
#    Input Text    confirm-new-password    ${new_password}
#    Click Element   save-password
#
#Invalid Current Password
#    Element Should Be Visible   message=Incorrect current password
#
#Invalid Matching Passwords
#    Element Should Be Visible   message=Passwords do not match