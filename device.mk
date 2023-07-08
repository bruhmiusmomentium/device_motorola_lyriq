#
# SPDX-License-Identifier: Apache-2.0
#

# Enable Virtual A/B OTA with vendor ramdisk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# API level
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_EXTRA_VNDK_VERSIONS := $(PRODUCT_SHIPPING_API_LEVEL)

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
