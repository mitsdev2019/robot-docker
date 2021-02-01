*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${WEBSITE URL}      https://theprogrammerslab.com/
${BROWSER}          Chrome

*** Test Cases ***
Open Test Website And Close Browser
    Open Test Website In Chrome
    [Teardown]    Close Browser

*** Keywords ***
Open Test Website In Chrome
    Open Browser      ${WEBSITE URL}    ${BROWSER}
    Sleep             2
    Title Should Be   { The Programmers Lab } – Best Computer training institute in Pune | C Courses | Cpp Coureses | Python Courses in Pune Sangvi
