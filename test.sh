#!/bin/bash

password='encrypt'
layerfile='out.tar.xz.enc'

source tarlayer.sh

# Start the process of making a layer
tarlayer_init_layer layer

# Add some files to it
tarlayer_add_file ${layer} /etc/fstab /etc/fstab 0755
tarlayer_add_file ${layer} test.sh /var/lib/test.sh
tarlayer_add_file ${layer} /etc/resolv.conf /home/daniel/resolv.conf

# Save the layer to a tar file
tarlayer_save_layer ${layer} ${layerfile} ${password}

# List the contents
tarlayer_list_contents ${layerfile} ${password}

