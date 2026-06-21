*** Variables ***
${OPEN_ACCOUNT_NAVIGATION_BUTTON}=  xpath=//a[@href="openaccount.htm"]
${OPEN_ACCOUNT_ACCOUNT_TYPE_DROPDOWN}=  xpath=//select[@id="type"]
${OPEN_ACCOUNT_FROM_ACCOUNT_DROPDOWN}=  xpath=//select[@id="fromAccountId"]
${OPEN_NEW_ACCOUNT_BUTTON}=  xpath=//input[@value="Open New Account"]
${OPEN_ACCOUNT_SUCCESS_MESSAGE}=  xpath=//p[contains(text(),"Congratulations, your account is now open.")]
${OPEN_ACCOUNT_ACCOUNT_ID}=  xpath=//a[@id="newAccountId"]