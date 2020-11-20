*** Settings ***
Library    SeleniumLibrary     

*** Variables ***
${URL}                http://automationpractice.com/index.php
${browser}            chrome
${Item1ToSelect}      Printed Summer Dress
${Item2ToSelect}      Printed Dress
${email}              hemantsbhavsar0908@gmail.com
${password}           test123$

*** Keywords ***
MoveToElement
    [Arguments]     ${locator}    ${text}
    Scroll element into view    ${locator}=${text}

SelectItem
     [Arguments]     ${ItemToSelect}
      MoveToElement    link    ${ItemToSelect}
      Click Link    link=${ItemToSelect}    
      Click Button    name=Submit   
    
ProceedToCheckOut
    [Arguments]     ${locator}    ${text}
    Scroll element into view    ${locator}=${text}
    Click Link    ${locator}=${text}
    

EnterSignInDetails
    Input Text    id=email    ${email}  
    Input Password    id=passwd    ${password} 
    Click Button    id=SubmitLogin

*** Test Cases ***

LauchBrowser
    [Documentation]    Launch the Browser
    Open Browser    ${URL}    ${browser} 
    Maximize Browser Window
    Set Selenium Implicit Wait    10
    
    # Check whether application is launched successfully 
    ${pageTitle}    Get Title
    log    page title is ${pageTitle}
    
    Page Should Contain    My Store     
ItemSelection
    
    Page Should Contain Link    ${Item1ToSelect}    
    
    # Get current URL
    
    ${currentURL}=    Get Location
    
    SelectItem    ${Item1ToSelect}
      
   # Continue with Shopping
    
    Go To     ${currentURL}
    
    Page Should Contain Link    ${Item2ToSelect}
    
    SelectItem    ${Item2ToSelect}
    
      #### After Selection of items - click on Proceed to checkout
    
    Click Link    link=Proceed to checkout
    
    ProceedToCheckOut    link        Proceed to checkout
    
    ### Check next page - Sign In details is displayed
    Page Should Contain Element    id=email    
  
SignInDetails
   ### Enter Signin Details
   EnterSignInDetails
 
    
    #ProceedToCheckOut    name        processAddress
    Scroll element into view    name=processAddress
    Click Button    name=processAddress
    ### Verify next page - shipping details id displayed
     Page Should Contain Element    name=cgv
CheckShippingDetails
    # On shipping page
    # Select Term Of Service
    Scroll element into view    name=cgv
    Select Checkbox    name=cgv
    Click Button    name=processCarrier
   
   ### Verify Payment page is displayed 
    Page Should Contain Element    css=a[title='Pay by bank wire']    
    Scroll element into view    css=a[title='Pay by bank wire']  

    
    
     	
     