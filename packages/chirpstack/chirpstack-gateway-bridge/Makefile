include $(TOPDIR)/rules.mk

PKG_NAME:=chirpstack-gateway-bridge
PKG_VERSION:=4.0.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/brocaar/chirpstack-gateway-bridge/tar.gz/v${PKG_VERSION}?
PKG_HASH:=0c2910c6ac282ee458fc32426834766c63aeb1fbbee4cb7e5b4333473cae3b48

PKG_MAINTAINER:=
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/chirpstack-gateway-bridge-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/brocaar/chirpstack-gateway-bridge


GO_PKG_LDFLAGS_X:=\
	main.version=v$(PKG_VERSION) \
	main.commit=$(PKG_VERSION)  \
	main.builtBy=openwrt \

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/chirpstack-gateway-bridge
  SECTION:=chirpstack
  CATEGORY:=ChirpStack
  TITLE:=chirpstack-gateway-bridge
  URL:=https://github.com/brocaar/chirpstack-gateway-bridge
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/chirpstack-gateway-bridge/description
  LoRa gateway bridge for chirpstack.
endef

define Package/chirpstack-gateway-bridge/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(CP) ./files/* $(1)/

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/chirpstack-gateway-bridge $(1)/usr/bin/
endef

$(eval $(call GoBinPackage,chirpstack-gateway-bridge))
$(eval $(call BuildPackage,chirpstack-gateway-bridge))
