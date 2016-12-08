# Mail-Funnel-Client
Mail-Funnel is a Ruby on Rails Embedded Shopify App (Available in the Shopify App Store). It uses Her ORM to connect to it's REST Server.



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
Visit 
http://localhost:3000

And it will foward you to a URL similar to this, with your app in an embedded window

http://your-store.myshopify.com

```

## REST ORM
http://www.her-rb.org/
