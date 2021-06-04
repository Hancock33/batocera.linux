################################################################################
#
# LIBRETRO PPSSPP
#
################################################################################
# Version.: Commits on Jun 04, 2021
LIBRETRO_PPSSPP_VERSION = 4a48f806380f397091531d94516a026aabc1ad50
LIBRETRO_PPSSPP_SITE = https://github.com/hrydgard/ppsspp.git
LIBRETRO_PPSSPP_SITE_METHOD=git
LIBRETRO_PPSSPP_GIT_SUBMODULES=YES
LIBRETRO_PPSSPP_DEPENDENCIES = ffmpeg
LIBRETRO_PPSSPP_LICENSE = GPLv2
LIBRETRO_PPSSPP_DEPENDENCIES = retroarch

LIBRETRO_PPSSPP_CONF_OPTS = \
	-DUSE_FFMPEG=ON -DUSE_SYSTEM_FFMPEG=ON -DUSING_FBDEV=OFF -DUSE_WAYLAND_WSI=OFF \
	-DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=Linux -DUSE_DISCORD=OFF \
	-DBUILD_SHARED_LIBS=OFF -DANDROID=OFF -DWIN32=OFF -DAPPLE=OFF \
	-DUNITTEST=OFF -DSIMULATOR=OFF -DLIBRETRO=ON

LIBRETRO_PPSSPP_TARGET_CFLAGS = $(TARGET_CFLAGS)

# enable vulkan if we are building with it
ifeq ($(BR2_PACKAGE_VULKAN_HEADERS)$(BR2_PACKAGE_VULKAN_LOADER),yy)
	LIBRETRO_PPSSPP_CONF_OPTS += -DVULKAN=ON
else
	LIBRETRO_PPSSPP_CONF_OPTS += -DVULKAN=OFF
endif

# enable x11/vulkan interface only if xorg
ifeq ($(BR2_PACKAGE_XORG7),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_X11_VULKAN=ON
else
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_X11_VULKAN=OFF
	LIBRETRO_PPSSPP_TARGET_CFLAGS += -DEGL_NO_X11=1 -DMESA_EGL_NO_X11_HEADERS=1
endif

# arm
ifeq ($(BR2_arm),y)
	LIBRETRO_PPSSPP_PLATFORM = armv 
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_GLES2=ON
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_X11_VULKAN=OFF
endif

ifeq ($(BR2_aarch64),y)
	LIBRETRO_PPSSPP_PLATFORM = arm64
	LIBRETRO_PPSSPP_CONF_OPTS += -DARM64=ON 
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_GLES2=ON
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_X11_VULKAN=OFF
endif

# x86
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DX86=ON
endif

# x86_64
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_64),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DX86_64=ON
endif

# odroid c2 / S905 and variants
ifeq ($(BR2_aarch64),y)
LIBRETRO_PPSSPP_CONF_OPTS += \
	-DARM64=ON \
	-DUSING_GLES2=ON \
	-DUSING_EGL=ON
endif

# odroid / rpi / rockpro64
ifeq ($(BR2_arm),y)
LIBRETRO_PPSSPP_CONF_OPTS += \
	-DARMV7=ON \
	-DARM=ON \
	-DUSING_GLES2=ON \
	-DUSING_EGL=ON
endif

# rockchip
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKCHIP_ANY),y)
ifeq ($(BR2_arm),y)
LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_EGL=OFF
endif

# In order to support the custom resolution patch, permissive compile is needed
LIBRETRO_PPSSPP_TARGET_CFLAGS += -fpermissive
else
ifeq ($(BR2_arm),y)
LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_EGL=ON
endif
endif

ifeq ($(BR2_PACKAGE_HAS_LIBMALI),y)
LIBRETRO_PPSSPP_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-lmali -DCMAKE_SHARED_LINKER_FLAGS=-lmali
endif

# rpi1 / rpi2 /rp3
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	LIBRETRO_PPSSPP_DEPENDENCIES += rpi-userland
	LIBRETRO_PPSSPP_CONF_OPTS += -DPPSSPP_PLATFORM_RPI=1
endif

LIBRETRO_PPSSPP_CONF_OPTS += -DCMAKE_C_FLAGS="$(LIBRETRO_PPSSPP_TARGET_CFLAGS)" -DCMAKE_CXX_FLAGS="$(LIBRETRO_PPSSPP_TARGET_CFLAGS)"

define LIBRETRO_PPSSPP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/lib/ppsspp_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/ppsspp_libretro.so
endef

$(eval $(cmake-package))
