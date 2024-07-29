#! /bin/zsh

# This script downloads prepared files from a github realease.
#
# The parameters are:
# 	$1: The github repository on the format OrganizationOrUser/Repository
# 	$2: Either the name of the release file to be downloaded, or source if the source files should be downloaded.
# 	$3: The location the files should be downloaded to. Often ../services/serviceName
# 	$4: The realease version to be downloaded

function download_release {
	local tdir=$(mktemp -d -t build-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)
	
	if [ $2 = "source" ]; then 
		gh release download -R $1 -A tar.gz -D $tdir $4;
	else 
		gh release download -R $1 -p $2 -D $tdir $4;
	fi

	tar -xf $tdir/* -C $3
	rm -rf $tdir

	# Move out of extra directory...
	if [ $2 = "source" ]; then 
		local dir_to_remove=$(ls $3)
		mv -f $3/$dir_to_remove/.* $3/$dir_to_remove/* $3 2>/dev/null
		rmdir $3/$dir_to_remove
	fi
}

function install_release {
	mkdir $3 2> /dev/null
	rm -r $3/* 2> /dev/null
	download_release $1 $2 $3 $4
}
