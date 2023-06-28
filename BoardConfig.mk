#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/lyriq

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
	boot \
	dtbo \
	product \
	system \
	system_ext \
	vbmeta \
	vbmeta_system \
	vendor \
	vendor_boot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lyriq
TARGET_NO_BOOTLOADER := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/configs/config.fs

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
TARGET_KERNEL_CLANG_COMPILE := true

# cmdline
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.bootdevice=11270000.ufshci
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9126805504

BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 9122611200 # ( BOARD_SUPER_PARTITION_SIZE - 4194304) 4MiB overhead

BOARD_USES_METADATA_PARTITION := true

BOARD_MAIN_PARTITION_LIST := system_ext product vendor system

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# ODM is vendor/odm
TARGET_COPY_OUT_ODM = vendor/odm

# Vendor
BUILD_WITHOUT_VENDOR := true

# Userdata
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

# Platform
TARGET_BOARD_PLATFORM := mt6893
BOARD_HAS_MTK_HARDWARE := true

# Screen density
TARGET_SCREEN_DENSITY := 400

# Recovery
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_USES_MKE2FS := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6893

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
