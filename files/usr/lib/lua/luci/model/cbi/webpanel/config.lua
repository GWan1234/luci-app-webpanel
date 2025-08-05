local uci = require "luci.model.uci".cursor()
local dispatcher = require "luci.dispatcher"

m = Map("webpanel", translate("Web Panels Configuration"), 
    translate("Configure multiple web panels to embed in LuCI interface"))

-- 全局设置
s = m:section(NamedSection, "global", "webpanel", translate("Global Settings"))
s.addremove = false

o = s:option(Flag, "enabled", translate("Enable Web Panels"))
o.default = "1"
o.rmempty = false

-- 面板列表
s = m:section(TypedSection, "panel", translate("Web Panels"), 
    translate("List of configured web panels"))
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = false
s.extedit = dispatcher.build_url("admin/services/webpanel/config/%s")

-- 表头定义
s.sectionhead = translate("Panel Name")
s.sectiondescription = translate("Panel Settings")

-- 名称 (作为section标题)
function s.cfgsections(self)
    local sections = {}
    uci:foreach("webpanel", "panel", function(s) 
        if s[".name"] then
            sections[#sections + 1] = s[".name"]
        end
    end)
    return sections
end

-- 各选项定义
o = s:option(Value, "name", translate("Name"))
o.datatype = "string"
o.rmempty = false
o.width = "15%"

o = s:option(Value, "url", translate("URL"))
o.datatype = "string"
o.rmempty = false
o.width = "20%"

o = s:option(Value, "width", translate("Width"))
o.datatype = "string"
o.default = "100%"
o.width = "10%"

o = s:option(Value, "height", translate("Height"))
o.datatype = "string"
o.default = "600px"
o.width = "10%"

o = s:option(Flag, "border", translate("Border"))
o.default = "1"
o.rmempty = false
o.width = "10%"

o = s:option(Flag, "scrolling", translate("Scrolling"))
o.default = "1"
o.rmempty = false
o.width = "10%"

o = s:option(Value, "refresh", translate("Refresh(s)"))
o.datatype = "uinteger"
o.default = "0"
o.width = "10%"

return m
