module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    
    -- 动态生成每个面板的入口
    local uci = luci.model.uci.cursor()
    uci:foreach("webpanel", "panel",
        function(section)
            entry({"admin", "services", "webpanel", section[".name"]}, call("action_view_panel", section[".name"]), section.name or "Unnamed Panel")
        end)
end

function action_view_panel(panel_id)
    local uci = luci.model.uci.cursor()
    local panel = uci:get_all("webpanel", panel_id)
    
    if not panel then
        luci.http.redirect(luci.dispatcher.build_url("admin/services/webpanel"))
        return
    end
    
    luci.template.render("webpanel/iframe", {
        panel = panel,
        edit_url = luci.dispatcher.build_url("admin/services/webpanel/config")
    })
end
