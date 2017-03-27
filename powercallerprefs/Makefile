include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PowerCallerPrefs
PowerCallerPrefs_FILES = PCPRootListController.m
PowerCallerPrefs_INSTALL_PATH = /Library/PreferenceBundles
PowerCallerPrefs_FRAMEWORKS = UIKit
PowerCallerPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PowerCallerPrefs.plist$(ECHO_END)
