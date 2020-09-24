*** Settings ***
Documentation    Suite description
Library     DateTime
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ../login_resource.robot

*** Test Cases ***
Reset Schedule Daily
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Reset Daily Schedule
    Input New Schedule

Reset Schedule Should Be Set
    Reset Schedule Should Be in Admin View
    Logout Page
    Set Selenium Speed  0.5
    Input Username  ${VALID SECRETARY}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    Reset Schedule Should Be in Secretary View

*** Keywords ***
Get Date
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}     result_format=%a
    [Return]        ${date}

Reset Daily Schedule
    Set Selenium Speed  0.5
    Sleep   1
    Click Element   Daisy-Buchanan-view
    ${date}=    Get Date
    Click Element   add-schedule
    Wait Until Page Contains Element    adding-schedule-modal
    Click Element   daily-field
    Click Element   custom-field

Input New Schedule
    Input Text  start  11:00
    Input Text  end    12:00
    Input Text  start-add  13:30
    Input Text  end-add    17:30
    Click Element   add-header
    Click Element   add-schedule-button

Reset Schedule Should Be in Admin View
    Element Text Should Be  class:success   Dentist schedule successfully added
    Set Selenium Speed  0.1
    Table Row Should Contain    schedule-table  1  11:00 - 12:00
    Table Row Should Contain    schedule-table  1  13:30 - 17:30
    Table Row Should Contain    schedule-table  2  11:00 - 12:00
    Table Row Should Contain    schedule-table  2  13:30 - 17:30
    Table Row Should Contain    schedule-table  3  11:00 - 12:00
    Table Row Should Contain    schedule-table  3  13:30 - 17:30
    Table Row Should Contain    schedule-table  4  11:00 - 12:00
    Table Row Should Contain    schedule-table  4  13:30 - 17:30
    Table Row Should Contain    schedule-table  5  11:00 - 12:00
    Table Row Should Contain    schedule-table  5  13:30 - 17:30
    Table Row Should Contain    schedule-table  6  11:00 - 12:00
    Table Row Should Contain    schedule-table  6  13:30 - 17:30
    Set Selenium Speed  0.5
    Click Element   close-schedule-modal

Reset Schedule Should Be in Secretary View
    Reset Schedule Should Reflect In Adding Appointment
    Reset Schedule Should Reflect in Availablity

Reset Schedule Should Reflect In Adding Appointment
    Click Element   add-button
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Sun'  Action For Add Appointment Sun
    ...     ELSE IF     '${date}'=='Mon'    Action For Add Appointment Mon
    ...     ELSE IF     '${date}'=='Tue'    Action For Add Appointment Tue
    ...     ELSE IF     '${date}'=='Wed'    Action For Add Appointment Wed
    ...     ELSE IF     '${date}'=='Thu'    Action For Add Appointment Thu
    ...     ELSE IF     '${date}'=='Fri'    Action For Add Appointment Fri
    ...     ELSE IF     '${date}'=='Sat'    Action For Add Appointment Sat

Action For Add Appointment Sun
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Mon
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Tue
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Wed
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Thu
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Fri
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Action For Add Appointment Sat
    Sleep   1
    Press Keys    None    ENTER
    Set Add Appointment Time
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Sleep   1
    Press Keys    None    ARROW_RIGHT
    Press Keys    None    ENTER
    Dentist Unavailable in Adding Appointment
    Discard Appointment

Dentist Unavailable in Adding Appointment
    Click Element   date-done
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Press Keys    None    TAB
    Page Should Not Contain    Dr. Daisy Buchanan
    Click Element   add-back-button

Set Add Appointment Time
    Press Keys    None    TAB
    Press Keys  None    DELETE
    Input Text    add-timeInput  12:30 PM

Discard Appointment
    Click Element   date-cancel
    Click Element   discard

Reset Schedule Should Reflect in Availablity
    Click Element   filter-dropdown
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER
    ${date}=    Get Date
    Run Keyword If  '${date}'=='Tue'    Action For Availability Tue
    ...     ELSE IF     '${date}'=='Wed'    Action For Availability Wed
    ...     ELSE IF     '${date}'=='Thu'    Action For Availability Thu
    ...     ELSE IF     '${date}'=='Fri'    Action For Availability Fri
    ...     ELSE IF     '${date}'=='Sat'    Action For Availability Sat
    ...     ELSE    Action For Availability Mon

Action For Availability Mon
    Sleep   1
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Action For Availability Tue
    Sleep   1
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element   next-button
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Action For Availability Wed
    Sleep   1
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element   next-button
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Action For Availability Thu
    Sleep   1
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element   next-button
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Action For Availability Fri
    Sleep   1
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element   next-button
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Action For Availability Sat
    Sleep   1
    Click Element  0-6
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element   next-button
    Click Element  0-1
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-2
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-3
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-4
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC
    Click Element  0-5
    Check Unavailable Per Date in Availability
    Press Keys  None    ESC

Check Unavailable Per Date in Availability
    Set Selenium Speed  0.05
    Table Cell Should Contain   availability-modal-table  2  2  Unavailable
    Table Cell Should Contain   availability-modal-table  3  2  Unavailable
    Table Cell Should Contain   availability-modal-table  4  2  Unavailable
    Table Cell Should Contain   availability-modal-table  5  2  Unavailable
    Table Cell Should Contain   availability-modal-table  6  2  Unavailable
    Table Cell Should Contain   availability-modal-table  7  2  Unavailable
    Table Cell Should Contain   availability-modal-table  10  2  Unavailable
    Table Cell Should Contain   availability-modal-table  11  2  Unavailable
    Table Cell Should Contain   availability-modal-table  12  2  Unavailable
    Table Cell Should Contain   availability-modal-table  11  4  Unavailable
    Set Selenium Speed    0.5