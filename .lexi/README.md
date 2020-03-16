## Local Configuration Files

The files in `/.lexy` can be used to define container configs per-project. 

Container names and static IPs should be unique (globally), and the default IP range is `10.10.100.2-254`,
with `10.10.100.1` as the gateway.

#### container.yml

Defines the primary configs for the container, such as container name, image, static IP.

#### network.yml

Uses `cloud-init` (for enabled images) to define the network interface settings for the container. Shouldn't need to be edited in most cases.

#### users.yml

Uses `cloud-init` (for enabled images) to define users, set sudo permissions, add SSH keys, set base packages, etc. during container launch. 

## Further Reading

For complete and searchable LXD docs, see: https://lxd.readthedocs.io/en/latest

For LXD `cloud-init` configuration, see: https://lxd.readthedocs.io/en/latest/cloud-init/

For `cloud-init` docs and examples, see: https://cloudinit.readthedocs.io/en/latest/topics/examples.html 
