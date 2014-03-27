# Product-makefile directives applicable for ALL Android
# devices that Intel may build. Be careful what you put here,
# it may be more appropriate to make your change in a board
# or product level file.

# Base AOSP configuration. Phone products will want to also
# inherit aosp_base_telephony.mk. At the moment we can't do
# this from a mix-in.
$(call inherit-product, build/target/product/aosp_base.mk)

# Base directory for mixin implementations
$(call add-mixin-basedir, device/intel/mixins)

LOCAL_PATH := device/intel/common

PRODUCT_MANUFACTURER := Intel
PRODUCT_BRAND := Intel

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip \
	$(LOCAL_PATH)/init.common.rc:root/init.common.rc \
	$(LOCAL_PATH)/init.recovery.common.rc:root/init.recovery.common.rc \
	$(LOCAL_PATH)/keylayout/AT_Translated_Set_2_keyboard.kl:system/usr/keylayout/AT_Translated_Set_2_keyboard.kl \
	$(LOCAL_PATH)/preferred-apps/browser.xml:system/etc/preferred-apps/browser.xml \

#For user build, enable the adb secure feature
ifeq ($(TARGET_BUILD_VARIANT),user)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

#Adding AndroidTerm app and shared library for debugging
ifneq ($(TARGET_BUILD_VARIANT),user)
$(call inherit-mixin, superuser, cyanogen)
$(call inherit-mixin, debug-tools, all)
PRODUCT_PACKAGES += AndroidTerm libjackpal-androidterm4
# Crash Report
$(call inherit-mixin, crashreport, ap_only)
endif
