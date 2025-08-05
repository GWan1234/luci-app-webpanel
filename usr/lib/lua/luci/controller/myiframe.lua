module("luci.controller.myiframe", package.seeall)

function index()
    entry({"admin", "services", "myiframe"}, firstchild(), _("Embedded Pages"), 60).dependent = false
    entry({"admin", "services", "myiframe", "config"}, cbi("myiframe/config"), _("Configuration"), 1)
    entry({"admin", "services", "myiframe", "view"}, template("myiframe/iframe"), _("View"), 2)
end
