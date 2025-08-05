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

-- 名称
o = s:option(Value, "name", translate("Panel Name"))
o.datatype = "string"
o.rmempty = false
o.description = translate("Display name for this web panel in the menu")

-- URL
o = s:option(Value, "url", translate("Panel URL"))
o.datatype = "string"
o.rmempty = false
o.description = translate("Full URL of the web panel (e.g. http://192.168.1.1:8080)")

-- 宽度
o = s:option(Value, "width", translate("Width"))
o.default = "100%"
o.datatype = "string"
o.description = translate("Width of the embedded frame (e.g. 100% or 800px)")

-- 高度
o = s:option(Value, "height", translate("Height"))
o.default = "600px"
o.datatype = "string"
o.description = translate("Height of the embedded frame (e.g. 600px)")

-- 边框
o = s:option(Flag, "border", translate("Show Border"))
o.default = "1"
o.rmempty = false
o.description = translate("Show border around the embedded frame")

-- 滚动条
o = s:option(Flag, "scrolling", translate("Enable Scrolling"))
o.default = "1"
o.rmempty = false
o.description = translate("Enable scrollbars if content is larger than frame")

-- 刷新间隔
o = s:option(Value, "refresh", translate("Refresh Interval"))
o.datatype = "uinteger"
o.default = "0"
o.description = translate("Auto-refresh interval in seconds (0 to disable)")

return m
