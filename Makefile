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
