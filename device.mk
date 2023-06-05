#
# SPDX-License-Identifier: Apache-2.0
#

# API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
