PYTHON_VERSION=3.14
RELEASE_TAG=v1.1
ARCHIVE=app_root-${PYTHON_VERSION}.tgz
HASH_FILE=app_root-${PYTHON_VERSION}.sha256
DOWNLOAD=https://github.com/3-manifolds/py_appimage/releases/download
ARCHIVE_URL=${DOWNLOAD}/${RELEASE_TAG}/${ARCHIVE}
HASH_URL=${DOWNLOAD}/${RELEASE_TAG}/${HASH_FILE}
if ! [ -e ${ARCHIVE} ]; then
    curl -L -O ${ARCHIVE_URL}
fi
if ! [ -e ${HASH_FILE} ]; then
    curl -L -O ${HASH_URL}
fi
ACTUAL_HASH=`sha256sum ${ARCHIVE}`
HASH=`cat ${HASH_FILE}`
if [ "${HASH}" != "${ACTUAL_HASH}" ]; then
    echo Invalid sha256 hash
    exit 1
fi

