*** Variables ***
${TRANSFER_FUNDS_NAVIGATION_BUTTON}=  xpath=//a[@href="transfer.htm"]
${TRANSFER_FUNDS_FROM_ACCOUNT_DROPDOWN}=  xpath=//select[@id="fromAccountId"]
${TRANSFER_FUNDS_TO_ACCOUNT_DROPDOWN}=  xpath=//select[@id="toAccountId"]
${TRANSFER_FUNDS_AMOUNT_INPUT}=  xpath=//input[@id="amount"]
${TRANSFER_FUNDS_BUTTON}=  xpath=//input[@value="Transfer"]
${TRANSFER_FUNDS_SUCCESS_MESSAGE}=  xpath=//h1[contains(text(),"Transfer Complete!")]
${TRANSFER_FUNDS_SUCCESS_AMOUNT}=  xpath=//span[@id="amountResult"]
${TRANSFER_FUNDS_SUCCESS_FROM_ACCOUNT}=  xpath=//span[@id="fromAccountIdResult"]
${TRANSFER_FUNDS_SUCCESS_TO_ACCOUNT}=  xpath=//span[@id="toAccountIdResult"]
${ERROR_MESSAGE}=  xpath=//div[@id="showError"]/p
