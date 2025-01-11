SNAPPY_VERSION=3.2

all: Setup SnapPyApp

.PHONY: Setup SnapPyApp

Setup:
	bash bin/fetch_app_root.sh
	bash bin/install_snappy.sh
	rm -rf app_root
	tar xfz app_root_final.tgz

SnapPyApp:
	cp app_files/* app_root
	mv app_root SnapPy-${SNAPPY_VERSION}-x86_64.AppDir
	bin/appimagetool SnapPy-${SNAPPY_VERSION}-x86_64.AppDir
