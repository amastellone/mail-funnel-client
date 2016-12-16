# Mail-Funnel-Client
Mail-Funnel is a Ruby on Rails Embedded Shopify App (Available in the Shopify App Store). It uses Her ORM to connect to it's REST Server.

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
Developers links, resources and guides

