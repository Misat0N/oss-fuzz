#!/bin/bash -eu
# Copyright 2024 Google LLC
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

set -o pipefail

: "${LDFLAGS:=}"

cp /src/inihfuzz.c .

# Compile the fuzzer binary for oss-fuzz infrastructure.
$CC $CFLAGS -I. -c ini.c -o ini.o
$CC $CFLAGS -I. -c inihfuzz.c -o inihfuzz.o
$CXX $CXXFLAGS $LDFLAGS inihfuzz.o ini.o $LIB_FUZZING_ENGINE -o $OUT/inihfuzz

# 种子语料
zip -j $OUT/inihfuzz_seed_corpus.zip tests/*.ini
