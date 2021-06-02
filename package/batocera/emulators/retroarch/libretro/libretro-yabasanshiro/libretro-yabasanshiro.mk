################################################################################
#
# YABASANSHIRO
#
################################################################################
# Version.: Commits on Apr 11, 2021
LIBRETRO_YABASANSHIRO_VERSION = 4d85b6e793030c77ae6b64fd7c99041c935b54ac
LIBRETRO_YABASANSHIRO_SITE = $(call github,libretro,yabause,$(LIBRETRO_YABASANSHIRO_VERSION))
LIBRETRO_YABASANSHIRO_LICENSE = GPLv2
LIBRETRO_YABASANSHIRO_DEPENDENCIES = retroarch

LIBRETRO_YABASANSHIRO_PLATFORM = $(LIBRETRO_PLATFORM)
LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS = $(TARGET_LDFLAGS)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4),y)
LIBRETRO_YABASANSHIRO_PLATFORM = odroid
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += BOARD=ODROID-XU4 FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S922X),y)
LIBRETRO_YABASANSHIRO_PLATFORM = odroid-n2
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RK3399),y)
LIBRETRO_YABASANSHIRO_PLATFORM = arm64
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
LIBRETRO_YABASANSHIRO_PLATFORM = rpi4
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_LIBRETECH_H5),y)
LIBRETRO_YABASANSHIRO_PLATFORM = arm64
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ORANGEPI_ZERO2),y)
LIBRETRO_YABASANSHIRO_PLATFORM = h616
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC2),y)
LIBRETRO_YABASANSHIRO_PLATFORM = c2
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_MALI_T760),y)
LIBRETRO_YABASANSHIRO_PLATFORM = RK RK3288
LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS += -shared -Wl,--no-undefined -Wl,--version-script=link.T -pthread
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
LIBRETRO_YABASANSHIRO_PLATFORM = s912
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC4)$(BR2_PACKAGE_BATOCERA_TARGET_S905GEN3),y)
LIBRETRO_YABASANSHIRO_PLATFORM = c4
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
else ifeq ($(BR2_aarch64),y)
LIBRETRO_YABASANSHIRO_PLATFORM = unix
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1 arch=arm64 HAVE_SSE=0 ARCH_IS_LINUX=1
LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS += -shared -Wl,--no-undefined -pthread
else ifeq ($(BR2_x86_64),y)
LIBRETRO_YABASANSHIRO_PLATFORM = unix
LIBRETRO_YABASANSHIRO_EXTRA_ARGS += ARCH_IS_LINUX=1
LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS += -shared -Wl,--no-undefined -pthread -lGL
endif

ifeq ($(BR2_PACKAGE_HAS_LIBMALI),y)
LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS += -lmali
endif

define LIBRETRO_YABASANSHIRO_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) LDFLAGS="$(LIBRETRO_YABASANSHIRO_TARGET_LDFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
		-C $(@D)/yabause/src/libretro -f Makefile \
		platform="$(LIBRETRO_YABASANSHIRO_PLATFORM)" $(LIBRETRO_YABASANSHIRO_EXTRA_ARGS)
endef

define LIBRETRO_YABASANSHIRO_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/yabause/src/libretro/yabasanshiro_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/yabasanshiro_libretro.so
endef

$(eval $(generic-package))
