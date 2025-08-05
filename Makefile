include $(TOPDIR)/rules.mk

PKG_NAME:=uci-app-webpanel
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/uci-app-webpanel
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Embedded Web Pages for LuCI
  PKGARCH:=all
  DEPENDS:=+luci-base
endef

define Package/uci-app-webpanel/description
  Allows embedding external web pages in the LuCI interface.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/uci-app-webpanel/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/myiframe $(1)/etc/config/myiframe
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/myiframe.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/myiframe
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/myiframe/config.lua $(1)/usr/lib/lua/luci/model/cbi/myiframe/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/myiframe
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/myiframe/iframe.htm $(1)/usr/lib/lua/luci/view/myiframe/
endef

$(eval $(call BuildPackage,uci-app-webpanel))
