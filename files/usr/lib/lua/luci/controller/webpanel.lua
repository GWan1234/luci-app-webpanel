module("luci.controller.webpanel", package.seeall)

-- 先定义函数再调用
local function refresh_menus()
    local uci = luci.model.uci.cursor()
    local panels = uci:get_all("webpanel") or {}
    local count = 0
    
    -- 计算现有面板数量
    for k, v in pairs(panels) do
        if k ~= "global" then count = count + 1 end
    end

    uci:foreach("webpanel", "panel",
        function(section)
            entry({"admin", "services", "webpanel", section[".name"]}, 
                 call("action_view_panel", section[".name"]), 
                 section.name or "Unnamed Panel",
                 count + 10)
            count = count + 1
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

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    
    -- 现在可以安全调用refresh_menus了
    refresh_menus()
end

-- 注册UCI变更回调
luci.model.uci.cursor():revert("webpanel", function() 
    refresh_menus()
    luci.dispatcher.build_url_cache()
end)
