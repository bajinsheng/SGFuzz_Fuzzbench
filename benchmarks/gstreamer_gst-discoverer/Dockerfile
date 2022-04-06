# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

FROM gcr.io/oss-fuzz-base/base-builder@sha256:6cd402d36992b46a9358a6cdbe2d5fa39953d422e739b9dcd3ac227d8ffb6d21
# Install the build dependencies

# install the minimum
ENV GIT_SSL_NO_VERIFY=1
RUN sed -i '/^#\sdeb-src /s/^#//' "/etc/apt/sources.list" && \
   apt-get update && \
   apt-get install -y build-essential pkg-config bison flex gettext \
    libffi-dev liblzma-dev libvorbis-dev libtheora-dev libogg-dev zlib1g-dev \
    python3-pip && \
   pip3 install meson==0.55.1 ninja==1.10.0.post2

COPY glib-2.64.2.tar.xz $SRC/

COPY state_variable.patch $SRC/
# Checkout all development repositories
#RUN for i in orc  gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav; do git clone --depth 1 --recursive https://anongit.freedesktop.org/git/gstreamer/$i $i; done
RUN \
  git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git gstreamer && \
  cd gstreamer && \
  git checkout -f 44bdad58f623e50a07476c0f40f8ff7543396f7c && \
  cd $SRC && \
  git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-base.git gst-plugins-base && \
  cd $SRC/gst-plugins-base && \
  git checkout -f f4a1428a6997658625d529b9db60fde812fbf1ee && \
  cd $SRC && \
  git clone https://gitlab.freedesktop.org/gstreamer/gst-ci.git gst-ci && \
  cd $SRC/gst-ci && \
  git checkout -f 8f8cd9ec4b940a01bfbc38be260f9cccfed9b7a4
ADD https://people.freedesktop.org/~bilboed/gst-discoverer_seed_corpus.zip $SRC

WORKDIR gstreamer
COPY build.sh $SRC/
ADD seeds /opt/seeds
COPY blocked_variables.txt /blocked_variables.txt
COPY blocked_variables_plugin.txt /blocked_variables_plugin.txt
