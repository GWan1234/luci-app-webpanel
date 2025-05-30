module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).index = true
    entry({"admin", "services", "webpanel", "settings"}, cbi("webpanel/settings"), _("Settings"), 30)
    
    -- 安全注册面板路由
    local uci = require "luci.model.uci".cursor()
    uci:foreach("webpanel", "webpanel", function(s)
        if s[".name"] and s.name then
            entry({"admin", "services", "webpanel", s[".name"]}, 
                  call("render_panel"), 
                  s.name, 
                  20)
        end
    end)
end

function render_panel()
    local panel_name = luci.dispatcher.context.path[4] -- 修正参数获取方式
    local uci = require "luci.model.uci".cursor()
    local panel = uci:get_all("webpanel", panel_name)
    
    if not panel then
        luci.http.redirect(luci.dispatcher.build_url("admin/services/webpanel"))
        return
    end
    
    luci.template.render("webpanel/panel/view", {
        panel = panel,
        panel_name = panel_name
    })
end
