#!/usr/bin/env lucicfg generate
# Copyright 2023 The ChromiumOS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

load("//util/proto.star", "protos")
load(
    "@proto//feature_management.proto",
    feature_pb = "chromiumos.feature_management.api.software",
)
load("//util/feature.star", "feature")

# Feature that is always true on any device.
def basic_config():
    """Defines the Wallpaper config.

    Returns: Feature object.
    """
    return feature.create_feature(
        name = "Basic",
        contacts = [ "gwendal@google.com" ],
        feature_level = 0,
        usages = [ feature_pb.Feature.USAGE_LOCAL ],
    )

def all_features():
    """Returns all the configs in the file.

    Returns: [feature_pb].
    """
    return [
        basic_config(),
    ]

feature.generate(feature_pb.FeatureBundle(features = all_features()), "features.binary")
