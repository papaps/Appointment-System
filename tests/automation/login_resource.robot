*** Settings ***
Library  SeleniumLibrary    run_on_failure=NOTHING

*** Variables ***
#${SERVER}         localhost:3000
${SERVER}         https://access-dental.herokuapp.com/
${BROWSER}        Chrome
${DELAY}         0.2
${ASAP}          0
${VALID ADMIN}     admin
${VALID SECRETARY}     secretary
${VALID DENTIST}     buchanan
${VALID PASSWORD}    1234567890
${LOGIN URL}      http://${SERVER}/login
${ADMIN URL}    http://${SERVER}/admin
${SECRETARY URL}    http://${SERVER}/secretary
${DENTIST URL}    http://${SERVER}/dentist

*** Keywords ***
Open Browser To Login Page Slow
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed  ${DELAY}
    Login Page should be Open

Open Browser To Login Page
    #Open Browser    ${LOGIN URL}    ${BROWSER}
	${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Maximize Browser Window
    Set Selenium Speed  ${ASAP}

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

Login Page Should Be Open
    Location Should Be    ${LOGIN URL}
    Title Should Be     Access Dental Clinic | Login

Admin Page Should Be Open
    Location Should Be    ${ADMIN URL}
    Title Should Be    Access Dental Clinic | Admin

Secretary Page Should Be Open
    Location Should Be    ${SECRETARY URL}
    Title Should Be    Access Dental Clinic | Secretary

Dentist Page Should Be Open
    Location Should Be    ${DENTIST URL}
    Title Should Be    Access Dental Clinic | Dentist

Logout Page
    Click Element    logoutButton