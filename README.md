[![Watching][watching-shield]][watching-url]
[![Stars][stars-shield]][stars-url]

<br/>
<div align="center">
    <img src="assets/images/NamsorAddon.png" alt="Logo" width="300" height="80">
    <h2>Namsor Salesforce Addon</h2>
    <p>Enrich Contacts with Gender information purely based on their names!</p>
</div>
<br/>

## Table of Contents

- [Namsor Salesforce Addon](#namsor-salesforce-addon)
  * [About the project](#about-the-project)
  * [Getting Started](#getting-started)
    + [Installation](#installation)
    + [Setup Namsor API Key](#setup-namsor-api-key)
    + [Setup Scheduled Job](#setup-scheduled-job)
    + [First Run (all records)](#first-run--all-records-)
  * [How does this Addon work?](#how-does-this-addon-work-)
  * [Help](#help)
  * [Any other questions?](#any-other-questions-)

## About the project

This Salesforce Addon offers a quick and easy way to integrate your Salesforce Contact data with Namsor, enriching gender information with Namsor's Gender API just using your Contact names.

To learn more about Namsor's capabilities you can click the button below to go to our website, which offers documentation, as well as all the platform's features and capabilities.

[![Namsor Shield][namsor-shield]][namsor-url]

Basically, this Addon will run every day on your Salesforce Organization, get all the new Contact records, get Namsor's likely gender information and update your Salesforce Contacts with the retrieved information.

> :white_check_mark: **The Likely Gender information will be stored on a new Salesforce Picklist field called `Namsor_Likely_Gender__c`, created by the Package, in the Contact object**

## Getting Started

In this section, you will learn the steps to fully install and use this addon, as well as set it up in your Salesforce Organization to have your Contacts enriched with Namsor Gender information.

### Installation

To install this Salesforce Addon, please click in the following button, which will take you to the installation page.

[![Salesforce Package Installation][img-installation-button]][salesforce-package]

From there, all you need to do is login to your Salesforce Organization, choose `Install for All Users` and follow the instructions provided by Salesforce to fully install the package.

![Salesforce Installation Screen][img-installation]

### Setup Namsor API Key

In this step, you will configure your own Namsor API Key to perform the necessary API calls.

> :bangbang: **If you haven't done so yet, you can go ahead and create your Namsor account using the button below.**

[![Namsor Shield][namsor-shield]][namsor-url]

To achieve this, you can follow the steps below:

1) Search for `Named Credentials` on your Organization's Setup Quick Search and click the sub-menu:

![Named Credentials][img-setup-api-1]

2) Click on the Named Credential called `Namsor API` and click on `Edit`:

![Namsor API][img-setup-api-2]

3) Update the password field. **Do not change any other fields!**:

![Update Password][img-setup-api-3]

### Setup Scheduled Job

In this step, you will setup your Schedule Job tht will be responsible for executing the Script automatically every day!

To achieve this, you can follow the steps below:

1) Search for `Apex` on your Organization's Setup Quick Search and click the sub-menu called `Apex Classes`:

![Search Apex][img-setup-schedule-1]

2) Locate and click the button called `Schedule Apex`

![Schedule Apex][img-setup-schedule-2]

3) Click on the search button near the `Apex Class` field:

![Apex Class][img-setup-schedule-3]

4) Search for `NamSor_BatchExecution` and click on the Class name:

![Select Apex Class][img-setup-schedule-4]

5) Fill the rest of the fields, as shown in the picture below (this script will run on a daily basis):

![Other Fields][img-setup-schedule-5]

**Now just click on `Save` and you are done!**

You can also verify your new Scheduled Job by searching for `Scheduled Jobs` on the Quick Find:

![Verification][img-setup-schedule-6]

### First Run (all records)

When you first install this package, your records won't have the Namsor Gender info available just yet, you will need to run the script once for all your database before you start.

To do this, the are some simple steps:

1) Open the Developer Console:

![Developer Console][img-setup-first-run-1]

2) Click on `Open Execute Anonymous Window`:

![Execute Anonymous][img-setup-first-run-2]

3) Paste the following script and click `Execute`:

```java
NamSor_BatchExecution batchExecution = new NamSor_BatchExecution(true);
Database.executeBatch(batchExecution, 100);
```

![Run Script][img-setup-first-run-3]

## How does this Addon work?

This Addon will run a Schedule Job (created on the installation step above) every day at the specified time.

Steps performed:
- Get all the Contacts created on the last 2 days;
- Verify which ones do not have Namsor's Likely Gender information yet;
- Separate the records in batches of 100 records each;
- Call the Namsor API for all the retrieved records;
- Update the Contacts with the retrieved Namsor likely gender information.

## Help

**Question:** The Contacts are not being updated with the Likely Gender information! What should I do?

**Answer:** First of all, review the [Setup Instructions](#getting-started) to make sure you didn't miss anything (schedule Apex Job to run every day + setup Namsor API Key). If that still does not work, make sure the field created within this Package (`Contact.Namsor_Likely_Gender__c`) is visible and editable by the User that scheduled the Apex Job. If you don't know how to do it, you can refer to [this Salesforce Help page][salesforce-help-field-sec] which will guide you configuring Field-Level security.

##

**Question:** My Salesforce Org already has a Contact field used to store Gender information, is there a way to use it instead of the newly created one?

**Answer:** Yes, there is a way, but it must be edited in some Apex Classes. Ask your IT team to do so, they need to replace the field `Namsor_Likely_Gender__c` on the Apex Classes `Namsor_BatchExecution`, `Namsor_EnrichContact`, `Namsor_Test_BatchExecution` and `Namsor_Test_EnrichContact`.

##

**Question:** I already have some Contacts with the Namsor Likely Gender information, stored in another field. What should I do?

**Answer:** Here you have 2 options: you can update the existing Contact records, updating the field `Namsor_Likely_Gender__c` with the values from your other gender field (and start using only the new field) OR you can make the changes described on the question above.

## Any other questions?

Feel free to contact the developer of this project using any of these links below:

[![Linkedin Shield][linkedin-shield]][linkedin-url]


[![Fiverr Shield][fiverr-shield]][fiverr-url]


[⬆ Back to the top](#namsor-salesforce-addon)<br>

<!-- SHIELDS -->
[watching-shield]: https://img.shields.io/github/watchers/namsor/salesforce-addon?label=Watching&style=for-the-badge&color=success
[watching-url]: https://github.com/namsor/salesforce-addon/watchers
[stars-shield]: https://img.shields.io/github/stars/namsor/salesforce-addon?label=Stars&style=for-the-badge&color=success
[stars-url]: https://github.com/namsor/salesforce-addon/stargazers
[namsor-shield]: https://img.shields.io/badge/Namsor-Explore%20Namsor%20API-blue.svg?logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyBpZD0iQ2FscXVlXzEiIGRhdGEtbmFtZT0iQ2FscXVlIDEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDM0Ljc4IDU4LjIxIj48ZGVmcz48Y2xpcFBhdGggaWQ9ImNsaXAtcGF0aCIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLS43OSAtLjU0KSI%2BPHBhdGggY2xhc3M9ImNscy0xIiBkPSJNLjc5LjU0aDM0Ljc4djU2LjczSC43OXoiLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iY2xpcC1wYXRoLTIiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTQuODYuNTRoMzAuNzF2NTYuNzNINC44NnoiLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iY2xpcC1wYXRoLTMiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTYuODMuNTRoMjguNzN2NTYuNzNINi44M3oiLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iY2xpcC1wYXRoLTQiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTYuODMuNjZoMjguNzN2NTguMDhINi44M3oiLz48L2NsaXBQYXRoPjxzdHlsZT4uY2xzLTF7ZmlsbDpub25lfTwvc3R5bGU%2BPC9kZWZzPjxnIHN0eWxlPSJjbGlwLXBhdGg6dXJsKCNjbGlwLXBhdGgpIj48cGF0aCBkPSJtLjc5IDUyLjg5IDYuNS0zOS41M0wxOS44NCAyNy43bDMuMzMtMjMuMzkgOC4xNi0yLjg2IDQuMjMtLjkxcy0zLjQ0IDEuMi00LjM4IDkuMjdTMjAuMjIgMzMgMjAuMjIgMzNsLTUuMTEtMy40TDggNDYuNjdsLTMuMTMgMTAuNloiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiIHN0eWxlPSJmaWxsOiNmYWJiMjAiLz48L2c%2BPHBhdGggY2xhc3M9ImNscy0xIiBkPSJNNC44Ni41NGgzMC43MXY1Ni43M0g0Ljg2WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLS43OSAtLjU0KSIvPjxnIHN0eWxlPSJjbGlwLXBhdGg6dXJsKCNjbGlwLXBhdGgtMikiPjxwYXRoIGQ9Im00Ljg2IDU3LjI3IDMuMzEtMzguMzYgMTEuNjYgOC43OUwyOCAyLjZsMy4zLTEuMTYgNC4yNC0uOUwzMCA2LjQ0bC04Ljg2IDI1LjMyLTYtMi4xOC04LjMyIDI3LjY5WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLS43OSAtLjU0KSIgc3R5bGU9ImZpbGw6I2VmODMxOCIvPjwvZz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik02LjgzLjU0aDI4LjczdjU2LjczSDYuODNaIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtLjc5IC0uNTQpIi8%2BPGcgc3R5bGU9ImNsaXAtcGF0aDp1cmwoI2NsaXAtcGF0aC0zKSI%2BPHBhdGggZD0ibTYuODMgNTcuMjcgMy42My0zMy41IDkuNzYgNi43OSA4LjY5LTI0Ljc0TDM1LjU2LjU0bC04LjgxIDUwLjY4TDE1IDMzIDkuMjUgNTRaIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtLjc5IC0uNTQpIiBzdHlsZT0iZmlsbDojYTc0NDlmIi8%2BPC9nPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTYuODMuNjZoMjguNzN2NTguMDlINi44M1oiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiLz48ZyBzdHlsZT0iY2xpcC1wYXRoOnVybCgjY2xpcC1wYXRoLTQpIj48cGF0aCBkPSJtNi44MyA1Ny4zOSA3LTI5LjEyTDIyIDM3LjEzbDYtMTEuODhMMzUuNTYuNjZsLTggNTguMDlMMTUuMyAzNS4yMWwtNi4wNSAyMloiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0uNzkgLS41NCkiIHN0eWxlPSJmaWxsOiM1MzI1ODIiLz48L2c%2BPC9zdmc%2B&style=for-the-badge
[linkedin-shield]: https://img.shields.io/badge/Linkedin-Luis%20Kumruyan-blue.svg?logo=linkedin&style=for-the-badge
[fiverr-shield]: https://img.shields.io/badge/Fiverr-Luis%20Kumruyan-success.svg?logo=fiverr&style=for-the-badge


<!-- IMAGES -->
[img-installation]: assets/images/installation/installation-screen.png
[img-installation-button]: assets/images/installation/install-package-button.png

[img-setup-api-1]: assets/images/setup/api-key/1-named-credentials.png
[img-setup-api-2]: assets/images/setup/api-key/2-namsor-api.png
[img-setup-api-3]: assets/images/setup/api-key/3-edit-password.png

[img-setup-schedule-1]: assets/images/setup/scheduled-job/1-search-apex.png
[img-setup-schedule-2]: assets/images/setup/scheduled-job/2-apex-classes.png
[img-setup-schedule-3]: assets/images/setup/scheduled-job/3-schedule-apex.png
[img-setup-schedule-4]: assets/images/setup/scheduled-job/4-select-apex-class.png
[img-setup-schedule-5]: assets/images/setup/scheduled-job/5-other-fields.png
[img-setup-schedule-6]: assets/images/setup/scheduled-job/6-verify-scheduled.png

[img-setup-first-run-1]: assets/images/setup/first-run/1-developer-console.png
[img-setup-first-run-2]: assets/images/setup/first-run/2-execute-anonymous.png
[img-setup-first-run-3]: assets/images/setup/first-run/3-run-script.png

<!-- LINKS -->
[salesforce-package]: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5w000005xvS9AAI
[namsor-url]: https://namsor.app/?via=luis-fernando
[salesforce-help-field-sec]: https://help.salesforce.com/s/articleView?id=sf.admin_fls.htm&type=5
[linkedin-url]: https://www.linkedin.com/in/luiskumruyan/
[fiverr-url]: https://www.fiverr.com/luiskumruyan