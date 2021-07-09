################################################################################
#
# LIBRETRO-VICE
#
################################################################################
# Version.: Commits on Jul 09, 2021
LIBRETRO_VICE_VERSION = 8b5df005e8c104728a85e83967ccbee2382415ee
LIBRETRO_VICE_SITE = $(call github,libretro,vice-libretro,$(LIBRETRO_VICE_VERSION))
LIBRETRO_VICE_LICENSE = GPLv2

LIBRETRO_VICE_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_VICE_PLATFORM = armv neon

else ifeq ($(BR2_aarch64),y)
LIBRETRO_VICE_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
LIBRETRO_VICE_PLATFORM = armv neon
endif

define LIBRETRO_VICE_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=x64
	#$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=x64sc
	#$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=x128
	#$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=xpet
	#$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=xplus4
	#$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VICE_PLATFORM)" EMUTYPE=xvic
endef

define LIBRETRO_VICE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/vice_x64_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_x64_libretro.so
	#$(INSTALL) -D $(@D)/vice_x64sc_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_x64sc_libretro.so
	#$(INSTALL) -D $(@D)/vice_x128_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_x128_libretro.so
	#$(INSTALL) -D $(@D)/vice_xpet_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_xpet_libretro.so
	#$(INSTALL) -D $(@D)/vice_xplus4_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_xplus4_libretro.so
	#$(INSTALL) -D $(@D)/vice_xvic_libretro.so $(TARGET_DIR)/usr/lib/libretro/vice_xvic_libretro.so
endef

$(eval $(generic-package))
