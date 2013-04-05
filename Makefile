#SDKVERSION=6.0
#GO_EASY_ON_ME = 1
export ARCHS=armv7

include theos/makefiles/common.mk

TWEAK_NAME = BKSE
BKSE_FILES = Tweak.xm
BKSE_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
