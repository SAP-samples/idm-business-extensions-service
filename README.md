# SAP Identity Management - Business Extensions Service

## Description

This repository contains the content of the [SAP Identity Management](https://www.sap.com/products/identity-management.html) Business Extensions Service from [SAP Services](https://www.sap.com/services.html) (formerly released as Rapid-Deployment Solution for SAP Identity Management or IDM RDS). The aim is to make its content available for customers and partners, after the retirement of the RDS program ([Note 2624206](https://launchpad.support.sap.com/#/notes/2624206)).  

Considerations:
* The content can be downloaded and used without any license charges.
* If you require support during installation, configuration or when using, modifying or extending the content, please send an email to <securityconsulting@global.corp.sap>.
* If you did not purchase the service from [SAP Services](https://www.sap.com/services.html), you will get charged for the support activities.
* If you are not on SP04 yet, consider the SP04 Patch Hot To before patching to SP05

## Requirements

[SAP Identity Management](https://www.sap.com/products/identity-management.html) 8.0 SP08 (Schema Version 1814)

## Download and Installation
Please refer to the [Wiki Page](https://github.com/SAP-samples/idm-business-extensions-service/wiki)

## Known Issues

* sapc_core_catchProvisioningError contains undefined attributes
* HANA DB: Cannot lock/unlock with system specific attribute (triggering modify -> enable/disable not part of modify in HANA)
* ABAP & ABAP BS - Job Read Last Logon & Lock State not supporting SU10 chagens
* Mass Jobs for Download like Config Item Download are not working with SP05. This will be fixed ASAP

## How to obtain support

[Create an issue](https://github.com/SAP-samples/idm-business-extensions-service/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

If you require support from [SAP Services](https://www.sap.com/services.html) please send an email to <security@global.corp.sap>.  
Please do not open an incident to support component BC-IAM-IDM for issues encountered within the content of this repository.

## Contributing

[Create an issue](https://github.com/SAP-samples/idm-business-extensions-service/issues) in this repository or send an email to <securityconsulting@global.corp.sap> if you want to contribute content.

## License

Copyright (c) 2021 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.

[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/idm-business-extensions-service)](https://api.reuse.software/info/github.com/SAP-samples/idm-business-extensions-service)

# Further SAP Identity Management Content on GitHub

You can find more content for SAP Identity Management from customers and partners in the [GitHub Repository of DSAG](https://github.com/1DSAG/IDM8.x)
