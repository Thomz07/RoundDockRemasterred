ARCHS = arm64 arm64e

TARGET := iphone:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RoundDockRemasteredPreferences

RoundDockRemasteredPreferences_FILES = ROURootListController.m
RoundDockRemasteredPreferences_FRAMEWORKS = UIKit
RoundDockRemasteredPreferences_PRIVATE_FRAMEWORKS = Preferences
RoundDockRemasteredPreferences_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
RoundDockRemasteredPreferences_LIBRARIES = colorpicker
RoundDockRemasteredPreferences_INSTALL_PATH = /Library/PreferenceBundles
RoundDockRemasteredPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
