Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 4040, host: 4040
  config.vm.network "forwarded_port", guest: 4041, host: 4041
  config.vm.network "forwarded_port", guest: 7077, host: 7077
  config.vm.provider "virtualbox" do |vb|
    vb.name = "sparkvm"
    vb.memory = 8192
    vb.cpus = 4
  end
end
