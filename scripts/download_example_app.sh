source ./download.sh
source ../.env

mkdir ../services/example-app ../services/example-app/static 2> /dev/null

install_release Fysiksektionen/example-app build.tar.gz ../services/example-app/static/ $EXAMPLE_APP_VERSION
