# tarlayer

This script is allows you to extract an encrypted tarball inside a Docker image to provide extra files. An encrypted 'layer' if you will.

# Creating

See the `test.sh` file, this creates a quick encrypted tarball.

# Extracting

You can either source the file then use the `tarlayer_extract` function, or execute the script with the same arguments. For example to extract the file created by the test example do this:

    ./tarlayer.sh out.tar.xz.enc encrypt

Note that this command will try to extract the data to `/` so you probably want to run it in a Docker container.

