include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-webpanel
PKG_VERSION:=3.0
PKG_RELEASE:=2
PKG_MAINTAINER:=LeeHe-gif
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Web Panels Management
  PKGARCH:=all
  DEPENDS:=+luci-base
endef

define Package/$(PKG_NAME)/description
  Manage embedded web panels in LuCI interface
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
    # 安装配置文件
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./files/etc/config/webpanel $(1)/etc/config/
    
    # 安装Lua文件
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/webpanel.lua $(1)/usr/lib/lua/luci/controller/
    
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/webpanel
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/webpanel/config.lua $(1)/usr/lib/lua/luci/model/cbi/webpanel/
    
    # 安装视图文件
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webpanel
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/view/webpanel/cbi_style.htm $(1)/usr/lib/lua/luci/view/webpanel/
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/view/webpanel/iframe.htm $(1)/usr/lib/lua/luci/view/webpanel/
    
    # 安装静态资源
    $(INSTALL_DIR) $(1)/www/luci-static/resources/view/webpanel
    $(INSTALL_DATA) ./root/www/luci-static/resources/view/webpanel/cbi.css $(1)/www/luci-static/resources/view/webpanel/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
