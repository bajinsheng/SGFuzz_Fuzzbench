# Copyright 2016 Google Inc.
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
MAINTAINER dvyukov@google.com

RUN git clone https://github.com/curl/curl.git /src/curl
RUN git clone https://github.com/curl/curl-fuzzer.git /src/curl_fuzzer

# Use curl-fuzzer's scripts to get latest dependencies.
RUN $SRC/curl_fuzzer/scripts/ossfuzzdeps.sh

WORKDIR $SRC/curl_fuzzer
COPY build.sh $SRC/
COPY blocked_variables.txt /blocked_variables.txt
ADD seeds /opt/seeds