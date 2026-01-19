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

# Inherit common rom configurations
$(call inherit-product, vendor/euclid/config/common_full_phone.mk)

$(call inherit-product, vendor/euclid/config/BoardConfigReservedSize.mk)

# Inherit device configurations
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/sky/sky-vendor.mk)

EOS_BUILD := true
DEVICE_PACKAGE_OVERLAYS += \
	$(DEVICE_PATH)/overlay-lineage
WITH_GMS_COMMS_SUITE := true
TARGET_INCLUDE_PIXEL_LAUNCHER := true
TARGET_PREBUILT_LAWNICONS := true
TARGET_BUILD_DOTGALLERY := true
EUCLID_MAINTAINER := 𝚂αяιм_𝚁αѕσσℓ
EUCLID_DEVICE := sky
EUCLID_PROCESSOR := Snapdragon™_4_Gen_2

PRODUCT_DEVICE := sky
PRODUCT_NAME := euclid_sky
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 23076RN4BI
PRODUCT_MANUFACTURER := Xiaomi

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
