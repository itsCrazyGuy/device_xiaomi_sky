#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/sky

# Configure core_64_bit.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Configure full_base_telephony.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit common Infinity-X configurations
$(call inherit-product, vendor/infinity/config/common_full_phone.mk)

$(call inherit-product, vendor/infinity/config/BoardConfigReservedSize.mk)

# Inherit device configurations
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/sky/sky-vendor.mk)

# Infinity-X Flags
INF_BUILD := true
RUM_NAME := lineage
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_BOOT_ANIMATION_RES := 1080
INFINITY_MAINTAINER := "TeamToplexy"
WITH_GAPPS := true
TARGET_SHIPS_FULL_GAPPS := true
USE_PIXEL_CHARGER := true

PRODUCT_SYSTEM_PROPERTIES += \
    ro.infinity.soc=Snapdragon_4_Gen_2 \
    ro.infinity.battery=5000mAh \
    ro.infinity.display=1080x2460@90Hz \
    ro.infinity.camera=50MP+8MP+2MP \
    ro.product.marketname=sky

DEVICE_PACKAGE_OVERLAYS += \
	$(DEVICE_PATH)/overlay-lineage

## Device identifier
PRODUCT_DEVICE := sky
PRODUCT_NAME := infinity_sky
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 23076RN4BI
PRODUCT_MANUFACTURER := Xiaomi

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
