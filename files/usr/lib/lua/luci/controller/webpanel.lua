module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "config"}, cbi("webpanel/config"), _("Configuration"), 1)
    entry({"admin", "services", "webpanel", "view"}, call("action_view"), _("View Panel"), 2)
end

function action_view()
    local uci = luci.model.uci.cursor()
    local url = uci:get("webpanel", "config", "url") or ""
    
    luci.template.render("webpanel/iframe", {
        url = url,
        edit_url = luci.dispatcher.build_url("admin/services/webpanel/config")
    })
end
