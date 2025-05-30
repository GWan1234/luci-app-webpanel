module("luci.controller.webpanel", package.seeall)

function index()
    entry({"admin", "services", "webpanel"}, firstchild(), _("Web Panels"), 60).dependent = false
    entry({"admin", "services", "webpanel", "overview"}, template("webpanel/overview"), _("Overview"), 10)
    entry({"admin", "services", "webpanel", "settings"}, cbi("webpanel/settings"), _("Settings"), 20)
end
