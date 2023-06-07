#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/lyriq

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    vendor_boot \
    system \
    system_dlkm \
    system_ext \
    product \
    vendor \
    vendor_dlkm \
    odm \
    odm_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a78

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lyriq
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_BOOT_HEADER_VERSION := 3

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_OFFSET := 0x40080000
BOARD_RAMDISK_OFFSET := 0x51100000
BOARD_KERNEL_TAGS_OFFSET := 0x47c80000
BOARD_DTB_OFFSET := 0x0000000047c80000

BOARD_MKBOOTIMG_ARGS :=	--header_version $(BOARD_BOOT_HEADER_VERSION) \
	--kernel_offset $(BOARD_KERNEL_OFFSET) \
	--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
	--tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
	--dtb_offset $(BOARD_DTB_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_KERNEL_CONFIG := k6891v1_64_k419_d1180_defconfig ext_config/moto-k6891v1_64_k419_d1180.config ext_config/moto-k6891v1_64_k419_d1180-lyriq.config ext_config/delta_lyriq.config
TARGET_KERNEL_SOURCE := kernel/motorola/lyriq

TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc

# cmdline
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.bootdevice=11270000.ufshci
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 9126805504

BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_dlkm \
    system_ext \
    product \
    vendor \
    vendor_dlkm \
    odm \
    odm_dlkm

BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 9122611200 # ( BOARD_SUPER_PARTITION_SIZE - 4194304) 4MiB overhead

BOARD_USES_METADATA_PARTITION := true

BOARD_MAIN_PARTITION_LIST := $(BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST)

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Userdata
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

# Platform
TARGET_BOARD_PLATFORM := mt6893

# Display
TARGET_SCREEN_DENSITY := 400

# Recovery
TARGET_NO_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
