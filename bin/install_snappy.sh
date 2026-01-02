#!/usr/bin/bash
PYTHON_VERSION=3.14
set -e

docker run -d -t --name builder quay.io/pypa/manylinux2014_x86_64:latest
docker cp app_root-${PYTHON_VERSION}.tgz builder:/tmp

# Unpack app root
docker exec -w /tmp builder tar xfz app_root-3.14.tgz

# Install build dependencies
docker exec -w /tmp builder app_root/bin/python3 -m pip install \
       setuptools wheel cython sphinx sphinx-rtd-theme pyx

# Install knot_floer_homology
docker exec -w /tmp builder git clone https://github.com/3-manifolds/knot_floer_homology
docker exec -w /tmp/knot_floer_homology builder /tmp/app_root/bin/python3 -m pip install .

# Install PLink
docker exec -w /tmp builder git clone https://github.com/3-manifolds/PLink
docker exec -w /tmp/PLink builder /tmp/app_root/bin/python3 -m pip install .

# Install Spherogram
docker exec -w /tmp builder git clone https://github.com/3-manifolds/Spherogram
docker exec -w /tmp/Spherogram builder /tmp/app_root/bin/python3 -m pip install .

# Install SnapPy
docker exec -w /tmp builder git clone https://github.com/3-manifolds/SnapPy
docker exec -w /tmp/SnapPy builder /tmp/app_root/bin/python3 setup.py pip_install
docker exec -w /tmp/SnapPy builder /tmp/app_root/bin/python3 \
       doc_src/build_doc_add_to_wheel.py dist
docker exec -w /tmp/SnapPy builder /tmp/app_root/bin/python3 -m pip install \
       --force-reinstall --no-index --no-cache-dir --no-deps --find-links \
       ./dist snappy
docker exec -w /tmp builder app_root/bin/python3 -m pip install snappy_15_knots
docker exec -w /tmp builder tar cfz app_root_final.tgz app_root
docker cp builder:/tmp/app_root_final.tgz .
docker stop builder
docker container rm builder
