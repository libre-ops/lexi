## Local Configuration Files

See https://github.com/libre-ops/lexi for info on `lexi`.

The files in `/.lexy` can be used to define container configs per-project. 

Container names and static IPs should be unique (globally), and the default IP range is `10.10.100.2-254`,
with `10.10.100.1` as the gateway.

#### container.yml

Defines the primary configs for the container, such as container name, image, static IP.

The four required variables are:
- **container:** name of the container for this project
- **image:** image to be used, eg: `ubuntu:18.04`
- **default_user:** default user added to container at launch. Used by `lexi ssh` and `lexi login`
- **container_ip:** static local IP for the container. Should be a unique IP in the `10.10.100.2-254`
range, unless using an alternate default network bridge for the project (see below). 

Optional variables: 
- **ssh_key:** pulls in `~/.ssh/id_rsa.pub` by default. Can be set to a string, eg: `ssh-rsa AAAAB3 ...`
- **network_name:** name of the default network bridge used by Lexi. Defaults to `lexibr0`.
- **network_address:** IP for the default network bridge used by Lexi. Defaults to `10.10.100.1`
- **host_share_path:** define a local path on the host to be mounted in the guest, eg: `/home/user/my-local-project`
- **guest_share_path:** define a destination path on the guest for shared mount, eg: `/home/lexi/project`

#### network.yml

Uses `cloud-init` (for enabled images) to define the network interface settings for the container. 

These shouldn't need to be edited in most cases, but can be used to add additional NICs or change the defaults.

#### users.yml

Uses `cloud-init` (for enabled images) to define users, set sudo permissions, add SSH keys, set base packages, etc. during container launch.

## Further Reading

For complete and searchable LXD docs, see: https://lxd.readthedocs.io/en/latest

For LXD `cloud-init` configuration, see: https://lxd.readthedocs.io/en/latest/cloud-init/

For `cloud-init` docs and examples, see: https://cloudinit.readthedocs.io/en/latest/topics/examples.html 
