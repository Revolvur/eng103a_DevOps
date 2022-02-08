

# What is S3
S3 means Simple Storage Service. It is a highly available and very cost effective service.

Amazon S3 stores Objects, they differ from files in a way.... {need extra reading}

S3 uses Buckets for storage. These buckets exist in different AWS regions, such as Ireland or Frankfurt. Stored data is replicated between multiple data centres. Behind the scenes, one object may be stored in one data region but will actually be duplicated multiple times.



S3 can be used for disaster recovery. With S3 we can use CRUD, which stands for the actions: Create bucket/object, read, update and delete.

![dr](https://user-images.githubusercontent.com/98178943/152986900-5684a71b-9f22-4cf1-9b33-47e8334a476b.png)
The diagram above shows the steps throughout disaster recovery. If throughout any point an instance fails, objects stored can be accessed from other Buckets.

From the diagram, from the localhost to AWS EC2:
- We need the .pem to be able to access our EC2

From the AWS EC2 to our AWS S3:
- We need AWSCLI and its dependencies
- We also need AWS Access and Security keys

AWS S3 has various storage classes:
- Standard - Access data at anytime (higher cost)
- Glacial - For infrequent data access (cheaper the longer you keep the data retrieval on)

To access S3 and to effectively back up and recover objects we need to have access to our AWS ACCESS KEY and SECRET KEY.

## AWS Command Line Interface (AWSCLI)
---------
AWSCLI is used to command multiple AWS services and we can access S3 through this.
### Steps:
- SSH into your instance
- install AWSCLI python 3 dependencies: `sudo apt install python3-pip`
- `sudo apt install python3.7-minimal`
- Set alias for python: `alias python=python3.7`
- `sudo pip3 install awscli`
- Enter `aws configure` to enter your access and security keys:
```
AWS Access Key ID [None]: 
AWS Secret Access Key [None]:
Default region name [None]: eu-west-1
Default output format [None]: json
```
- Enter `aws s3 ls` to check that you have the directories.