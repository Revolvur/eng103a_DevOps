# What is S3
S3 means Simple Storage Service. It is highly available and very cost effective.

Amazon S3 stores Objects, they differ from files in a way.... {need extra reading}

S3 uses Buckets for storage. These buckets exist in different AWS regions, such as Ireland or Frankfurt. Stored data is replicated between multiple data centres. Behind the scenes, one object may be stored in one data region but will actually be duplicated multiple times.

![dr](https://user-images.githubusercontent.com/98178943/152986375-0e1bd290-4883-4bb5-aeca-d8eece7bd439.png)

S3 can be used for disaster recovery. With S3 we can use CRUD, which stands for the actions: Create bucket/object, read, update and delete.

The diagram above shows the steps throughout disaster recovery. If throughout any point an instance fails, objects stored can be accessed from other Buckets.