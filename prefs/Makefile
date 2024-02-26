TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = prefs

prefs_FILES = ctpiosRootListController.m
prefs_FRAMEWORKS = UIKit
prefs_PRIVATE_FRAMEWORKS = Preferences
prefs_INSTALL_PATH = /Library/PreferenceBundles
prefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
