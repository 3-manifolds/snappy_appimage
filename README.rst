SnapPy AppImage
================

This repository contains tools for creating an AppImage for a SnapPy app on linux.

The starting point is a tarball of a relocatable Python root directory as created by
py_appimage. That tar archive is copied to a manylinux Docker image and unpacked.
SnapPy and its dependencies are installed in the root directory using its internal
pip.  The resulting expanded root is archived with tar and copied from the Docker
container back to the host system where it is used to create the squashfs file for
an AppImage that runs SnapPy. 
