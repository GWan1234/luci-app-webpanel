module("luci.controller.webpanel", package.seeall)

local dispatcher = require "luci.dispatcher"
local uci = require "luci.model.uci".cursor()

-- 定义刷新菜单函数
local function refresh_menus()
    local panels = uci:get_all("webpanel") or {}
    local count = 0
    
    -- 计算现有面板数量
    for k, v in pairs(panels) do
        if k ~= "global" then count = count + 1 end
    end

    uci:foreach("webpanel", "panel",
        function(section)
            dispatcher.entry(
                {"admin", "services", "webpanel", section[".name"]}, 
                dispatcher.call("action_view_panel", section[".name"]), 
                section.name or "Unnamed Panel",
                count + 10
            )
            count = count + 1
        end)
end

-- 面板视图函数
function action_view_panel(panel_id)
    local panel = uci:get_all("webpanel", panel_id)
    
    if not panel then
        luci.http.redirect(dispatcher.build_url("admin/services/webpanel"))
        return
    end
    
    luci.template.render("webpanel/iframe", {
        panel = panel,
        edit_url = dispatcher.build_url("admin/services/webpanel/config")
    })
end

-- 主入口函数
function index()
    dispatcher.entry(
        {"admin", "services", "webpanel"},
        dispatcher.firstchild(),
        _("Web Panels"),
        60
    ).dependent = false
    
    dispatcher.entry(
        {"admin", "services", "webpanel", "config"},
        dispatcher.cbi("webpanel/config"),
        _("Configuration"),
        1
    )
    
    refresh_menus()
end

-- UCI配置变更回调
uci:revert("webpanel", function()
    refresh_menus()
    dispatcher.build_url_cache()
end)
