*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${WEBSITE URL}      https://www.google.com/
${BROWSER}          Chrome

*** Test Cases ***
Open Test Website And Close Browser
    Open Test Website In Chrome
    [Teardown]    Close Browser

*** Keywords ***
Open Test Website In Chrome
    ${options} =  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    
    Open Browser      ${WEBSITE URL}    ${BROWSER}
    Sleep             2
    Title Should Be   Google
