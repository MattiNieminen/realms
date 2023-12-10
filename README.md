# Realms

Realms is a tool for setting up isolated shell environments and installing
software and configuration for them.

## Why?

As I am working on multiple projects using the same computer, I had problems
with conflicting software installations and configuration. Two projects could
use the same software but require different versions, configurations or even
licenses. Traditional package managers don't allow installing packages on an
isolated manner.

My first attempt to solve this was based on Docker. The solution worked but had
some issues:
 * Docker was used the way it was never meant to be used. The isolated
   environments were containers that shared users, networking, parts of the
   home directory and environment variables with the host.
 * Software with graphical user interfaces only worked on Linux by mounting X
   or Wayland socket from host to container. GUI software on macOs was not
   supported.
 * Small performance overhead.

My second attempt was based on Nix. This solution fixed the problem with GUI
software macOs but had other issues:
 * Nix does not support other shells except `bash` inside `nix-shell`.
 * A lot of software installers just add a small shell scripts to `PATH` that
   download the actual binaries to home directory. As Nix environments share
   home directory, the environments were not truly isolated.

I figured I could write a small script that
 * Sets up environment specific `$HOME`.
 * Installs environment specific dots.
 * Installs packages using Nix.
 * Starts the isolated environments using Nix while still allowing other shells
   besides `bash`.

This solution results in real isolated environments, which I decided to call
Realms.

Some issues still remain:
 * Nix is also used the way it was not meant to be used.
 * Installing Nix is (or at least was) unreliable.

## Usage

The packages are installed using Nix, so it must be installed first. As
mentioned, installing Nix the official way is unreliable, so prefer using
[The Determinate Nix Installer](https://determinate.systems/posts/determinate-nix-installer).

Then, create a symbolic link for running the environments from anywhere:

```bash
sudo ln -s "$(pwd)/realms.sh" /usr/local/bin/realms
```

After linking the script, use `realms -h` to test the installation.

## Creating new environments

Each script in [environments](environments) defines an environment using a set
of local variables:

 * `shell`: the shell that is started inside the environment.
 * `packages`: Nix packages that will be installed into the environment.
 * `dots`: Dots that will be installed into the environment.

See existing [environments](environments) for examples.

## Creating new dots

Dots are defined as `install.sh` scripts in their own directories under
[dots](dots) directory. The directory can also include other files that the
installation script may require. In those cases, the installation script should
copy the files to their correct locations. The installation script can also
create or download files, edit existing files or simply run commands.

The installation script will be run when installing the environment. The
working directory is set to its own directory and `$HOME` is pointing to the
new environment.

The installation scripts should be idempotent and support reinstalling.

## Operating system installation

Operating system installation guides are available in
[os-installation-guides](os-installation-guides) directory for convenience.
