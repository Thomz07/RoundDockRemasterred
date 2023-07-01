ARCHS = arm64 arm64e

TARGET := iphone:14.5

INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RoundDockRemastered

RoundDockRemastered_FILES = Tweak.x
RoundDockRemastered_CFLAGS = -fobjc-arc
RoundDockRemastered_EXTRA_FRAMEWORKS += Cephei
RoundDockRemastered_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += rounddockremasteredpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
