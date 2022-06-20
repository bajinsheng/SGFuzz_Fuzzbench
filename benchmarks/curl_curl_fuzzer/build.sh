#!/bin/bash -eu
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

# Save off the current folder as the build root.

#pushd $SRC/
#patch -p0 -i state_variable.patch
#popd

if [ "$fuzzer" = "sfuzzer" ]; then
    python3 /opt/State_machine_instrument.py $SRC/curl -b /blocked_variables.txt
fi
echo "" > $SRC/curl/lib/checksrc.pl
./ossfuzz.sh

# Use the local seed
rm -rf $OUT/*_seed_corpus.zip
cp -r /opt/seeds $OUT/

