#!/bin/bash -eu

# Patch
if [ "$fuzzer" = "sfuzzer" ]; then
    python3 /opt/State_machine_instrument.py $SRC/gstreamer -b /blocked_variables.txt
    python3 /opt/State_machine_instrument.py $SRC/gst-plugins-base -b /blocked_variables_plugin.txt 6000
fi

$SRC/gst-ci/fuzzing/build-oss-fuzz.sh

# Use the local seed
rm -rf $OUT/*_seed_corpus.zip
cp -r /opt/seeds $OUT/
