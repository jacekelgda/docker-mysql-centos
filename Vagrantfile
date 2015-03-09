Vagrant.configure(2) do |config|
  config.ssh.username="root"

  config.vm.define "mysql" do |a|
    a.vm.provider "docker" do |d|
      d.name = "mysql"
      d.build_dir = "."
      d.vagrant_vagrantfile = "./proxy/Vagrantfile.proxy"
      d.ports = ["3306:3306"]
    end
  end
end
