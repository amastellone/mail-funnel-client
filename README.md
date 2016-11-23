# README
Mail-Funnel is a Ruby on Rails embedded Shopify App (Distributed in Shopify App Store). It works with the Mail-Funnel central API.


## Usage
Run
```
bundle exec rails server
```
Then, to install, go to http://localhost:3000/login


## REST ORM
http://www.her-rb.org/

### Install
```bash
 1277  rails g migration add_uuid_to_books
 1278  rails g migration enable_uuid_extension
 1280  rails g campaign hook_uuid:references campaign_job_id:references
 1281  rails g scaffold campaign hook_uuid:references campaign_job_id:references
 1282  rails g scaffold campaign_job campaign_id:references job_uuid:references position:integer
 1283  rails g scaffold user name:string email:string app_uuid:references
 1284  rails g scaffold HooksConstant name:string uuid:references
 1286  rails g scaffold Email email:string name:string email_list_uuid:references
 1287  rails d scaffold Email
 1288  rails g scaffold Email email:string name:string email_list_uuid:references app_uuid:references
 1289  rails g scaffold job time:references subject:string content:text email_list_uuid:references app_uuid:references hook_uuid:references user_local_id:integer
 1290  rails g app user_local_id:integer name:string api_key:string api_secret:text
 1291  rails g scaffold app user_local_id:integer name:string api_key:string api_secret:text
 1292  rails g scaffold email_lists
 1293  rails d scaffold email_lists
 1294  rails g scaffold email_lists app_uuid:references user_local_id:integer name:string description:text
 1295  rails g scaffold hooks name:text identifier:text
```