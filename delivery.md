## Data Delivery Pipeline Requirements:

### 1) Who are our clients
- Licensed clients
  - Clients that have an ongoing contract expecting delivery every 4 to 6 weeks
- Licensed one time download
  - Clients that purchase a one time download of Factual data, for example lead generation.
- Prospective clients
  - Samples of any standard or custom dataset delivered via Dropbox link
- Internal clients
  - Things like private places files, additional attributes such as melissa_addresses,existence_full etc placed in outfiles acting as guardrails for further processing.
  
  
### 2) Products

- **Intermediate files** (59 versions currently named outfiles)
  - you can find current outfiles at: nfs://share/exports/uploaded/FACTUAL_MASTER/outfiles
  - These files are a subset of our index which have been veted and have only approved attributes for partner consumption. These files act as a source of truth so that any human or machine can consume to produce standard or custom datasets.
  
- **Standard and diffs data sets**
  - Delivery options 
    - Factual Dropbox or SFTP endpoint.
    - Client SFTP or AWS bucket. We must have passwords and ability to send via command line
    - Client Web interface. We can only send a file to Dropbox "Custom_Download_Support" Folder and Account Management sends manualy.
  - Here are our standard products along with naming convention:
```
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

DIFFS:
<standard_name>_batch-diff.factual
  i.e. places_batch-diff.factual
```
- **Data sets for ad-hoc delivery**  
This is a set of our standard data sets as listed above that Account Managers can send quickly on an ad-hoc basis to new clients. This will no longer be necessary if our ui will allow Account Managers to easliy set up a new client.

- **Custom data sets**
  - These are the same as 
CUSTOM:
<client_identifier>_<standard dataset name>.factual
  i.e. fav_client_bla_bla_bla_us_places.factual
