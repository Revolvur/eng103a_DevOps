
# What is DevOps
## Why DevOps
### Benefits of DevOps

**Four pillars of DevOps best practice**
- Ease of Use

*-* troubleshoot release / configuration issues and communicate their discoveries back to the dev team for resolutions that could not be implemented by the DevOps team themselves.

*-* Reaching into each others' toolboxes and using the tools of the others.

*-* Infrastructure that is described by code can thus be tracked, validated, and reconfigured in an automated way.

*-* Pipeline to keep track of everything


- Flexibility (product owner can add changes)
- Robustness - faster delivery of product
- Cost - cost effective (automating process)

### Monolith, 2 tier & Microservices Architectures

In a monolithic application, everything is so integrated together, you have to rebuild everything anytime you make a change.

Microservices are the opposite of a monolith. You have small services that can be deployed individually. Each service has a focus on one aspect of the business functionality. The services are loosely coupled. That means, that the services work relatively independent of each other and only communicate with the other services, if necessary.

## Installation and setup guide for Vagrant, Virtual box and Ruby
------------------------
### 1. Install ruby
- For windows:
<code>[ruby install link](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.6-1/rubyinstaller-devkit-2.6.6-1-x64.exe)</code>

### 2. Install vagrant
- Install <code>[vagrant](https://www.vagrantup.com/)</code>
- To check version, type `Vagrant --version` in your terminal.

### 3. Install Virtualbox
 - Install <code>[Virtualbox version 6.1] https://www.virtualbox.org/wiki/Downloads</code>
  
  
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
