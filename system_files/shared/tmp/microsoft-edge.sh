#!/usr/bin/env bash

set -ouex pipefail

# Can be "stable", "beta" or "dev"
RELEASE_CHANNEL="${EDGE_RELEASE_CHANNEL:-stable}"

echo "Installing Edge"

# On libostree systems, /opt is a symlink to /var/opt,
# which actually only exists on the live system. /var is
# a separate mutable, stateful FS that's overlaid onto
# the ostree rootfs. Therefore we need to install it into
# /usr/lib/microsoft instead, and dynamically create a
# symbolic link /opt/microsoft/msedge => /usr/lib/microsoft/msedge upon
# boot.

# Prepare staging directory
mkdir -p /var/opt/microsoft # -p just in case it exists
# for some reason...

# Setup repo
wget https://packages.microsoft.com/yumrepos/edge/config.repo -O /etc/yum.repos.d/edge.repo

# Import signing key
rpm --import https://packages.microsoft.com/keys/microsoft.asc && \

# Now let's install the package.
rpm-ostree install microsoft-edge-${RELEASE_CHANNEL}

# And then we do the hacky dance!
mkdir -p /usr/lib/microsoft
mv /var/opt/microsoft/msedge /usr/lib/microsoft/msedge # move this over here

# Create a symlink /usr/bin/microsoft-edge-${RELEASE_CHANNEL} => /opt/microsoft/msedge/microsoft-edge-${RELEASE_CHANNEL}
#rm /usr/bin/microsoft-edge-${RELEASE_CHANNEL}
#ln -s /opt/microsoft/msedge/microsoft-edge-${RELEASE_CHANNEL} /usr/bin/microsoft-edge-${RELEASE_CHANNEL}

# Register path symlink
# We do this via tmpfiles.d so that it is created by the live system.
cat >/usr/lib/tmpfiles.d/microsoft-edge.conf <<EOF
L  /opt/microsoft/msedge  -  -  -  -  /usr/lib/microsoft/msedge
EOF