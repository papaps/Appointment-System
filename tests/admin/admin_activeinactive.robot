#*** Settings ***
#Documentation    Suite description
#Suite Setup       Open Browser To Login Page
#Suite Teardown    Close Browser
#Resource    ${CURDIR}${/}..\\login_resource.robot
#
#*** Test Cases ***
#Inactive Dentist
#    Input Username    ${VALID ADMIN}
#    Input Password    ${VALID PASSWORD}
#    Submit Credentials
#    Set Dentist Inactive
#    Logout
#
#Inactive Dentist Should Not Be Accessed
#    Dentist Should Not Be Able To Login
#    Dentist Should Be Unavailable in Creating Appointments
#
#Active Dentist
#    Input Username    ${VALID ADMIN}
#    Input Password    ${VALID PASSWORD}
#    Submit Credentials
#    Set Dentist Active
#    Logout
#    Dentist Should Be Able to Login
#
#
#*** Keywords ***
#Add Appointment Selection
##Day Speed
##   Set Selenium Speed  0.01
#    Set Selenium Speed  0.5
#    Sleep   1
#    Click Element    add
#
#Set Dentist Active
#    Click Element       Daisy-Buchanan-active
#    Element Text Should Be      Daisy-Buchanan-active   Active
#
#Set Dentist Inactive
#    Click Element       Daisy-Buchanan-active
#    Element Text Should Be      Daisy-Buchanan-active   Inactive
#
#Dentist Should Be Able to Login
#    Input Username    ${VALID DENTIST}
#    Input Password    ${VALID PASSWORD}
#    Submit Credentials
#    Logout
#
#Dentist Should Not Be Able To Login
#    Input Username    ${VALID DENTIST}
#    Input Password    ${VALID PASSWORD}
#    Submit Credentials
#    Page Should Contain   Invalid username
#
#Dentist Should Be Available in Creating Appointments
#    Input Username  ${VALID SECRETARY}
#    Input Password  ${VALID PASSWORD}
#    Submit Credentials
#    Click Element   add-button
#    Click Element   date-done
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Page Should Contain    Dr. Daisy Buchanan
#
#Dentist Should Be Unavailable in Creating Appointments
#    Input Username  ${VALID SECRETARY}
#    Input Password  ${VALID PASSWORD}
#    Submit Credentials
#    Click Element   add-button
#    Click Element   date-done
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Press Keys    None    TAB
#    Page Should Not Contain    Dr. Daisy Buchanan