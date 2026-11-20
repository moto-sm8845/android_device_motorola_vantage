#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Boot animation
TARGET_SCREEN_HEIGHT := 3200
TARGET_SCREEN_WIDTH := 1440

# Screen
TARGET_SCREEN_DENSITY := 480

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 480dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

BOARD_SHIPPING_API_LEVEL := 36
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Inherit from motorola sm8845-common
$(call inherit-product, device/motorola/sm8845-common/common.mk)

# Overlay
PRODUCT_PACKAGES += \
    FrameworksResDevice \
    LineageSystemUIDevice \
    ProductFrameworksResDevice \
    SettingsResDevice \
    SystemUIResDevice

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf

# Dex-pre-opt exclusions
$(call add-product-dex-preopt-module-config,MotoSignatureApp,disable)

# Init
PRODUCT_PACKAGES += \
    init.mmi.overlay.rc

# LiveDisplay
$(call soong_config_set_bool,livedisplay_sysfs,enable_af,true)

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Tag

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dn/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dn/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

# Properties
PRODUCT_PACKAGES += \
    hardware.sku.XT2603-1.prop \
    hardware.sku.XT2603-2.prop \
    hardware.sku.XT2603-3.prop \
    hardware.sku.XT2603-4.prop

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-vantage-game-perf.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-vantage.conf

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.default

$(call soong_config_set,lineage_powershare,powershare_path,/sys/class/power_supply/wireless/device/tx_mode)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# VINTF
ODM_MANIFEST_SKUS += dn n
ODM_MANIFEST_DN_FILES := \
    $(LOCAL_PATH)/vintf/manifest_dn.xml
ODM_MANIFEST_N_FILES := \
    $(LOCAL_PATH)/vintf/manifest_n.xml \
    device/motorola/sm8845-common/vintf/manifest_ss.xml

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/vantage/vantage-vendor.mk)
