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

## About the project

This Salesforce Addon offers a quick and easy way to integrate your Salesforce Contact data with Namsor, enriching gender information with Namsor's Gender API just using your Contact names.

To learn more about Namsor's capabilities you can [visit the website](https://namsor.app/?via=luis-fernando) which offers documentation, as well as all their features and capabilities.

Basically, this Addon will run every day on your Salesforce Organization, get all the new Contact records, get Namsor's likely gender information and update your Salesforce Contacts with the retrieved information.

## Getting Started

In this section, you will learn the steps to fully install and use this addon, as well as set it up in your Salesforce Organization to have your Contacts enriched with Namsor Gender information.

### Installation

To install this Salesforce Addon, please click in the following button, which will take you to the installation page.

[![Salesforce Package Installation][img-installation-button]][salesforce-package]

From there, all you need to do is login to your Salesforce Organization, choose `Install for All Users` and follow the instructions provided by Salesforce to fully install the package.

![Salesforce Installation Screen][img-installation]

### Setup Namsor API Key

In this step, you will configure your own Namsor API Key to perform the necessary API calls.

If you haven't done so yet, you can go ahead and create your Namsor account using [this link](https://namsor.app/?via=luis-fernando).

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

[⬆ Back to the top](#namsor-salesforce-addon)<br>

<!-- SHIELDS -->
[watching-shield]: https://img.shields.io/github/watchers/namsor/salesforce-addon?label=Watching&style=for-the-badge&color=success
[watching-url]: https://github.com/namsor/salesforce-addon/watchers
[stars-shield]: https://img.shields.io/github/stars/namsor/salesforce-addon?label=Stars&style=for-the-badge&color=success
[stars-url]: https://github.com/namsor/salesforce-addon/stargazers

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
[salesforce-package]: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5w000005xvRaAAI