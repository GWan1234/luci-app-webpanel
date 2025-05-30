module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).index = true
    entry({"admin", "services", "webpanel", "settings"}, cbi("webpanel/settings"), _("Settings"), 30)
    
    -- 动态注册面板页面
    local uci = require "luci.model.uci".cursor()
    uci:foreach("webpanel", "webpanel",
        function(section)
            entry({"admin", "services", "webpanel", section[".name"]}, 
                  template("webpanel/panel/"..section[".name"]), 
                  section.name or "Unnamed", 
                  20)
        end)
end
