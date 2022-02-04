- [What is DevOps](#what-is-devops)
  * [Why DevOps](#why-devops)
    + [Benefits of DevOps](#benefits-of-devops)
    + [Monolith, 2 tier & Microservices Architectures](#monolith--2-tier---microservices-architectures)
  * [Installation and setup guide for Vagrant, Virtual box and Ruby](#installation-and-setup-guide-for-vagrant--virtual-box-and-ruby)
    + [1. Install ruby](#1-install-ruby)
    + [2. Install vagrant](#2-install-vagrant)
    + [3. Install Virtualbox](#3-install-virtualbox)
    + [4. Installing Vagrant](#4-installing-vagrant)
    + [5. Launching Vagrant](#5-launching-vagrant)
- [Running your VM](#running-your-vm)
  * [Ubuntu and installing/updating packges in VM](#ubuntu-and-installing-updating-packges-in-vm)
- [Linux basics](#linux-basics)
      - [Permissions](#permissions)
    + [Bash scripting](#bash-scripting)
    + [Envi Testing](#envi-testing)
  * [Local Host](#local-host)
  * [On the virtual machine](#on-the-virtual-machine)
  * [Near conclusion of set up](#near-conclusion-of-set-up)
  * [Automation](#automation)
    + [Linux variables](#linux-variables)
    + [Environment Variables](#environment-variables)
  * [Reverse Proxy](#reverse-proxy)
  * [Break down of the code above:](#break-down-of-the-code-above-)
  * [Running two virtual machines](#running-two-virtual-machines)
  * [DB CONNECTION PRE-REQUISITE](#db-connection-pre-requisite)
  * [Mongodb](#mongodb)
  * [Connection between app and db VMs](#connection-between-app-and-db-vms)
  * [Automating provisioning of MongoDB, app and reverse proxy](#automating-provisioning-of-mongodb--app-and-reverse-proxy)
    + [provision.sh for VM app](#provisionsh-for-vm-app)
      - [Automating the reverse proxy for Nginx](#automating-the-reverse-proxy-for-nginx)
    + [provision_db.sh for VM db](#provision-dbsh-for-vm-db)
- [Amazon Web Services (AWS)](#amazon-web-services--aws-)
- [Pushing what we've done in Vagrant to AWS](#pushing-what-we-ve-done-in-vagrant-to-aws)
  * [Back to the terminal!](#back-to-the-terminal-)
  * [Enabling access to your Public IP](#enabling-access-to-your-public-ip)
  * [Enabling port 3000](#enabling-port-3000)
  * [Creating a second instance for MongoDB](#creating-a-second-instance-for-mongodb)
  * [2 tier architecture complete for the app and db!](#2-tier-architecture-complete-for-the-app-and-db-)




# What is DevOps
## Why DevOps
### Benefits of DevOps

**Four pillars of DevOps best practice**
- Ease of Use

troubleshoot release / configuration issues and communicate their discoveries back to the dev team for resolutions that could not be implemented by the DevOps team themselves.

Reaching into each others' toolboxes and using the tools of the others.

Infrastructure that is described by code can thus be tracked, validated, and reconfigured in an automated way.

Pipeline to keep track of everything


- Flexibility (product owner can add changes)
- Robustness - faster delivery of product
- Cost - cost effective (automating process)

As DevOps engineers we need to learn how to understand code and not necessarily write it.

### Monolith, 2 tier & Microservices Architectures

In a monolithic application, everything is so integrated together, you have to rebuild everything anytime you make a change.

2 tier architecture divides the client and database into two. The presentation layer will run on the client and data is stored in the database. The client is on the first tier and the database is on the second tier. Users will have to communicate with the client to access data from the database. 

Microservices are the opposite of a monolith. You have small services that can be deployed individually. Each service has a focus on one aspect of the business functionality. The services are loosely coupled. That means, that the services work relatively independent of each other and only communicate with the other services, if necessary.

![Virtualisation with Vagrant](https://user-images.githubusercontent.com/98178943/152055679-0f873c34-a949-49d9-93fb-a108c4d53615.png)

On this diagram, we are going to be constructing a VMs on our LocalHost based on Linux. We will already have Vagrant installed, Oracle VM Virtual Box, Ruby, Bash, Git and SSH.

Definitions:
-	Vagrant is an open-source software used for building and managing virtual machine environments.
-	SSH provides an encrypted communication channel between two machines: client and server.
-	Git tracks changes in files.
-	Bash is a command line tool used to manipulate files and directories.

Using Vagrant allows the user to automate almost all if not all the steps to configure a virtual machine with the app and environment given from the developer(s). 


## Installation and setup guide for Vagrant, Virtual box and Ruby
------------------------
### 1. Install ruby
- For windows:
<code>[ruby install link](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.6-1/rubyinstaller-devkit-2.6.6-1-x64.exe)</code>

### 2. Install vagrant
- Install <code>[vagrant](https://www.vagrantup.com/)</code>
- To check version, type `Vagrant --version` in your terminal.

### 3. Install Virtualbox
- Install <code>[Virtualbox version 6.1](https://www.virtualbox.org/wiki/Downloads)</code> 

  
> For windows users: 
> 1. In File Explorer, navigate to `C:\Program Files\Oracle\VirtualBox\drivers\vboxdrv`
> 2. Right click on the `VBoxDrv.inf` Setup Information file and and select Install
> 3. When it's finished installing, open up a new terminal window and run `sc start vboxdrv`
> 4. Press the Windows Key and search for **Control Panel**, go from there to **Network and Internet**, then **Network and Sharing Centre**, then **Change Adapter Settings**.
> 5. Right click on **VirtualBox Host-Only Network** and choose **Properties**
> 6. Click on **Install** => **Service**
> 7. Under **Manufacturer** choose **Oracle Corporation** and under **Network Service**, choose **VirtualBox NDIS6 Bridged Networking driver**

### 4. Installing Vagrant
- `cd` the folder you're running the VM from
- Enter `nano Vagrantfile` and add the code:
```
Vagrant.configure("2") do |config|

 config.vm.box = "ubuntu/xenial64"
# creating a virtual machine ubuntu




end

```

### 5. Launching Vagrant
- Launch a terminal with `admin privileges`. `cd` into target directory and make sure `Vagrantfile` is in the same folder.
- run `vagrant init`
- `vagrant up`

# Running your VM
- Check status at all stages by using `vagrant status`
- `vagrant up` to run your VM
- `vagrant ssh` to enter your VM
- `Vagrant destroy` deletes VM
- `vagrant halt` halts VM
- `vagrant reload` updates VM

## Ubuntu and installing/updating packges in VM
- `sudo apt-get update -y` Download and install updates
- `sudo apt-get upgrade -y` Upgrades packages that were possibly updated
- `sudo apt-get install <package>` install package
- `systemctl status <app>` status of specified app
- `exit`


# Linux basics
- Who am I? Type `uname` to find the name of the machine.
- Enter `uname -a` for more detailed information.
- Where am I? Enter `pwd` for home path
- List directories/files, enter `ls`
- List all including hidden folders and files, enter `ls -a`
- To make a directory `mkdir <dir-name>`
- Navigate to directory `cd <dir-name>` (cd \first-letter\ + tab button)
- To create a file, enter `touch <file-name>`
  or `nano <file-name>`
- To display content of the file, enter `cat <file-name>`
- To remove a file, enter `rm -rf <file-name>`
- To copy a file, enter `cp <file-destination-name>`
- To move a file, enter `mv <file-name> <dir-name>` 
- To check running processes, enter `top`

#### Permissions
- READ Write Executable read only
- To checkp permissions, enter `ll`
- To change permissions, enter `chmod <permission-name>`, `sudo chmod +x <file-name>`

### Bash scripting
- To create script, enter in terminal `nano <file-name>.sh`
- Enter commands you want to automate underneath
- `#!/bin/bash` in .sh file
- Enter `cat <file>` to view commands inside it
- To run script, enter `sudo ./<file-name>`

### Envi Testing
Before deploying software from developers, we have to make sure that we have all the dependencies in place in order to be able to run anything. In our example in my repo, we want to run app.js but we need to install dependencies.

## Local Host

- First, on the local host, open a sudo(?) terminal.
- Navigate to the environment folder using `cd` and check using `ls`
- `ls` and if there are files: 
- ```
  Gemfile Gemfile.lock Rakefile
  ```
  enter `gem install bundler` which is to  setup everything for the application containing the Gemfile.
- enter `bundle` to install Ruby dependencies
- enter `rake spec` which is Ruby's method to test for dependencies
- Any failures after `rake spec` will need to be fixed by installing dependencies

## On the virtual machine
- `vagrant ssh` to enter VM
- `sudo apt-get install nodejs -y` to install nodejs, `nodejs -v` to check version. 
If version is incorrect (v4 but we needed v6.x) do..

- `sudo apt-get install python-software-properties` for the module
- `curl -sl https://deb.nodesource.com/setup_6.x | sudo -E bash -` to install nodejs v6.x
- to install the correct version of nodejs `sudo apt-get install nodejs -y`
- `sudo npm install pm2 -g` to install pm2. 
```
PM2: A production process manager for Node. js applications that has a built-in load balancer. PM2 enables you to keep applications alive forever, reloads them without downtime, helps you to manage application logging, monitoring, and clustering.  
```

## Near conclusion of set up
- on the local host use `rake spec` to see if all dependencies are installed and `0` failures
- on the virtual machine enter the directory of `app$`
- Run `npm install` (which downloads a package and its dependencies and  then `npm start`
- Check `http://192.168.10.100:3000/` and `http://192.168.10.100` to ensure the program is running.

## Automation

The process from `vagrant up` to running `npm install` can be automated by entering the code below into `provision.sh`

NOTE: You do not need to enter `vagrant up --provision` if you are creating a new VM.
```
#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install nodejs -y
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install pm2 -g
```

The code below is from the Vagrantfile to execute the `provision.sh` and also to copy all the files such as the environment and app folders into the target VM directory.

```
Vagrant.configure("2") do |config|


config VM.box = "ubuntu/xenial64"

#creating private network with ip
config VM.network "private_network", ip: "192.168.10.100"
# Synced app folder   localhost path, path for VM
config VM.synced_folder ".", "/home/vagrant/app"
# Setting up path for synced folder VM, C+p files from our machine to theirs
# . means all the files from my current location
# Provisioning
config VM.provision "shell", path: "source/provision.sh"
# shell = set up(?), run this file
# provision it, using this method, using this file
end
```

### Linux variables
- Create Linux Var `FIRST_NAME=SHAHRUKH`
- How to check the var `echo $FIRST_NAME`

### Environment Variables
- How to check a variable, enter `env var`
- Enter the command `printenv key` to print a specific variable or `env` to list all variables.
- To create an env var enter `export`
- e.g. `export LAST_NAME=JENKINS`
- To delete env var, use the command: `unset VAR_NAME`
 

How to kill a process in Linux:
- Enter `top` and then `sudo kill <process>`

`grep` is used used to search for a string of characters in a specified file.
- An example of `grep` would be `env | grep HOME`

How to make an env var persistent so it doesn't disappear every time we exit the VM?
- `ls -a` to look for your `.bashrc` file in your directory
- `sudo nano` into it and enter `export <VAR_NAME>=<VALUE>`
- Save and exit and enter `source ~/.bashrc` to save  the file without having to restart the VM.


## Reverse Proxy
Why do we reverse proxy? Similar to a forward proxy, where the user's ip is 'anonymised' so the origin server cannot see their actual proxy, a reverse proxy will act as a front for the origin server for anonymity and to enhance security.  In this instance, we want to stop the port 3000 on the url `http://192.168.10.100` from showing so we need to reverse proxy to hide it. If people are able to access open ports it may lead to malicious and unauthorised access to sensitive data.

The steps to reverse port 3000 are as detailed below:
- First, we need to set up the nginx configuration in the `/etc/nginx/sites-available/default` file
- We can open the code in the VM by `$ sudo nano /etc/nginx/sites-available/default`
or `$ sudo nano default`
or `sudo rm -rf default` to erase everything in the default file and then `nano` in.
The `default` file is the default proxy setup.
- Once in the code:
```

server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://localhost:<THE PORT YOU WANT>;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}  
```


## Break down of the code above:
- `proxy_pass` - Passes on the request for the port to proxy URL
- `proxy_http_version` - sets http protocol version. v1.0 is by default
- `proxy_set_header` - Allows redefining or appending fields to the request header passed to the proxied server. The value can contain text, variables, and their combinations.
- `proxy_cache_bypass` - e.g. get requests, caching can interfere so bypassing will ensure it is getting the correct data for the correct thing.


---------------------------------
To make sure you have entered everything correctly in ~/default. 
- Exit `nano` and enter `sudo nginx -t` in the VM terminal.
- Restart nginx and apply changes by entering `sudo systemctl restart nginx`

Proceed with `npm install` (installing dependencies) and `npm start`
The website should be able to be accessed without specifying the port.


## Running two virtual machines
To run more than one virtual machine, we had to modify our Vagrantfile. 

```
Vagrant.configure("2") do |config|
	config VM.define "app" do |app|
		app VM.box = "ubuntu/xenial64"

		#creating private network with ip
		app VM.network "private_network", ip: "192.168.10.100"
		# Synced app folder   localhost path, path for VM
		app VM.synced_folder ".", "/home/vagrant/app"
		app VM.synced_folder "environment", "/home/vagrant/environment"
		# Setting up path for synced folder VM, C+p files from our machine to theirs
		# . means all the files from my current location
		# Provisioning
		app VM.provision "shell", path: "source/provision.sh"
	end
	# shell = set up(?), run this file
	# provision it, using this method, using this file
	config VM.define "db" do |db|
		db VM.box = "ubuntu/xenial64"
		db VM.network "private_network", ip: "192.168.10.150"
	end
end
```

## DB CONNECTION PRE-REQUISITE
-------------------------------------

![db_host](https://user-images.githubusercontent.com/98178943/152259368-169642f3-ccbc-44d7-975a-5b6526e15d9d.PNG)
```
// connect to database
if(process.env.DB_HOST) {
  mongoose.connect(process.env.DB_HOST);

  app.get("/posts" , function(req,res){
      Post.find({} , function(err, posts){
        if(err) return res.send(err);
        res.render("posts/index" , {posts:posts});
      })
  });
}
```

We have a database, that we need to configure and to set up on a separate VM, and that VM will also have ubuntu 16.04 as that is the environment that we have tested. Once we have that VM, we should be able to communicate from our VM, off the front end app to the db. The new VM will have mongodb (the database). It will have nodejs and nginx installed already. Looking at the documentation from the dev, how are they connecting the app with the db? By using DB_HOST env var. Once the db VM is created, the app needs to have the DB_HOST to fetch the data from db and to display it on post/index.

## Mongodb
-------------------
Mongodb is a document database that we are going to use to populate our app.

So to install mongodb, we have to enter the code below:

`sudo apt-get update -y`

`sudo apt-get upgrade -y`

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`
```
- this line downloads the key from keyservers directly into our trusted set of keys.
- apt-key is used to manage the list of keys used by apt to authenticate packages. Packages
       which have been authenticated using these keys will be considered trusted.
```
`echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list`
```
- this line registers the repo
```

`sudo apt-get update -y`

`sudo apt-get upgrade -y`

`sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20`
```
- this line installs the package
```
`sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf`
```
-this line changes the bind_ip to 0.0.0.0 from 127.0.0.1. The reasoning for this is because we want all ip addresses to listen in.
```
`sudo systemctl restart mongod`
```
- reload and apply changes
```
`sudo systemctl enable mongod`

## Connection between app and db VMs
--------------------------
Return to the app VM and enter:
`echo "export DB_HOST='mongodb://192.168.10.150:27017/posts'" >> /home/vagrant/.bashrc`
```
- This line is to fetch data from the db and display it on posts
```
`source /home/vagrant/.bashrc`
```
- this line executes the added code
```
`printenv DB_HOST`
``` 
- This line is to check if the env var exists
```
`node seeds/seed.js`
```
- this line is to populate the db
``` 
Enter `npm install and npm start` and enter `192.168.10.100:3000/posts` to see the populated database.

## Automating provisioning of MongoDB, app and reverse proxy
-------------------
To automate everything we've done so far, we need to create two separate provision files, in this case the second provision file is called `provision_db`. We include everything we've done so far into a simple script excluding the commands:
- `npm install`
- `npm start`
- `node seeds/seed.js`

### provision.sh for VM app
--------------------
```
#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install nodejs -y
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install pm2 -g

sudo rm -rf /etc/nginx/sites-available/default
sudo cp app/default /etc/nginx/sites-available/
sudo systemctl restart nginx
sudo systemctl enable nginx
echo "export DB_HOST='mongodb://192.168.10.150:27017/posts'" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc
```
#### Automating the reverse proxy for Nginx
------------------------
A new file called `default` is created and referred to when loaded into app. This file contains the correct proxy configuration for reverse proxy as seen below.
```
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}  
```

### provision_db.sh for VM db
----------------------
```
#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# echo registers repo
sudo apt-get update -y
sudo apt-get upgrade -y 
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
sudo systemctl restart mongod
sudo systemctl enable mongod
```


# Amazon Web Services (AWS)
**What is AWS?**
- AWS is a cloud platform provided by Amazon. It includes a mixture of infrastructure, platform and software as a service.
- AWS offers database storage, compute power and content delivery services for individuals and businesses alike. 

**What is cloud computing?**
- Tasks, activities, storage and processes usually performed on  your pc are done on the cloud/internet instead.

**Benefits of cloud computing?**
- Cost efficiency
- Almost unlimited storage size
- Backup and recovery
- Accessibility
- APIs

![2 tier architecture with AWS](https://user-images.githubusercontent.com/98178943/152561817-d0a62b3d-7f58-4c98-ae6f-ab3550e85045.png)

# Pushing what we've done in Vagrant to AWS
Our region is Europe - Ireland for the EC2 VMs which we are going to use.
The steps to launch an instance are:
- Launch the EC2 instance
- Search  for "Ubuntu Server 18.04 LTS" and select the 64-bit(x86) server
- Choose the instance type by default which is `t2 micro`
- Configure instance details to set subnet to "DevOpsStudent default 1a" and Enable auto assign for public ip
- Next add tags with key being "NAME" and value to "ENG103A_NAME"
- Edit security group name: "ENG103A_NAME"
- Edit description: "ENG103A_NAME"
- Set SSH sources to "my ip" and although optional, add "only my ip" to description. NOTE: It is always good to add descriptions.
- Select preview and then launch. This will prompt to choose an existing key pair which will be `103a | rsa`

## Back to the terminal!
-------------------
- Open your terminal as admin
- download the SSH KEY eng103a.pem file and copy the contents or move the file to `~/.ssh`
- Return back to EC2 instance and turn on your VM
- Run the command `chmod 400 eng103a.pem`to give the user read permission, and removes all other permissions.
- Enter `$ ssh -i "eng103a.pem" ubuntu@ec2-<YOUR_IP>.<YOUR_LOCATION>-1.compute.amazonaws.com` to SSH into the machine
- Enter `sudo apt update -y`
- `sudo apt upgrade -y`
- `sudo apt install nginx -y`
- To sync files to our EC2 VM, we can enter `scp -i "~/.ssh/eng103a.pem" -r app ubuntu@ec2-54-171-115-252.eu-west-1.compute.amazonaws.com:~` 

## Enabling access to your Public IP
-------------------
 - Go back to EC2 VM instances and click on your name
 - enter security tab > click on the link to your security group > edit inbound rules > add rule
 - For type: "HTTP", source: "anywhere-IPv4" description: "public access" and save the rules
 - Your nginx site should be available for everyone to see!


## Enabling port 3000
-------------------------------------
- Return to EC2 instances
- On the `security` tab, enter the link under `Security Groups`
- Add new inbound rules > add rule > Type: Custom TCP > Port range: 3000 > Source: Custom > Description: welcome page > save rules.

## Creating a second instance for MongoDB
------------------
Follow the same steps as [Pushing what we've done in Vagrant to AWS](#Pushing-what-we've-done-in-Vagrant-to-AWS) except add `_db` to all the names.
- Also, during the configuration of security groups add an extra rule: Type: "Custom TCP Rules" > Port Range: "27017" > Source: "Anywhere" > Description: "allow from app only".

Load into the terminal and `~/.ssh` into the db VM. e.g. `$ ssh -i "eng103a.pem" ubuntu@ec2-<YOUR_IP>.<YOUR_LOCATION>-1.compute.amazonaws.com`
- Set up mongodb by either loading your `provision_db.sh` file or entering the commands manually.
- Once you're done, `sudo systemctl status mongod` to check if everything has been configured correctly.

## 2 tier architecture complete for the app and db!
--------------------------
Return to the app vm and make sure to enter the correct ip address of the db VM into `DB_HOSTS`:
```
sudo nano .bashrc

export DB_HOST=mongodb://xx.xx.xx.xxx:27017/posts

source .bashrc
```
`npm install`, `node seeds/seed.js` and `npm start` to correctly configure and load `xx.xx.xx.xxx:3000/posts` on your browser!


