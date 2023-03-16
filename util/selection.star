# Copyright 2023 The ChromiumOS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Functions to generate device selection protobuf"""

load(
    "@proto//device_selection.proto",
    selection_pb = "chromiumos.feature_management.api.software",
)
load(
    "@proto//hwid_feature_requirement.proto",
    hwid_feature_pb = "chromiumos.feature_management.api.software",
)
load(
    "@proto//feature_management.proto",
    feature_pb = "chromiumos.feature_management.api.software",
)
load("//util/generate.star", "generate")

def _create_hwid_requirement(bit_locations, values):
    # Add checking: array size must match.
    return hwid_feature_pb.HwidProfile.EncodingRequirement(
        bit_locations = bit_locations,
        required_values = values,
    )

def _append_hwid_requirement(hwid_requirements, hwid_requirement):
    hwid_requirements.append(hwid_requirement)

def _create_hwid_profile(prefix, requirements):
    return hwid_feature_pb.HwidProfile(
        prefix = prefix,
        encoding_requirements = requirements,
    )

def _append_hwid_profile(hwid_profiles, hwid_profile):
    hwid_profiles.append(hwid_profile)

def _create_selection(feature_level, hwid_profiles, scope = feature_pb.Feature.SCOPE_DEVICES_0):
    return selection_pb.DeviceSelection(
        feature_level = feature_level,
        scope = scope,
        hwid_profiles = hwid_profiles,
    )

selection = struct(
    append_hwid_requirement = _append_hwid_requirement,
    create_hwid_requirement = _create_hwid_requirement,
    append_hwid_profile = _append_hwid_profile,
    create_hwid_profile = _create_hwid_profile,
    create_selection = _create_selection,
    generate = generate.generate_include,
)
