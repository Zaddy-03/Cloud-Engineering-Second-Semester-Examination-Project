Vagrant.configure("2") do |config|
    config.vm.define "Master" do |master|
      master.vm.box = "ubuntu/bionic64"
      master.vm.network "private_network", type: "dhcp"
      master.vm.provision "shell", path: "provision-master.sh"
    end
  
    config.vm.define "Slave" do |slave|
      slave.vm.box = "ubuntu/bionic64"
      slave.vm.network "private_network", type: "dhcp"
      slave.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible-playbook.yml"
      end
    end
  end
  