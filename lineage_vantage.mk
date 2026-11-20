#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from vantage device
$(call inherit-product, device/motorola/vantage/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_vantage
PRODUCT_DEVICE := vantage
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola signature

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="vantage_g-user 17 A171SWVH.21-16-16-2 a6263-e6f3a9 release-keys" \
    BuildFingerprint=motorola/vantage_g/vantage:17/A171SWVH.21-16-16-2/a6263-e6f3a9:user/release-keys \
    DeviceProduct=vantage_g
