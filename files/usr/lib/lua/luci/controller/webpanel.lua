module("luci.controller.webpanel", package.seeall)

local uci = luci.model.uci.cursor()
local dispatcher = luci.dispatcher

function index()
    -- 主入口
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    
    -- 动态加载所有面板
    uci:foreach("webpanel", "panel", function(s)
        if s[".name"] and s.name then
            entry({"admin", "services", "webpanel", s[".name"]}, call("action_view"), s.name, tonumber(s.order) or 10)
        end
    end)
end

function action_view()
    local panel_id = dispatcher.context.path[4]
    local panel = uci:get_all("webpanel", panel_id)
    
    if not panel then
        dispatcher.error404("Panel not found")
        return
    end

    luci.template.render("webpanel/iframe", {
        panel = panel,
        edit_url = dispatcher.build_url("admin/services/webpanel/config")
    })
end

-- 配置变更时重建缓存
function on_config_change()
    dispatcher.build_url_cache()
end

uci:revert("webpanel", on_config_change)
