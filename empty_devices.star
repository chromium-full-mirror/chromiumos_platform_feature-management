#!/usr/bin/env lucicfg generate
# Copyright 2023 The ChromiumOS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""File required by the Makefile, does not add any selections."""

load("//util/proto.star", "protos")
load(
    "@proto//device_selection.proto",
    selection_pb = "chromiumos.feature_management.api.software",
)
load("//util/selection.star", "selection")

# Output filename has to match filename.
selection.generate(selection_pb.SelectionBundle(selections = []), "empty_devices.binary")
