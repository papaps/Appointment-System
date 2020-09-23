*** Settings ***
Documentation    Suite description
Library     String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${START DATE}   September 11, 2020
${END DATE}     September 13, 2020
${COUNT}    0

*** Test Cases ***
Dentist Should Be Unavailable
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Unavailable in Availability Table

*** Keywords ***
Set Count
    ${COUNT}=   Evaluate    ${COUNT}+1
    ${COUNT}=   Set Suite Variable  ${COUNT}

Check for Unavailable
    FOR     ${i}     IN RANGE   2   9
            ${unavailable}=     Run Keyword and Return Status   Table Cell Should Contain   schedule-table  2   ${i}   Unavailable
            Run Keyword If  '${unavailable}'=='True'   Set Count
    END

Unavailable in Availability Table
    ${start}=   Split String    ${START DATE}
    ${start}=   Split String    ${start}[1]     separator=,
    ${start}=   Set Variable    ${start}[0]
    ${end}=   Split String    ${END DATE}
    ${end}=   Split String    ${end}[1]     separator=,
    ${end}=   Set Variable    ${end}[0]
    ${week}=    Split String    2 3 4 5 6 7
    Sleep   0.5
    Set Selenium Speed  0.4
    Click Element   filter-dropdown
    Press Keys    None    ARROW_DOWN
    Press Keys    None    ENTER

    Set Selenium Speed  0.1
    ${COUNT}=    Set Variable    0
    ${weekend}=   Run Keyword and Return Status   Element Should Contain  weekdates   ${end}
    ${start_on_sunday}=  Run Keyword and Return Status   Table Cell Should Contain   schedule-table  1   1   ${start}
    ${end_on_sunday}=  Run Keyword and Return Status   Table Cell Should Contain   schedule-table  1   1   ${end}
    Check For Unavailable
    Run Keyword If  '${start_on_sunday}'=='False' and '${weekend}'=='True' and '${end_on_sunday}'=='True'  Variable Should Exist   ${COUNT}    2
    ...   ELSE IF   '${start_on_sunday}'=='False' and '${weekend}'=='True' and '${end_on_sunday}'=='False'  Variable Should Exist   ${COUNT}    3
    ...   ELSE IF   '${start_on_sunday}'=='True'  Variable Should Exist   ${COUNT}    2
    ...   ELSE IF   ${weekend}==False
    ...   Run Keywords
    ...   Click Element     next-button
    ...   AND   Check For Unavailable
    ${on_sunday}=  Run Keyword and Return Status   Table Cell Should Contain   schedule-table  1   1   ${end}
    Run Keyword If  ${on_sunday}==True  Variable Should Exist   ${COUNT}    2
    ...   ELSE   Variable Should Exist   ${COUNT}    2

