################################################################################
#
# CANNONBALL
#
################################################################################
# Version.: Commits on Mar 09, 2021
LIBRETRO_CANNONBALL_VERSION = b85f887b641baede72f4a6e0ef6fa5c4bd479159
LIBRETRO_CANNONBALL_SITE = $(call github,libretro,cannonball,$(LIBRETRO_CANNONBALL_VERSION))
LIBRETRO_CANNONBALL_LICENSE = COPYRIGHT
LIBRETRO_CANNONBALL_NON_COMMERCIAL = y

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_CANNONBALL_PLATFORM = armv
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
LIBRETRO_CANNONBALL_PLATFORM = rpi3_64
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
LIBRETRO_CANNONBALL_PLATFORM = rpi4_64
else ifeq ($(BR2_aarch64),y)
LIBRETRO_CANNONBALL_PLATFORM = unix
endif

define LIBRETRO_CANNONBALL_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_CANNONBALL_PLATFORM)"
endef

define LIBRETRO_CANNONBALL_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/cannonball_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/cannonball_libretro.so
	$(INSTALL) -D $(@D)/roms/roms.txt "$(TARGET_DIR)/usr/share/batocera/datainit/roms/cannonball/roms_needed.txt"
	mkdir -p "$(TARGET_DIR)/usr/share/batocera/datainit/roms/cannonball/res"
	$(INSTALL) -D $(@D)/res/*.bin "$(TARGET_DIR)/usr/share/batocera/datainit/roms/cannonball/res/"
endef

$(eval $(generic-package))
