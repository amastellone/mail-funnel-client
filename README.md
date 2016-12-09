# Mail-Funnel-Client
Mail-Funnel is a Ruby on Rails Embedded Shopify App (Available in the Shopify App Store). It uses Her ORM to connect to it's REST Server.

## Developmet

```
Visit (Development)
http://localhost:3000 
```

### Testing

```bash
rake test
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

