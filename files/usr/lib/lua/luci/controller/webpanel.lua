module("luci.controller.webpanel", package.seeall)

local uci = require "luci.model.uci".cursor()
local dispatcher = require "luci.dispatcher"
local sys = require "luci.sys"

function _create_menu_entries()
    -- 主入口必须保持独立
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).index = true
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    
    -- 动态面板注册（确保不干扰主入口）
    uci:foreach("webpanel", "panel", function(s)
        if s[".name"] and s.name and s.url then
            entry(
                {"admin", "services", "webpanel", s[".name"]},
                call("action_view_panel"),
                s.name,
                nil,  -- 自动排序
                function() return s[".name"] end  -- 动态参数传递
            )
        end
    end)
end

function action_view_panel()
    local panel_id = dispatcher.context.request.args[1] or ""
    local panel = uci:get_all("webpanel", panel_id)
    
    if not panel or not panel.url then
        return dispatcher.error404("Requested panel not found")
    end

    luci.template.render("webpanel/iframe", {
        panel = panel,
        edit_url = dispatcher.build_url("admin/services/webpanel/config")
    })
end

-- 初始化菜单（带错误保护）
pcall(_create_menu_entries)

-- 配置变更自动刷新（安全版）
uci:revert("webpanel", function()
    pcall(dispatcher.build_url_cache)
end)
