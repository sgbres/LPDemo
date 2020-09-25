*** Settings ***
Library    SeleniumLibrary    
Library    BuiltIn

*** Variables ***
${LP_URL}                                     https://learningpool.com/
${BROWSER}                                    Firefox
${TITLE_CONTACT_US}                           Contact Us - Learning Pool
${WAIT}                                       10
${FORM_HEADER_LOCATOR}                        css:.col1 > h4:nth-child(1)
${FORM_HEADER}                                Start your learning journey
${ERROR_COMPLETE_ALL_FIELDS_LOCATOR}          //label[contains (text(), 'Please complete all required fields.')]
${ERROR_COMPLETE_ALL_REQUIRED_FIELDS}         Please complete all required fields.
${ERROR_EMAIL_FORMAT_LOCATOR}                 //*[contains (text(), 'Email must be formatted correctly.')]
${ERROR_INVALID_FORMAT}                       Email must be formatted correctly.
${ERROR_VALID_WORK_EMAIL_LOCATOR}             //*[contains (text(), 'Please enter your business email address. This form does not accept addresses from gmail.com.')]
${ERROR_VALID_WORK_EMAIL}                     Please enter your business email address. This form does not accept addresses from gmail.com.


*** Keywords ***
Open Browser To Home Page
    Open Browser    ${LP_URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be   elearning at Learning Pool - Innovation. Passion. Learning.
    
Navigate to Get in touch
    Click Element    xpath://*[@id="menu-first-menu"]/div/button
    Title Should Be   ${TITLE_CONTACT_US}
    Click Accept Cookies  
    
Click Accept Cookies
    ${present}=  Run Keyword And Return Status    Element Should Be Visible   xpath://*[contains (text(), 'Accept')]  
    Run Keyword If    ${present}    Click Element    id:hs-eu-confirmation-button  
    
Close Request a Demo
    ${present}=  Run Keyword And Return Status    Element Should Be Visible   class:leadinModal-close 
    Run Keyword If    ${present}    Click Element    class:leadinModal-close  
    
Book a call back 
    Click Accept Cookies        
    Scroll Element Into View    xpath://a[contains (text(), 'Book a call back')]
    Wait Until Element Is Visible    xpath://a[contains (text(), 'Book a call back')]    10
    Click Element    xpath://a[contains (text(), 'Book a call back')]

Implicit Wait
    Set Selenium Implicit Wait    ${WAIT}
    
Verify Form Header
    [Arguments]      ${FORM_HEADER_LOCATOR}    ${FORM_HEADER}
    ${VALIDATE_HEADER}=    Get Text     ${FORM_HEADER_LOCATOR}
    Should Be Equal       ${VALIDATE_HEADER}      ${FORM_HEADER}
  
Input First Name
    [Arguments]    ${first_name}
    Close Request a Demo   
    Select Frame    id:hs-form-iframe-0
    Input Text    name:firstname    ${first_name}
      
Input Last Name
    [Arguments]    ${last_name}
    Input Text    name:lastname    ${last_name}
    
Input Email
    [Arguments]    ${email}
    Input Text    name:email    ${email}
    
Input Phone Number
    [Arguments]    ${phone_number}
    Input Text    name:phone    ${phone_number}
    
Input Job title
    [Arguments]    ${job_title}
    Input Text    name:jobtitle    ${job_title}
    
Input Your Message
    [Arguments]    ${your_message}
    Input Text    name:write_your_message_here_    ${your_message}    
    
Input Company
    [Arguments]    ${company}
    Input Text    name:company    ${company}    
    
Click Submit
    Select Frame    id:hs-form-iframe-0
    Click Element    xpath://input[@value="Submit"] 
    
Assert Complete All Fields   
    [Arguments]      ${ERROR_COMPLETE_ALL_FIELDS_LOCATOR}    ${ERROR_COMPLETE_ALL_REQUIRED_FIELDS}
    ${VALIDATE_HEADER}=    Get Text     ${ERROR_COMPLETE_ALL_FIELDS_LOCATOR}
    Should Be Equal       ${VALIDATE_HEADER}      ${ERROR_COMPLETE_ALL_REQUIRED_FIELDS}
    
Navigate to Get a free demo
    Navigate to Get in touch
    Book a call back
    Verify Form Header    ${FORM_HEADER_LOCATOR}    ${FORM_HEADER}
    Close Request a Demo
    
Assert Invalid Email
    ${VALIDATE_EMAIL_ERROR1}=    Get Text     ${ERROR_VALID_WORK_EMAIL_LOCATOR}
    Should Contain       ${VALIDATE_EMAIL_ERROR1}      ${ERROR_VALID_WORK_EMAIL}
    #${EMAIL_ERROR1}=  Run Keyword And Return Status     Page Should Contain Element    //*[contains (text(), 'Email must be formatted correctly.')]
    #${EMAIL_ERROR2}=  Run Keyword And Return Status     Page Should Contain Element    //*[contains (text(), 'Please enter your business email address. This form does not accept addresses from gmail.com.')]
    #Run Keyword If  not ${EMAIL_ERROR1} or not ${EMAIL_ERROR2}    Fail  None of the elements is present on the page
       
Activate Form
        Select Frame    id:hs-form-iframe-0
        
Input Form Data
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}    ${EMAIL}    ${PHONE_NUMBER}    ${JOB_TITLE}    ${COMPANY}    ${YOUR_MESSAGE}
    Input First Name      ${FIRST_NAME}
    Input Last Name       ${LAST_NAME}
    Input Email           ${EMAIL}
    Input Phone Number    ${PHONE_NUMBER}
    Input Job title       ${JOB_TITLE}
    Input Company         ${COMPANY}
    Input Your Message    ${YOUR_MESSAGE}
       