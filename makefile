#
# Makefile for XT912 - Droid Razr
#

# The original zip file, MUST be specified by each product
local-zip-file     := RAZR.zip

# The output zip file of MIUI rom, the default is porting_miui.zip if not specified
local-out-zip-file := MIUI_RAZR.zip

# All apps from original ZIP, but has smali files chanded
#local-modified-apps := Phone 
#MediaProvider SettingsProvider

# All apks from MIUI
local-miui-removed-apps     := SettingsProvider MediaProvider 
#Provision

# All apps need to be removed from original ZIP file
local-remove-apps := SystemUI Superuser MusicFx FileManager Gallery2 Calendar CalendarProvider PackageInstaller \
	Calculator Contacts ContactsProvider DeskClock DownloadProvider DownloadProviderUI Email Exchange LatinIME \
	Mms Music NetworkLocation Provision QuickSearchBox Settings SoundRecorder TelephonyProvider Browser

# To include the local targets before and after zip the final ZIP file, 
# and the local-targets should:
# (1) be defined after including porting.mk if using any global variable(see porting.mk)
# (2) the name should be leaded with local- to prevent any conflict with global targets
local-pre-zip := local-zip-misc
local-after-zip:=

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk

# To define any local-target
updater := $(ZIP_DIR)/META-INF/com/google/android/updater-script
local-zip-misc: add-lbesec-miui
	@echo To add Skia Emoji support
	$(hide) cp -f $(SYSOUT_DIR)/lib/libskia.so $(ZIP_DIR)/system/lib
	$(hide) cp -f $(SYSOUT_DIR)/lib/libhwui.so $(ZIP_DIR)/system/lib
#	cp other/updater-script $(ZIP_DIR)/META-INF/com/google/android/updater-script
	cp other/build.prop $(ZIP_DIR)/system/build.prop
#	cp other/SetupWizard.apk $(ZIP_DIR)/system/app
#	cp other/OneTimeInitializer.apk $(ZIP_DIR)/system/app
	@echo update default lock wallpaper
	cp other/lock_wallpaper $(ZIP_DIR)/system/media/theme/default/lock_wallpaper
