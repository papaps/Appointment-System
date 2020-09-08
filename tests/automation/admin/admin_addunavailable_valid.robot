*** Settings ***
Documentation    Suite description
Library     BuiltIn
Library     String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Variables ***
${START DATE}
${END DATE}
${COUNT}    0

*** Test Cases ***
Valid Dentist Unavailable Date
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    View Dentist's Schedule
    Set Unavailable Date

Dentist Should Be Unavailable
    Dentist Should Be Listed Unavailable in Admin Page
    Logout Page
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Dentist Should Be Unavailable in Secretary Page

*** Keywords ***
View Dentist's Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view

Set Unavailable Date
    Click Element   unavailable
    Click Element   add-schedule
    Sleep   1
    Press Keys    None    ENTER
    Sleep   1
    Press Keys    None    TAB
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    ${start}=  Get Value    start-date-input
    ${end}=    Get Value    end-date-input
    Set Suite Variable  ${START DATE}   ${start}
    Set Suite Variable  ${END DATE}   ${end}
    Click Element   add-unavailable-button

Dentist Should Be Listed Unavailable in Admin Page
    Element Text Should Be     class:success   Dentist unavailable date successfully added
    Table Should Contain    schedule-table      ${START DATE} - ${END DATE}
    Click Element   close-schedule-modal

Dentist Should Be Unavailable in Secretary Page
    Unavailable For Start Date
    Unavailable For Dates Between and End
    Unavailable in Availability Table

Unavailable in Creating Appointments
    Sleep   1
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   add-back-button

Unavailable For Start Date
    Sleep   1
    Click Element   add-button
    ${TODAY}=   Get Value   add-dateInput
    FOR     ${i}    IN RANGE    5
        Exit For Loop If    "${TODAY}" == "${START DATE}"
        Sleep   0.5
        Press Keys    None    ARROW_RIGHT
    END
    Unavailable in Creating Appointments

Unavailable For Dates Between and End
    FOR     ${i}     IN RANGE   5
        ${TODAY}=   Get Value   add-dateInput
        Exit For Loop If   "${TODAY}" == "${END DATE}"
        Press Keys    None    ARROW_RIGHT
        Press Keys    None    ENTER
        Unavailable in Creating Appointments
    END
    Click Element   date-cancel
    Click Element   discard

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
