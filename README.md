# Mail-Funnel-Client
[![Coverage Status](https://circleci.com/gh/vaskaloidis/mail-funnel-server-api.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/vaskaloidis/mail-funnel-server-api.svg?style=shield&circle-token=:circle-token) [![Coverage Status](https://coveralls.io/repos/github/vaskaloidis/mail-funnel-server-api/badge.svg?branch=master)](https://coveralls.io/github/vaskaloidis/mail-funnel-server-api?branch=master)[![Stories in Ready](https://badge.waffle.io/vaskaloidis/mail-funnel-client.svg?label=ready&title=Ready)](http://waffle.io/vaskaloidis/mail-funnel-client)

Mail-Funnel is a Ruby on Rails Embedded Shopify App (Available in the Shopify App Store). It uses Her ORM to connect to it's REST Server.


**Mail-Funnel Project:**  
  
[Waffle Board](https://waffle.io/vaskaloidis/mail-funnel-client)
[Mail-Funnel Server API](https://github.com/vaskaloidis/mail-funnel-server-api)
[Mail-Funnel Client-Server WIKI](https://github.com/vaskaloidis/mail-funnel-client/wiki)
[Mail-Funnel Client-Server ISSUES](https://github.com/vaskaloidis/mail-funnel-client/issues)


### App Store Config
Development - .env
```
APP_URL=http://localhost:3000/
REDIRECTION_URL=http://localhost:3000/auth/shopify/callback
```

### Client Security Method  
We are using JWT, automaticaly added to the header on the Client, and added in the Rack on the server

```
# Client
https://www.sitepoint.com/introduction-to-using-jwt-in-rails/

# Both
https://github.com/nsarno/knock

# Server (and maybe client)
https://github.com/eigenbart/rack-jwt
https://github.com/jgalmeida/rack-jwt-auth
https://github.com/jwt/ruby-jwt

https://jwt.io/

```

### Developmet

```
Visit (Development)
http://localhost:3000 
```

### Testing

```bash
rake
# or
rake test

# Test Individual Client-API Tests
bundle exec rspec ./spec/models/apps_spec.rb # Tests Apps w/ ORM to Server-API
```
### Development
```bash
rake test
```

### Staging + Production

**Deployment Process**  
Github -> Circle-CI Server -> Heroku-Staging -> Heroku-Production

- **Github**
 - Pushed to GitHub
 - Code-Analysis Service(s) Executed Automatically
- **Circle-CI**
 - **coveralls.io** - Test Coverage Executed
 - **depbot.io** - Dependency Analysis  
- **Heroku-Staging**  
 - Builds temporary Heroku server, destroys 5 days after last use  
 - Creates new Heroku server to test production data
- **Heroku-Production**
  - **Rollbar.io** - Error / Log Monitoring + Reporting Tool
- **Mail-Funnel-Client**

## Usage + Install

**Warning:** You must
To start the client execute this

```
bundle exec rails server
```

Then, to install this Shopify App, go to 

```
http://localhost:3000/login (or /install or /auth)
```

Once you have added the client, you must add the server too

```
TODO: Server install URL is wrong
http://localhost:3001/auth
```

Then once you visit the client - you will be forwarded to your App's page in the Shopify store it was installed in.   
**NOTICE:** Your app will not load by default, while it is being run on your localhost, because Chrome does not allow cross-site-scripting.   
You **MUST** disable this by clicking the icon in the URL-bar, on the right, and telling it to load the script regardless

```
Visit App Install Page
http://localhost:3000 / mf-client.bluehelmet.io 

This will foward you to the Shopify Store's internal Mail Client App URL.
http://your-store.myshopify.com

Mail-Funnel API Server (Dev) / (Staging) / (Production)
http://localhost:3001 / http://mf-server.bluehelmet.io

```

# Developers


## JS Resources for Funnel_Builder Ajax flowchart 
[bluehelmet-dev ~ Apps ~ Shopify](https://bluehelmet-dev.myshopify.com/admin/apps/mail-funnel-client/?hmac=6a7cd818ca18817a2204d029ac7d431291dbb27f12dd5f1758dfb326c38042a6&protocol=https%3A%2F%2F&shop=bluehelmet-dev.myshopify.com&timestamp=1482477282)  

[Working with JavaScript in Rails — Ruby on Rails Guides](http://guides.rubyonrails.org/working_with_javascript_in_rails.html)  

[akzhan/jquery-ujs: Ruby on Rails unobtrusive scripting adapter for jQuery](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/akzhan/jquery-ujs/tree/asynchronous-call-to-confirm)  

[ActionController::RequestForgeryProtection](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html#method-i-verify_authenticity_token)  

[Active Model Basics — Ruby on Rails Guides](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://guides.rubyonrails.org/active_model_basics.html#serialization)  

[Action View Overview — Ruby on Rails Guides](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://guides.rubyonrails.org/action_view_overview.html#formhelper)  

[ruby on rails 3 - Difference between Active Model, Active Record and Active Resource - Stack Overflow](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://stackoverflow.com/questions/12653296/difference-between-active-model-active-record-and-active-resource)  

[ActiveModel | Running with Ruby](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://mensfeld.pl/tag/activemodel/)  

[Active Record Query Interface — Ruby on Rails Guides](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://guides.rubyonrails.org/active_record_querying.html#existence-of-objects)  

[External articles · rails/jquery-ujs Wiki](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/rails/jquery-ujs/wiki/External-articles)  

[jquery-ujs/rails.js at asynchronous-call-to-confirm · akzhan/jquery-ujs](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/akzhan/jquery-ujs/blob/asynchronous-call-to-confirm/src/rails.js)  

[Rails 3 Remote Links and Forms: A Definitive Guide - Alfa Jango Blog](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://www.alfajango.com/blog/rails-3-remote-links-and-forms/)  

[Rails 3 Remote Links and Forms Part 2: Data-type (with jQuery) - Alfa Jango Blog](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://www.alfajango.com/blog/rails-3-remote-links-and-forms-data-type-with-jquery/)  

[Rails jQuery UJS: Now Interactive - Alfa Jango Blog](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://www.alfajango.com/blog/rails-jquery-ujs-now-interactive/)  

[A Tour of Rails’ jQuery UJS](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://robots.thoughtbot.com/a-tour-of-rails-jquery-ujs)  

[rails/jbuilder: Jbuilder: generate JSON objects with a Builder-style DSL](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/rails/jbuilder)  

[Class: ActiveResource::Schema — Documentation for activeresource (4.0.0)](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://www.rubydoc.info/gems/activeresource/4.0.0/ActiveResource/Schema)  

[Rails 4: How to partials & AJAX, dead easy (Example) | Coderwall](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://coderwall.com/p/kqb3xq/rails-4-how-to-partials-ajax-dead-easy)  

[Rails 4 rendering a partial with ajax, jquery, :remote => true, and respond_to - Stack Overflow](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://stackoverflow.com/questions/26808696/rails-4-rendering-a-partial-with-ajax-jquery-remote-true-and-respond-to)  

[jquery - How to asynchronously load a partial page in rails - Stack Overflow](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://stackoverflow.com/questions/6701623/how-to-asynchronously-load-a-partial-page-in-rails)  

[sdrdis/jquery.flowchart: JQuery plugin that allows you to draw a flow chart.](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/sdrdis/jquery.flowchart)  

[jQuery.ajax() | jQuery API Documentation](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://api.jquery.com/jquery.ajax/)  

[Automatically adding CSRF tokens to ajax calls when using jQuery](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://erlend.oftedal.no/blog/?blogid=118)  

[Rails 3: How to return errors in a JSON request? - Stack Overflow](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=http://stackoverflow.com/questions/6004536/rails-3-how-to-return-errors-in-a-json-request)  

[rack/utils.rb at master · rack/rack](chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#uri=https://github.com/rack/rack/blob/master/lib/rack/utils.rb#L539)  


