#!/bin/bash

source tarlayer.sh

# Start the process of making a layer
initLayer layer

# Add some files to it
addFile $layer /etc/fstab /etc/fstab
addFile $layer test.sh /var/lib/test.sh
addFile $layer /etc/resolv.conf /home/daniel/resolv.conf

# Save the layer to a tar file
saveLayer $layer test.tar.xz

