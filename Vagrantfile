
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
		app.vm.provision "shell", path: "source/provision.sh", privileged: false
	end
	# shell = set up(?), run this file
	# provision it, using this method, using this file
	config.vm.define "db" do |db|
		db.vm.box = "ubuntu/xenial64"
		db.vm.network "private_network", ip: "192.168.10.150"
		db.vm.synced_folder ".", "/home/vagrant/db"
		db.vm.provision "shell", path: "source/provision_db.sh", privileged: false
	end
end