*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Invalid Username / Both Invalid Credentials Login
    Set Selenium Speed  0.5
    [Template]  Login With Invalid Username / Both Invalid Credentials Should Fail
    [Tags]                                      USER NAME            PASSWORD
    Invalid Admin Username                      invalid             ${VALID PASSWORD}
    Invalid Admin Username and Password         invalid             invalid
    Invalid Secretary Username                  invalid             ${VALID PASSWORD}
    Invalid Secretary Username and Password     invalid             invalid
    Invalid Dentist Username                    invalid             ${VALID PASSWORD}
    Invalid Dentist Username and Password       invalid             invalid
    Empty Username                              ${EMPTY}            ${VALID PASSWORD}
    Empty Username and Password                 ${EMPTY}            ${EMPTY}

Invalid Password Login
    [Template]  Login With Invalid Password Should Fail
    [Tags]                                      USER NAME            PASSWORD
    Invalid Admin Password                      ${VALID ADMIN}      invalid
    Invalid Secretary Password                  ${VALID SECRETARY}  invalid
    Invalid Dentist Password                    ${VALID DENTIST}    invalid
    Empty Password                              ${VALID ADMIN}      ${EMPTY}

*** Keywords ***
Login With Invalid Username / Both Invalid Credentials Should Fail
    [Arguments]    ${tag}   ${username}    ${password}
    Set Selenium Speed  ${ASAP}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Invalid Username

Login With Invalid Password Should Fail
    [Arguments]    ${tag}   ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Invalid Password

Invalid Username
#    Element Text Should Be   class:error   Invalid username
    Page Should Contain     Invalid username

Invalid Password
#    Element Text Should Be   class:error   Invalid password
    Page Should Contain     Invalid password