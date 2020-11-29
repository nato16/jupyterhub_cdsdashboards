# jupyterhub_github_auth

## Before building the image
Create an oAuth apps, save your `client_id`, and `client_serect`
## Build image
This build step expect to see the `client_id`,`client_secret` & `callback_url` in your environment.
```
make build
```

## Run the jupyterhub
The IP is set as "0.0.0.0" and port "8000" 
```
make run
```

## Access the jupyterhub
`http:<ip>:8000`
