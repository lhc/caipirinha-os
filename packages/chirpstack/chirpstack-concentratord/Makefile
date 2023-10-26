include $(TOPDIR)/rules.mk

PKG_NAME:=chirpstack-concentratord
PKG_VERSION:=4.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/chirpstack/chirpstack-concentratord/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=d68ef6c84f1096ea1f1e06c3bfccfc6d63e79c824c3624f59e45ab7e6157fdc9

PKG_MAINTAINER:=Orne Brocaar <info@brocaar.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=rust/host protobuf/host libloragw-sx1301 libloragw-sx1302 libloragw-2g4

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/rust/rust-package.mk

export CXX:=$(TARGET_CXX_NOCACHE)
export BINDGEN_EXTRA_CLANG_ARGS:=--sysroot=$(TOOLCHAIN_DIR) -I$(STAGING_DIR)/usr/include

CARGO_VARS += \
	PROTOC=$(STAGING_DIR_HOSTPKG)/bin/protoc

define Package/chirpstack-concentratord
	SECTION:=chirpstack
	CATEGORY:=ChirpStack
	TITLE:=ChirpStack Concentratord
	URL:=https://github.com/chirpstack/chirpstack-concentratord
	DEPENDS:=+libstdcpp
endef

define Package/chirpstack-concentratord-2g4
	SECTION:=chirpstack
	CATEGORY:=ChirpStack
	TITLE:=ChirpStack Concentratord (2g4)
	URL:=https://github.com/chirpstack/chirpstack-concentratord
	DEPENDS:=+libstdcpp +chirpstack-concentratord
endef

define Package/chirpstack-concentratord-sx1301
	SECTION:=chirpstack
	CATEGORY:=ChirpStack
	TITLE:=ChirpStack Concentratord (SX1301)
	URL:=https://github.com/chirpstack/chirpstack-concentratord
	DEPENDS:=+libstdcpp +chirpstack-concentratord
endef

define Package/chirpstack-concentratord-sx1302
	SECTION:=chirpstack
	CATEGORY:=ChirpStack
	TITLE:=ChirpStack Concentratord (SX1302/3)
	URL:=https://github.com/chirpstack/chirpstack-concentratord
	DEPENDS:=+libstdcpp +chirpstack-concentratord
endef

define Package/chirpstack-concentratord/description
	ChirpStack Concentratord
endef

define Package/chirpstack-concentratord-2g4/description
	ChirpStack Concentratord (2g4)
endef

define Package/chirpstack-concentratord-sx1301/description
	ChirpStack Concentratord (SX1301)
endef

define Package/chirpstack-concentratord-sx1302/description
	ChirpStack Concentratord (SX1302/3)
endef

define Package/chirpstack-concentratord/conffiles
	/etc/config/chirpstack-concentratord
endef

define Package/chirpstack-concentratord/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/chirpstack-concentratord.config $(1)/etc/config/chirpstack-concentratord

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/chirpstack-concentratord.init $(1)/etc/init.d/chirpstack-concentratord

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/gateway-id $(1)/usr/bin/
endef

define Package/chirpstack-concentratord-2g4/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/chirpstack-concentratord-2g4 $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/chirpstack-concentratord/2g4/examples
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chirpstack-concentratord-2g4/config/*.toml $(1)/etc/chirpstack-concentratord/2g4/examples/
endef

define Package/chirpstack-concentratord-sx1301/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/chirpstack-concentratord-sx1301 $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/chirpstack-concentratord/sx1301/examples
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chirpstack-concentratord-sx1301/config/*.toml $(1)/etc/chirpstack-concentratord/sx1301/examples/
endef

define Package/chirpstack-concentratord-sx1302/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/chirpstack-concentratord-sx1302 $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/chirpstack-concentratord/sx1302/examples
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chirpstack-concentratord-sx1302/config/*.toml $(1)/etc/chirpstack-concentratord/sx1302/examples
endef

define Build/Prepare
	$(PKG_UNPACK)
	(cd $(PKG_BUILD_DIR) && \
		rm -rf .cargo && \
		rm chirpstack-concentratord-sx1301/build.rs && \
		rm chirpstack-concentratord-sx1302/build.rs && \
		rm chirpstack-concentratord-2g4/build.rs \
	)
	$(Build/Patch)
endef

define Build/Compile
	$(call Build/Compile/Cargo,chirpstack-concentratord-sx1301,--locked)
	$(call Build/Compile/Cargo,chirpstack-concentratord-sx1302,--locked)
	$(call Build/Compile/Cargo,chirpstack-concentratord-2g4,--locked)
	$(call Build/Compile/Cargo,gateway-id,--locked)
endef

$(eval $(call RustBinPackage,chirpstack-concentratord))
$(eval $(call BuildPackage,chirpstack-concentratord))
$(eval $(call BuildPackage,chirpstack-concentratord-2g4))
$(eval $(call BuildPackage,chirpstack-concentratord-sx1301))
$(eval $(call BuildPackage,chirpstack-concentratord-sx1302))