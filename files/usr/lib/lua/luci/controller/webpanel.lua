module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    
    -- 动态生成菜单项
    refresh_menus()
end

-- 新增函数：刷新菜单项
function refresh_menus()
    local uci = luci.model.uci.cursor()
    uci:foreach("webpanel", "panel",
        function(section)
            entry({"admin", "services", "webpanel", section[".name"]}, 
                 call("action_view_panel", section[".name"]), 
                 section.name or "Unnamed Panel", 
                 nil)  -- 排序位置设为nil让系统自动处理
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

-- 监听UCI配置变化
function on_uci_change()
    refresh_menus()
    luci.dispatcher.build_url_cache()
end

-- 注册UCI变更回调
luci.model.uci.cursor():revert("webpanel", function() on_uci_change() end)
