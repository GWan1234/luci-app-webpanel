module("luci.controller.webpanel", package.seeall)

function index()
    -- 主入口点
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).index = true
    
    -- 配置页面
    entry({"admin", "services", "webpanel", "settings"}, cbi("webpanel/settings"), _("Settings"), 30)
    
    -- 动态注册面板
    local uci = require "luci.model.uci".cursor()
    uci:foreach("webpanel", "webpanel", function(s)
        entry({"admin", "services", "webpanel", s[".name"]}, 
              call("render_panel"), 
              s.name or "Unnamed", 
              20)
    end)
end

function render_panel()
    local panel = luci.dispatcher.context.requestpath[4]
    luci.template.render("webpanel/panel/"..panel, {
        panel_config = luci.model.uci().get_all("webpanel", panel)
    })
end
