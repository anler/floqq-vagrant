# Floqq development environment and Virtual Machine

## Installation

```sh
git clone git@github.com:Floqq/vm.git
cd vm
git submodule init && git submodule update
vagrant up
```

**REMEMBER** to initialize and udpate the submodules (cookbooks)!

## Once everything is installed

### Configure Google App Engine

See [GAE-Cookbook](https://github.com/ikame/gae-cookbook) for more
information about this.

You just need to run this once or whenever you change your default shell.

```sh
vagrant ssh
configure_appengine
source $HOME/.`basename $SHELL`rc
```

That will configure the relevant bits for having appengine programs
available in your PATH.

## Dependencies

1. [VirtualBox][vbox] or [VMware][vmw]
2. [Vagrant][vagrant]

**Note** if you're using VMware you need the vagrant
[vmware plugin](http://www.vagrantup.com/vmware)

## Terminology

* Guest Machine: The virtual machine
* Host Machine: Your computer

### Accessing the guest machine from your browser

The vm has the following ports forwarded, either way pay attention to
the vragrant up logs because sometimes there's a collision with the
ports and vagrant automatically choose another port in the host.

    config.vm.network :forwarded_port, host: 8000, guest: 8000
	config.vm.network :forwarded_port, host: 8080, guest: 8080

Anyway, you can always use the ones you prefer most by creating a
`Vagrantfile.local` file with the following:

```ruby
settings[:forwarded_ports] = [{:host => ..., :guest => ...}, ...]
```

## Commands

### Booting

```sh
vagrant up
```

If you're using VMware:

```sh
$ vagrant up --provider=vmware_fusion
```

### Suspending

```sh
vagrant suspend
```

### SSHing

```sh
vagrant ssh
```

## Troubleshooting

```sh
vagrant destroy && vagrant up
```

If you're using VMware:

```sh
$ vagrant destroy && vagrant up --provider=vmware_fusion
```

[vbox]: https://www.virtualbox.org/wiki/Downloads "VirtualBox downloads"
[vmw]: https://www.virtualbox.org/wiki/Downloads "VMware website"
[vagrant]: http://downloads.vagrantup.com/ "Vagrant downloads"
