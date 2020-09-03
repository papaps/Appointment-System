*** Settings ***
Documentation    Suite description
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Resource    ${CURDIR}${/}..\\login_resource.robot

*** Test Cases ***
Login
    Input Username  ${VALID ADMIN}
    Input Password  ${VALID PASSWORD}
    Submit Credentials

Add 30 Dentists
    [Template]  Create New Dentist
    [Tags]          LASTNAME      USERNAME
    Doctor 1        AA             doctor1
    Doctor 2        BB             doctor2
    Doctor 3        CC             doctor3
    Doctor 4        DD             doctor4
    Doctor 5        EE             doctor5
    Doctor 6        FF             doctor6
    Doctor 7        GG             doctor7
    Doctor 8        HH             doctor8
    Doctor 9        II             doctor9
    Doctor 10       JJ             doctor10
    Doctor 11       KK             doctor11
    Doctor 12       LL             doctor12
    Doctor 13       MM             doctor13
    Doctor 14       NN             doctor14
    Doctor 15       OO             doctor15
    Doctor 16       PP             doctor16
    Doctor 17       QQ             doctor17
    Doctor 18       RR             doctor18
    Doctor 19       SS             doctor19
    Doctor 20       TT             doctor20
    Doctor 21       UU             doctor21
    Doctor 22       VV             doctor22
    Doctor 23       WW             doctor23
    Doctor 24       XX             doctor24
    Doctor 25       YY             doctor25
    Doctor 26       ZZ             doctor26
    Doctor 27       AAA            doctor27
    Doctor 28       BBB            doctor28
    Doctor 29       CCC            doctor29
    Doctor 30       DDD            doctor30

Add 30 Procedures
    [Template]  Create New Procedure
    [Tags]         PROCEDURE
    Procedure 1    A
    Procedure 2    B
    Procedure 3    C
    Procedure 4    D
    Procedure 5    E
    Procedure 6    F
    Procedure 7    G
    Procedure 8    H
    Procedure 9    I
    Procedure 10   J
    Procedure 11   K
    Procedure 12   L
    Procedure 13   M
    Procedure 14   N
    Procedure 15   O
    Procedure 16   P
    Procedure 17   Q
    Procedure 18   R
    Procedure 19   S
    Procedure 20   T
    Procedure 21   U
    Procedure 22   V
    Procedure 23   W
    Procedure 24   X
    Procedure 25   Y
    Procedure 26   Z
    Procedure 27   AA
    Procedure 28   BB
    Procedure 29   CC
    Procedure 30   DD

*** Keywords ***
Add Appointment Selection
    Set Selenium Speed  0.5
    Sleep   1
    Click Element    add

Add New Dentist
    Click Element    add-dentist-button

Add New Procedure
    Click Element    add-procedure-button

Create New Dentist
    Add Appointment Selection
    Add New Dentist
    Set Selenium Speed  0.1
    [Arguments]  ${tag}    ${lastname}      ${username}
    Input Text  add-firstname-dentist   Doctor
    Input Text  add-lastname-dentist    ${lastname}
    Input Text  add-username-dentist    ${username}
    Input Text  add-password-dentist    ${VALID PASSWORD}
    Input Text  confirm-password-dentist    ${VALID PASSWORD}
    Sleep   1
    Click Element    create-dentist-button
    Sleep   1
    Click Element   add-schedule-button
    Sleep   1
    Click Element   close-schedule-modal

Create New Procedure
    Add Appointment Selection
    Add New Procedure
    Set Selenium Speed  0.3
    [Arguments]  ${tag}    ${procedure}
    Input Text  procedure-name  ${procedure}
    Click Element   create-procedure-button