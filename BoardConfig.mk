# Common BoardConfig.mk for *ALL* Intel projects.
# Be very careful what you put in here; it may more
# properly belong in a platform or product-specifc
# BoardConfig.mk, or a mix-in

LOCAL_PATH := device/intel/common

# Common recovert library containing useful edify commands and
# library functions. Additional commands implemented in platform-
# specific libraries
TARGET_RECOVERY_UPDATER_LIBS += libcommon_recovery

# Location of kernel headers for all Intel projects
TARGET_BOARD_KERNEL_HEADERS := $(LOCAL_PATH)/kernel-headers

# Sets ro.product.board
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_PRODUCT)

# set default console log level
KERNEL_LOGLEVEL ?= 5

BOARD_KERNEL_CMDLINE += \
	loglevel=$(KERNEL_LOGLEVEL) \
	androidboot.hardware=$(TARGET_PRODUCT)

TARGET_CPU_SMP := true

# If signing kernel modules, use the testing BIOS DB key
# Production builds will re-sign them via sign_target_files_apks.
# Just use the testkey that AOSP provides
TARGET_MODULE_KEY_PAIR := device/intel/common/testkeys/DB
TARGET_MODULE_GENKEY := device/intel/common/testkeys/kernel.x509.genkey

# customize the malloced address to be 16-byte aligned.
# Copied from the generic_x86 config.
BOARD_MALLOC_ALIGNMENT := 16

# Default bitness for the Linux kernel and UEFI executables.
# Can be overridden in the product configuration if necessary
TARGET_KERNEL_ARCH := x86_64
TARGET_UEFI_ARCH := x86_64

$(call add-path-map, stlport:external/stlport/stlport \
       libxml2:external/libxml2/include \
       tinyalsa:external/tinyalsa/include)

DEVICE_PACKAGE_OVERLAYS += device/intel/common/overlay
