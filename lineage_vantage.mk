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
    BuildDesc="vantage_g-user 16 WWV36HV-16-ST1.1 4548c release-keys" \
    BuildFingerprint=motorola/vantage_g/vantage:16/WWV36HV-16-ST1.1/4548c:user/release-keys \
    DeviceProduct=vantage_g
