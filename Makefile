$(shell bash preprocess.sh)
TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard YouTube Preferences GitHub

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = catppuccin

$(TWEAK_NAME)_FILES = Tweak_processed.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-module-import-in-extern-c
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = UIKitServices

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
