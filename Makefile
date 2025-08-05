include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-webpanel
PKG_VERSION:=2.0
PKG_RELEASE:=2

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=MIT
PKG_MAINTAINER:=LeeHe-gif

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-webpanel
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Web Panel Embedding for LuCI
  PKGARCH:=all
  DEPENDS:=+luci-base
endef

define Package/luci-app-webpanel/description
  Embed external web panels (like 192.168.1.1:3030) into LuCI interface with customizable size and settings.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-webpanel/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/webpanel $(1)/etc/config/webpanel
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/webpanel.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/webpanel
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/webpanel/config.lua $(1)/usr/lib/lua/luci/model/cbi/webpanel/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webpanel
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/webpanel/iframe.htm $(1)/usr/lib/lua/luci/view/webpanel/
endef

$(eval $(call BuildPackage,luci-app-webpanel))
