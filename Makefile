include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-webpanel
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-webpanel
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Web Panel Manager
  PKGARCH:=all
  DEPENDS:=+luci-base
endef

define Package/luci-app-webpanel/description
  Embed external web interfaces with configurable URLs
endef

define Build/Prepare
	$(CP) ./luasrc/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
endef

define Package/luci-app-webpanel/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/webpanel.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/webpanel
	$(INSTALL_DATA) ./luasrc/model/cbi/webpanel/settings.lua $(1)/usr/lib/lua/luci/model/cbi/webpanel/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webpanel
	$(INSTALL_DATA) ./luasrc/view/webpanel/main.htm $(1)/usr/lib/lua/luci/view/webpanel/
	$(INSTALL_DATA) ./luasrc/view/webpanel/nav.htm $(1)/usr/lib/lua/luci/view/webpanel/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webpanel/panel
	$(INSTALL_DATA) ./luasrc/view/webpanel/panel/*.htm $(1)/usr/lib/lua/luci/view/webpanel/panel/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./root/etc/config/webpanel $(1)/etc/config/
endef

$(eval $(call BuildPackage,luci-app-webpanel))
