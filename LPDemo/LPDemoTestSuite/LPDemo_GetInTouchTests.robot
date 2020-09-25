*** Settings ***
Library    SeleniumLibrary  
Library    String  
Resource   ../LPDemoResource.robot

#Suite Setup    Open Browser To Home Page
#Suite Teardown    Close Browser

Test Setup    Open Browser To Home Page
Test Teardown    Close All Browsers

*** Variables ***
${EMAIL_DOMAIN}        @mycompany.com
${COMPANY}             testCompany
${JOB_TITLE}           Automation Engineer
${YOUR_MESSAGE}        Hope your enjoying this demo!
${INVALID_EMAIL}       seamusbreslin2@gmail.com



*** Test Cases ***
Get In Touch E2E    
    ${FIRST_NAME}          Generate Random String    6    [LETTERS]
    ${LAST_NAME}           Generate Random String    8    [LETTERS]
    ${EMAIL}               Catenate    SEPARATOR=    ${FIRST_NAME}    ${EMAIL_DOMAIN}
    ${PHONE_NUMBER}        Generate Random String    11    [NUMBERS]
    
    Navigate to Get in touch
    Book a call back
    Verify Form Header    ${FORM_HEADER_LOCATOR}    ${FORM_HEADER}
    Close Request a Demo 
    Input First Name      ${FIRST_NAME}
    Input Last Name       ${LAST_NAME}
    Input Email           ${EMAIL}
    Input Phone Number    ${PHONE_NUMBER}
    Input Job title       ${JOB_TITLE}
    Input Company         ${COMPANY}
    Input Your Message    ${YOUR_MESSAGE}
    Sleep    5    
  
#Test with steps grouped for navigation into a keyword
Get In Touch Blank Form Submission
    Navigate to Get a free demo
    Click Submit
    Assert Complete All Fields    ${ERROR_COMPLETE_ALL_FIELDS_LOCATOR}    ${ERROR_COMPLETE_ALL_REQUIRED_FIELDS}
    
# Test with input fields grouped to a keyword
Get In Touch Invalid Email Data
    ${FIRST_NAME}          Generate Random String    6    [LETTERS]
    ${LAST_NAME}           Generate Random String    8    [LETTERS]
    ${PHONE_NUMBER}        Generate Random String    11    [NUMBERS]
    
    Navigate to Get a free demo
    Input Form Data    ${FIRST_NAME}    ${LAST_NAME}    ${INVALID_EMAIL}   ${PHONE_NUMBER}    ${JOB_TITLE}    ${COMPANY}    ${YOUR_MESSAGE}
    Implicit Wait
    Assert Invalid Email 
    