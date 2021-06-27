################################################################################
#
# EmulationStation theme "Carbon"
#
################################################################################
# Version.: Commits on Jun 27, 2021
ES_THEME_CARBON_VERSION = e7b5c92717bea0ce7243b87ab2b3aae069143f61
ES_THEME_CARBON_SITE = $(call github,hancock33,es-theme-carbon,$(ES_THEME_CARBON_VERSION))

define ES_THEME_CARBON_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/share/emulationstation/themes/es-theme-carbon
    cp -r $(@D)/* $(TARGET_DIR)/usr/share/emulationstation/themes/es-theme-carbon
endef

$(eval $(generic-package))
