TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard YouTube Preferences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = catppuccin

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = UIKitServices

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
