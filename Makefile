$(shell bash preprocess.sh)
TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard Calculator Preferences YouTube GitHub

# we only use objc methods when hooking swift
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = catppuccin

$(TWEAK_NAME)_FILES = Tweak_processed.xm integrations/SwiftUI.x integrations/SwiftUI.swift
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Werror
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = UIKitServices

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
