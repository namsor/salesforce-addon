# Namsor Salesforce Addon

[![Watching][watching-shield]][watching-url]
[![Stars][stars-shield]][stars-url]

## Table of Contents

- [Namsor Salesforce Addon](#namsor-salesforce-addon)
  * [About the project](#about-the-project)
  * [Getting Started](#getting-started)
    + [Installation](#installation)
    + [Setup Namsor API Key](#setup-namsor-api-key)
    + [Setup Scheduled Job](#setup-scheduled-job)
    + [First Run (all records)](#first-run--all-records-)
  * [How does this Addon work?](#how-does-this-addon-work-)

## About the project



## Getting Started

In this section, you will learn the steps to fully install and use this addon, as well as set it up in your Salesforce Organization to have your Contacts enriched with Namsor Gender information.

### Installation

To install this Salesforce Addon, please click in the following link, which will take you to the installation page.

[LINK HERE]

From there, all you need to do is to do is follow the instructions provided by Salesforce.

![Salesforce Installation Screen][img-installation]

### Setup Namsor API Key

In this step, you will configure your own Namsor API Key to perform the necessary API calls.

To achieve this, you can follow the steps bellow:

1) Search for `Named Credentials` on your Organization's Setup Quick Search and click the sub-menu:

![Named Credentials][img-setup-api-1]

2) Click on the Named Credential called `Namsor API` and click on `Edit`:

![Namsor API][img-setup-api-2]

3) Update the password field. **Do not change any other fields!**:

![Update Password][img-setup-api-3]

### Setup Scheduled Job

In this step, you will setup your Schedule Job tht will be responsible for executing the Script automatically every day!

To achieve this, you can follow the steps bellow:

1) Search for `Apex` on your Organization's Setup Quick Search and click the sub-menu called `Apex Classes`:

![Search Apex][img-setup-schedule-1]

2) Locate and click the button called `Schedule Apex`

![Schedule Apex][img-setup-schedule-2]

3) Click on the search button near the `Apex Class` field:

![Apex Class][img-setup-schedule-3]

4) Search for `NamSor_BatchExecution` and click on the Class name:

![Select Apex Class][img-setup-schedule-4]

5) Fill the rest of the fields, as shown in the picture bellow (this script will run on a daily basis):

![Other Fields][img-setup-schedule-5]

**Now just click on `Save` and you are done!**

You can also verify your new Scheduled Job by searching for `Scheduled Jobs` on the Quick Find:

![Verification][img-setup-schedule-6]

### First Run (all records)

When you first install this package, your records won't have the Namsor Gender info available just yet, you will need to run the script once for all your database before you start.

To do this, the are some simple steps:

1) Open the Developer Console:

2) Click on `Execute Anonymous`:

3) Run the following script:

```java
NamSor_BatchExecution batchExecution = new NamSor_BatchExecution(true);
Database.executeBatch(batchExecution, 100);
```

## How does this Addon work?

This Addon will run a Schedule Job (created on the installation step above) every day at the specified time.

Steps performed:
- Get all the Contacts created on the last 2 days;
- Verify which ones do not have Namsor's Likely Gender information yet;
- Separate the records in batches of 100 records each;
- Call the Namsor API for all the retrieved records;
- Update the Contacts with the retrieved Namsor gander information.

[⬆ Back to the top](#namsor-salesforce-addon)<br>

<!-- MARKDOWN LINKS & IMAGES -->
[watching-shield]: https://img.shields.io/github/watchers/namsor/salesforce-addon?label=Watching&style=for-the-badge&color=success
[watching-url]: https://github.com/namsor/salesforce-addon/stargazers
[stars-shield]: https://img.shields.io/github/stars/namsor/salesforce-addon?label=Stars&style=for-the-badge&color=success
[stars-url]: https://github.com/namsor/salesforce-addon/stargazers

[img-setup-api-1]: assets/setup/api-key/1-named-credentials.png
[img-setup-api-2]: assets/setup/api-key/2-namsor-api.png
[img-setup-api-3]: assets/setup/api-key/3-edit-password.png

[img-setup-schedule-1]: assets/setup/scheduled-job/1-search-apex.png
[img-setup-schedule-2]: assets/setup/scheduled-job/2-apex-classes.png
[img-setup-schedule-3]: assets/setup/scheduled-job/3-schedule-apex.png
[img-setup-schedule-4]: assets/setup/scheduled-job/4-select-apex-class.png
[img-setup-schedule-5]: assets/setup/scheduled-job/5-other-fields.png
[img-setup-schedule-6]: assets/setup/scheduled-job/6-verify-scheduled.png