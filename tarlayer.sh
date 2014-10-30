#  _             _                       
# | |_ __ _ _ __| | __ _ _   _  ___ _ __ 
# | __/ _` | '__| |/ _` | | | |/ _ \ '__|
# | || (_| | |  | | (_| | |_| |  __/ |   
#  \__\__,_|_|  |_|\__,_|\__, |\___|_|   
#                        |___/           
#
# Author: Daniel Hall <daniel@danielhall.me>
# Purpose: Builds extra layers for Docker files that can be installed at runtime

# Makes a basic layer with nothing in it
# Args:
#   1. The variable name to put the temp layer filename in
function tarlayer_init_layer() {
    local __layer=$1
    local tempfile=$(mktemp)
    tar -cvf ${tempfile} --files-from /dev/null
    eval $__layer="'$tempfile'"
}

# Finalizes the layer
# Args:
#   1. The location of the layer temp file
#   2. The filename of the output layer
#   3. The password to encrypt the layer with
function tarlayer_save_layer() {
    local layer="$1"
    local savefile="$2"
	local password="$3"

    # Compress + encrypt the file
    xz -c ${layer} | openssl enc -aes-256-cbc -e -out ${savefile} -pass pass:${password}

    # Remove the old file
    srm ${layer}
}

# Add file to layer
# Args:
#   1. The location of the layer temp file
#   2. The file to add to the layer
#   3. The location of the file inside the layer
function tarlayer_add_file() {
    local layer=$1
    local file=$2
    local loc=$3

    # Add the file to the tar file at the right location
    tar --absolute-names \
		--append \
		--file=${layer} \
		--transform="s|.*|${loc}|" \
		--add-file="${file}"
}

# Lists the contents 
# Args:
#   1. The location of the layer file
#   2. The password used to encrypt the layer
function tarlayer_list_contents() {
	local layerfile=$1
	local password=$2

	openssl enc -aes-256-cbc -d -in ${layerfile} -pass pass:${password} | xz --decompress --stdout - | tar --absolute-names -tv
}

