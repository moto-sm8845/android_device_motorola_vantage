#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import subprocess
from os import path

from extract_utils.args import (
    parse_args,
)
from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_star import extract_star_firmware
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    lineage_scripts_dir,
)

namespace_imports = [
    'device/motorola/sm8845-common',
    'vendor/motorola/sm8845-common',
    'hardware/qcom-caf/sm8850',
    'hardware/qcom-caf/wlan',
    'hardware/motorola',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/display',
]

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
}

blob_fixups: blob_fixups_user_type = {
    (
        'vendor/bin/hw/vendor.qti.camera.provider-service_64',
        'vendor/lib64/camx.provider-impl.so',
    ): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v34.so'),
    # Built against the older camera AIDL generations (offlinecamera V2, which
    # reexports camera.device-V2, and allocator V1); the in-tree camx/gralloc
    # stack builds camera.device-V3 and allocator-V2, and both audio/camera
    # graphs must not carry two versions of the same aidl_interface.
    'vendor/lib64/vendor.qti.hardware.camera.offlinecamera-service-impl.so': blob_fixup()
        .replace_needed('vendor.qti.hardware.camera.offlinecamera-V2-ndk.so', 'vendor.qti.hardware.camera.offlinecamera-V3-ndk.so')
        .remove_needed('android.hardware.graphics.allocator-V1-ndk.so'),
    'vendor/lib64/camera/components/com.qti.node.dewarp.so': blob_fixup()
        .remove_needed('android.hardware.graphics.allocator-V1-ndk.so'),
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    r'(bootloader|radio)\.img': extract_star_firmware,
}

module = ExtractUtilsModule(
    'vantage',
    'motorola',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    extract_fns=extract_fns,
    add_firmware_proprietary_file=True,
    add_generated_carriersettings=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8845-common', module.vendor
    )
    utils.run()

    args = parse_args()
    if args.source and args.source != 'adb':
        source = args.source[0] if isinstance(args.source, list) else args.source
        info_script = path.join(lineage_scripts_dir, 'motorola', 'info.sh')
        if path.isfile(info_script):
            subprocess.run([info_script, source])
