module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).index = true
    entry({"admin", "services", "webpanel", "settings"}, cbi("webpanel/settings"), _("Settings"), 30)
    
    -- 动态注册所有配置的面板
    register_panels()
end

-- 安全注册面板路由
function register_panels()
    local uci = require "luci.model.uci".cursor()
    local panels = uci:get_all("webpanel") or {}
    
    for section_id, config in pairs(panels) do
        if type(config) == "table" and config[".type"] == "webpanel" then
            entry(
                {"admin", "services", "webpanel", section_id},
                call("render_panel"),
                config.name or "Unnamed Panel",
                20
            )
        end
    end
end

-- 渲染面板页面
function render_panel()
    local panel_id = luci.dispatcher.context.path[4]
    local uci = require "luci.model.uci".cursor()
    
    -- 参数校验
    if not panel_id or panel_id == "" then
        luci.http.redirect(luci.dispatcher.build_url("admin/services/webpanel"))
        return
    end
    
    -- 获取面板配置
    local panel_config = uci:get_all("webpanel", panel_id)
    if not panel_config then
        luci.http.status(404, "Panel Not Found")
        luci.template.render("error404", {message = "Requested panel does not exist"})
        return
    end
    
    -- 准备模板数据
    local template_vars = {
        panel_id = panel_id,
        panel_name = panel_config.name or "Unnamed",
        panel_url = panel_config.url or "",
        panel_width = panel_config.width or "100%",
        panel_height = panel_config.height or "800px",
        active_tab = panel_id
    }
    
    -- 渲染模板
    luci.template.render("webpanel/panel/view", template_vars)
end

-- 备用错误页面
function error404()
    luci.template.render("error404", {message = "The requested page was not found"})
end
