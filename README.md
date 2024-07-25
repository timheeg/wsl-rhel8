# wsl-rhel8

RHEL8 image for to use as WSL2 development distribution.

This effort is a result of corrupted build mounts in dev containers.

* <https://code.visualstudio.com/blogs/2020/07/01/containers-wsl>
* <https://www.docker.com/blog/docker-desktop-wsl-2-best-practices/>

## Build locally

Run the `tools/dev/builds.sh` bash script.

See `tools/dev/builds.sh --help` for details.

You can use the Git Bash terminal that comes with Git for Windows or you could
try your default WSL distribution.

## RHEL Subscription

This image is based on the RHEL8 UBI image and requires a RHEL subscription,
such as a free developer subscription.

The WSL container requires you register your subscription and assumes you have
an environment variable named `RHEL8_ORG` defined with your organization and
an environment variable named `RHEL8_ACTIVATION_KEY` defined with your
activation key identifier.

## Development Usage

Once the development image is available in WSL, enable WSL integration in Docker
Desktop settings for this specific `wsl-rhel8` distro under
`Settings > Resources > WSL Integration > Enable integration with additional distros`.

You may run this script repeatedly to wipe the existing distro and replace it
with a clean build. This script removes the distribution if it already exists.

Launch your new wsl dev env with `wsl -d wsl-rhel8` or by using the `wsl-rhel8`
shortcut added to `Terminal`.

### Develop in VS Code

Within the `wsl-rhel8` env, simply navigate to the desired project directory and
launch `code .`.

On the first launch, vscode will automatically use `wget` to download and
install vscode server in the WSL image.

From there, you can cleanly build your dev containers from within the WSL env.

### Git Configuration

User specific `.gitconfig` can be problematic across various users. Instead of
copying the existing user `.gitconfig` into the container, a temporary file is
created with the `user.name` and `user.email` from the host machine and seeded
in the WSL image, then modified to ensure core standard configurations including
windows git credential manager support.

This means that when you enter your git user name and token in windows, that
credential manager is accessible from within the WSL distro making cloning
simple and seamless from within the WSL env.
