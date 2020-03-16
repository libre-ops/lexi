Lexi
====

Lexi is a Linux Containers assistant for **LXD** and LXC 2.0+ (including 3.x), 
designed to make interacting with containers faster and easier for developers.

It enables different container configs to be stored locally per-project (in git repos for example).
This means project-specific configs can be easily shared across teams. 

It also wraps the standard CLI for LXC, greatly simplifying common commands and providing a few enhancements and additions. 

See **Usage** section below for more details.

## Setting up LXD/LXC

Lexi is intended to be used with an up-to-date installation of LXD and LXC. The recommended installation is via `snapd`.
If you have previously installed an older version of LXC (< 2.0) it's best to completely remove it first, then install LXD.

Some installation instructions for LXD are here: https://linuxcontainers.org/lxd/getting-started-cli/ \

##### TLDR version:
`$ sudo apt install snap`        # install snap \
`$ sudo snap install lxd`        # install LXD (includes LXC) \
`$ sudo lxd init`                # runs the wizard for initial LXD setup; hit enter for defaults
`$ sudo usermod -aG lxd $USER`   # Add current user to `lxd` group \
`$ su - $USER`                   # Pick up groups changes for current user (or log out and back in)

Searchable **LXD docs** are here: https://lxd.readthedocs.io/en/latest/

## Lexi Setup

- Clone this repo and run `$ sudo make install`
- Copy the example `/.lexi` directory into any project and edit the YAML files to taste
- Run `$ lexi setup` to create the network bridge used by `lexi`. This should only be needed once.

## Config Files

See [local config README](.lexi/README.md)

## Usage

Lexi provides an alternative CLI for `lxc`. All `lexi` commands are based on the standard `lxc` interface, with the following adjustments and extras:

##### Quick Commands

Instead of having to remember the specific image you use in the current project, or constantly having to remember and re-type 
the container name in each command, `lexi` pulls these from your local configs and handles it for you.

So for example, this command:
```
$ lxc launch <arbitrary-container-name> <specific-image>:<specific-version> -p <manually-created-profile>
``` 
becomes this: 
```
$ lexi launch
```

The same pattern above is applied to all common `lxc` commands, such as `start`,`stop`,`delete`, `info`, etc...

##### Nice Fallbacks

`lexi` also adds some helpful automated additions, for example;

If you run `$ lexi start` but the container hasn't been created yet, it will launch and start it automatically instead of just throwing a "not found" error and forcing you manually retype the commands to launch it.

`$ lexi delete` will use the `--force` flag by default, instead of throwing an error if the container is running and forcing you to manually retype the command with `--force`.

#### New Additions

If you're using an image that supports `cloud-init` (such as `ubuntu:18.04`), `lexi` will add your public SSH key to the container on launch, 
and provides the following command (which will directly connect via SSH to the container):

```
$ lexi ssh
```

This will connect using the `default_user` defined in your configs, but can take a second argument to override the default, eg:

```
$ lexi ssh root
```

To get a simpler shell in the container (without SSH) you can use:

```
$ lexi login
```

As with the `lexi ssh` (above), this logs in as the `default_user` defined in the local configs, but can be overridden by passing a specific user as the second argument.

```
$ lexi recreate
```

The above command will force-delete the current container and re-launch a fresh instance.

##### Snapshots

`$ lexi snapshot`, `$ lexi restore`, and `$ lexi delete-snapshot` will all default to using `snap0` if no snapshot is specified,
or can all take a snapshot name as second argument, eg:

```
$ lexy snapshot test-snapshot
```

You can use `$ lexi info` to check info on the current container, including a list of snapshots.

##### Static IPs

Defining a static local IP means that (for example) entries for the container can be easily added to Ansible projects.
See the [local config README](.lexi/README.md) for more details.

##### Standard Interface

The standard `lxc` commands are untouched and can still be used as normal for any complex operations, like editing network configurations.


--------

#### Acknowledgements

Inspired by https://github.com/coopdevs/devenv
