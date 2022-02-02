
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

### Monolith, 2 tier & Microservices Architectures

In a monolithic application, everything is so integrated together, you have to rebuild everything anytime you make a change.

Microservices are the opposite of a monolith. You have small services that can be deployed individually. Each service has a focus on one aspect of the business functionality. The services are loosely coupled. That means, that the services work relatively independent of each other and only communicate with the other services, if necessary.

![Virtualisation with Vagrant](https://user-images.githubusercontent.com/98178943/152055679-0f873c34-a949-49d9-93fb-a108c4d53615.png)

On this diagram, we are going to be constructing a VM/VMs on our LocalHost based on Linux. We will already have Vagrant installed, Oracle VM Virtual Box, Ruby, Bash, Git and SSH.

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
- `cd` the folder you're running the vm from
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
- `vagrant up` to run your vm
- `vagrant ssh` to enter your vm
- `Vagrant destroy` deletes vm
- `vagrant halt` halts vm
- `vagrant reload` updates vm

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
- `vagrant ssh` to enter vm
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


config.vm.box = "ubuntu/xenial64"

#creating private network with ip
config.vm.network "private_network", ip: "192.168.10.100"
# Synced app folder   localhost path, path for vm
config.vm.synced_folder ".", "/home/vagrant/app"
# Setting up path for synced folder vm, C+p files from our machine to theirs
# . means all the files from my current location
# Provisioning
config.vm.provision "shell", path: "source/provision.sh"
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

How to make an env var persistent so it doesn't disappear everytime we exit the vm?
- `ls -a` to look for your `.bashrc` file in your directory
- `sudo nano` into it and enter `export <VAR_NAME>=<VALUE>`
- Save and exit and enter `source ~/.bashrc` to save  the file without having to restart the VM.

-DB CONNECTION PRE-REQUISITE
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
As DevOps we need to learn how to understand code and not necessarily write it.

## Reverse Proxy
Why do we reverse proxy? Similar to a forward proxy, where the user's ip is 'anonymised' so the origin server cannot see their actual proxy, a reverse proxy will act as a front for the origin server for anonymity and to enhance security.  In this instance, we want to stop the port 3000 on the url `http://192.168.10.100` from showing so we need to reverse proxy to hide it. If people are able to access open ports it may lead to malicious and unauthorised access to sensitive data.

The steps to reverse port 3000 are as detailed below:
- First, we need to set up the nginx configuration in the `/etc/nginx/sites-available/default` file
- We can open the code in the vm by `$ sudo nano /etc/nginx/sites-available/default`
or `$ sudo nano default`
or `sudo rm -rf default` to erase everything in the default file and then `nano` in
- Once in the code:
```
. . .
    location / {
        proxy_pass http://localhost:<PORT/URL YOU WANT TO REVERSE PROXY>;
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
- Exit `nano` and enter `sudo nginx -t` in the vm terminal.
- Restart nginx and apply changes by entering `sudo systemctl restart nginx`

Proceed with `npm install` (installing dependencies) and `npm start`
The website should be able to be accessed without specifying the port.


## Running two virtual machines
To run more than one virtual machine, we had to modify our Vagrantfile. 

```
Vagrant.configure("2") do |config|
	config.vm.define "app" do |app|
		app.vm.box = "ubuntu/xenial64"

		#creating private network with ip
		app.vm.network "private_network", ip: "192.168.10.100"
		# Synced app folder   localhost path, path for vm
		app.vm.synced_folder ".", "/home/vagrant/app"
		app.vm.synced_folder "environment", "/home/vagrant/environment"
		# Setting up path for synced folder vm, C+p files from our machine to theirs
		# . means all the files from my current location
		# Provisioning
		app.vm.provision "shell", path: "source/provision.sh"
	end
	# shell = set up(?), run this file
	# provision it, using this method, using this file
	config.vm.define "db" do |db|
		db.vm.box = "ubuntu/xenial64"
		db.vm.network "private_network", ip: "192.168.10.150"
	end
end
```
