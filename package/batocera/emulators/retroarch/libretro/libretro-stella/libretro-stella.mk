################################################################################
#
# STELLA
#
################################################################################
# Version.: Commits on Jul 01, 2021
LIBRETRO_STELLA_VERSION = c3220e0532ea0bc280e36648bea64078c7f3f257
LIBRETRO_STELLA_SITE = $(call github,stella-emu,stella,$(LIBRETRO_STELLA_VERSION))
LIBRETRO_STELLA_LICENSE = GPLv2

define LIBRETRO_STELLA_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/src/libretro -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_STELLA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/src/libretro/stella_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/stella_libretro.so
endef

$(eval $(generic-package))
