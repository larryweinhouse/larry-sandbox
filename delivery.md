## Requirements, Places Delivery Pipeline

### 1) Who are our clients and what products do they get
- **Licensed clients**
  - Clients that have an ongoing contract expecting delivery every 4 to 6 weeks
  - Products include: Standard, Custom, and Diffs data sets.
- **Licensed one time download clients**
  - Clients that purchase a one time download of Factual data, for example lead generation.
  - Products include: Standard or Custom data sets.
- **Prospective clients**
  - Samples of any standard or custom dataset delivered via Dropbox link or email
- **Internal clients**
  - Things like standard data sets (csv), self service db, private places files, and files with additional attributes such as melissa_addresses,existence_full,status, etc. delivered in outfiles acting as guardrails for further processing.
  
  
### 2) Deliverables

- **Intermediate files** (59 versions currently named outfiles)
  - you can find current outfiles at: nfs://share/exports/uploaded/FACTUAL_MASTER/outfiles
  - These files are a subset of our index which have been vetted and contain only approved attributes suitable for partner consumption. These files act as a source of truth so that any human or machine can further process producing standard or custom datasets.
  
- **Standard and diffs data sets**
  - A set of standard files are placed on nfs for Internal customers.
    - nfs://share/exports/uploaded/FACTUAL_MASTER/outfiles
  - Following is list of our standard products along with naming convention. see this [env file](https://github.com/Factual/PartnerServices/blob/master/auto_updates/workflow/Drakefile.delivery.env) for schema:
```
STANDARD FILES:
[a-z][a-z]_places.factual
[a-z][a-z]_places_w_pr.factual 
[a-z][a-z]_places_and_crosswalk.factual                     Currently not available for diffs
[a-z][a-z]_places_w_pr_and_crosswalk.factual                Currently not available for diffs
[a-z][a-z]_hotels.factual
[a-z][a-z]_hotels_w_pr.factual                              Currently not available for diffs
[a-z][a-z]_hotels_and_crosswalk.factual                     Currently not available for diffs or ad-hoc delivery
[a-z][a-z]_hotels_w_pr_and_crosswalk.factual                Currently not available for diffs or ad-hoc delivery
[a-z][a-z]_restaurants.factual
[a-z][a-z]_restaurants_w_pr.factual                         Currently not available for diffs
[a-z][a-z]_restaurants_and_crosswalk.factual                Currently not available for diffs or ad-hoc delivery
[a-z][a-z]_restaurants_w_pr_and_crosswalk.factual           Currently not available for diffs or ad-hoc delivery
[a-z][a-z]_healthcare_providers.factual
[a-z][a-z]_healthcare_providers_w_pr.factual                Currently not available for diffs
[a-z][a-z]_healthcare_providers_and_crosswalk.factual       Currently not available for diffs or ad-hoc delivery
[a-z][a-z]_healthcare_providers_w_pr_and_crosswalk.factual  Currently not available for diffs or ad-hoc delivery

DIFFS FILES:
<standard_name>_batch-diff.factual
  i.e. places_batch-diff.factual
```
- **Data sets for ad-hoc delivery**  
These are standard data sets as listed above placed on Dropbox so that Account Managers can send quickly on ad-hoc basis to clients/prospects. This will no longer be necessary if our ui will allow Account Managers to easily set up a new client and immediately deliver.

- **Custom data sets**
  - These all come from standard data views but have additional processing on columns and or rows.
  - we currently use an [environment file](https://github.com/Factual/PartnerServices/blob/master/auto_updates/custom_download_support/custom_download_support.env) and [scripts](https://github.com/Factual/PartnerServices/tree/master/auto_updates/custom_download_support) to do the processing
  - Here is the naming convention for custom data sets which will allow standard delivery workflow.
```
CUSTOM:
<client_identifier>_<standard dataset name>.factual
  i.e. fav_client_bla_bla_bla_us_places.factual
```
- **Delivery notification**  
If data is delivered to Factual delivery endpoints, we will send delivery email notification. If we send to a clients endpoint we do not send notifications.

- **Product samples**   
We furnish samples (slices of rows/columns) of any of our standard datasets in the same format as our final delivered products as to set expectations. Samples are delivered to Dropbox and customer is sent a download link.

- **Self service [database](https://github.com/Factual/data-projects/tree/develop/projects/api-downloader/sales_db)**  
This is self service sql database that we load at each of our builds including tables for standard data sets. This is used by Internal clients to explore, download, or use for further processing.

- **[stats](https://docs.google.com/spreadsheets/d/1kHMToN9rsTO5ytX-BgCc8rEJ2GKNWt94HJOeVbxiMyk/edit?usp=drive_web&ouid=106487463529999467763) sheet**  
We deliver a stats sheet for internal users to use for general questions about data. This is used both internally and shared externally with prospects and clients.

- **Delivery Options**
We have been able to satisfy all delivery requirements with the following three options.
- Factual Dropbox or SFTP endpoints.
- Client SFTP or AWS bucket. We **must** have passwords/keys and the ability to send via command line.
- Client Web interface:
  - This is a **very undesireable option**. Currently we do not have any partners that require this. We have accomidated this in the past by placing files in our Dropbox "Custom_Download_Support" Folder. Account Managers are then tasked to manually download to their laptop and upload to the clients GUI.

### 3) Current Process

- **Configuration [file](https://github.com/Factual/PartnerServices/blob/master/auto_updates/scripts/clients.yaml)**
this is our source of truth for who gets what

- **Naming convention**
See above for naming convention of all products. It is very important to include the date that links us to the particular build. For example: "us_places.factual.2019-01-22.1548972589.tab.gz" Is created with data in build directory 2019-01-22.

- **[Current workflow](https://github.com/Factual/PartnerServices/tree/master/auto_updates/workflow)**
This is a series of Drake workflow jobs and one liners that get us from a to z for a delivery cycle :-) This page also shows the roadmap as to where I have wanted to take the delivery project.



