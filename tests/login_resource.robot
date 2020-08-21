*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${SERVER}         localhost:3000
${BROWSER}        Chrome
${DELAY}         0.2
${ASAP}          0
${VALID ADMIN}     admin
${VALID ADMIN PASSWORD}    @dmin
${VALID SECRETARY}     secretary
${VALID SECRETARY PASSWORD}    secret@ry
${VALID DENTIST}     buchanan
${VALID DENTIST PASSWORD}    1234567890
${LOGIN URL}      http://${SERVER}/login
${ADMIN URL}    http://${SERVER}/admin
${SECRETARY URL}    http://${SERVER}/secretary
${DENTIST URL}    http://${SERVER}/dentist

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed  ${DELAY}
    Login Page should be Open

Login Page Should Be Open
    Title Should Be     Access Dental Clinic | Login

Go To Login Page
    Go To   ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]     ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    submit

Admin Page Should Be Open
    Location Should Be    ${ADMIN URL}
    Title Should Be    Access Dental Clinic | Admin

Secretary Page Should Be Open
    Location Should Be    ${SECRETARY URL}
    Title Should Be    Access Dental Clinic | Secretary

Dentist Page Should Be Open
    Location Should Be    ${DENTIST URL}
    Title Should Be    Access Dental Clinic | Dentist

Logout Admin Page
    Click Button    logout