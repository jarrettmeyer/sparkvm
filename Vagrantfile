Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 4040, host: 4040
  config.vm.network "forwarded_port", guest: 6066, host: 6066
  config.vm.network "forwarded_port", guest: 7077, host: 7077
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # Provision scripts
  config.vm.provision "shell", path: "./scripts/provision.sh"
  config.vm.provision "shell", path: "./scripts/provision-always.sh", run: "always"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "sparkvm"
    vb.memory = 1024 * 16 # 16 MB
    vb.cpus = 4
  end
end
