# Jiri and CIPD in a Docker container
This project brings [Jiri](https://fuchsia.googlesource.com/jiri/) and CIPD tools from Google, and required dependencies, into a Debian-based Docker image, specifically, to download the [Google Fuchsia](https://fuchsia.dev/) source tree, as well for building it.

## Usage
You need to define the Google Fuchsia source tree and [Ccache](https://ccache.dev/) persistent host-side directories:

```
docker run -v <ccache dir>:/root/.cache/ccache -v <fuchsia dir>:/fuchsia amitie10g/google-fuchsia-jiri
```

The default command is ``shell`` that brings Bash interactive shell. Other command are:

* ``update`` updates the Fuchsia source tree.<br>It first runs ``cipd auth-login`` in order to get the source that require authentication, so you need an interactive shell.

* ``build`` builds Fuchsia. It runs:
  * ``fx set workstation.x64 --with //bundles:kitchen_sink --ccache`` 
  * ``fx metrics disable``
  * ``fx build``

* ``install`` install Fuchsia into a device<br>You need to specify the device at environment (defined at the Dockerfile).

## Environment variables
* ``FUCHSIA_DIR`` the Fuchsia root directory (defaults ``/fuchsia``)
* ``PRODUCT`` the product target (defaults ``workstation``)
* ``BOARD`` the board/arch target (defaults ``x64``)
* ``BUNDLE`` the bundle you want to build (defaults ``kitchen_sink``)
* ``FX_METRICS`` if you want to enable or disable metrics (defaults ``disable``)
* ``DISK_IMG`` the disk image, if you want to install into an image rather than a block device (defaults ``/fuchsia/disk.img``)
* ``TARGET_DEVICE`` the block device you will flash (defaults ``$DISK_IMG`` or ``/dev/fuchsia``, a loop device createdusing the ``$DISK_IMG``)

## Licensing
* The scripts contained in this project are released into the Public domain (Unlicense).
* The Jiri executable is licensed under the 3-clause BSD License.
