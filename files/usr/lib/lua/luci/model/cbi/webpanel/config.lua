m = Map("webpanel", translate("Web Panels Manager"))

-- 全局开关
s = m:section(NamedSection, "global", "webpanel", translate("Global Settings"))
s.anonymous = true
s.addremove = false

o = s:option(Flag, "enabled", translate("Enable"))
o.default = 1

-- 面板列表（使用表格布局）
s = m:section(TypedSection, "panel", translate("Panels"), 
    translate("<strong>Tip:</strong> Add your web panels below"))
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = false

-- 名称列（作为主键）
name = s:option(Value, "name", translate("Name"))
name.forcewrite = true
name.rmempty = false
name.width = "15%"

-- URL列
url = s:option(Value, "url", translate("URL"))
url.rmempty = false
url.width = "25%"
url.datatype = "string"

-- 宽度/高度组
wh = s:option(Value, "width", translate("Size"))
wh.template = "cbi/webpanel_size"
wh.width = "15%"
wh:value("100%", "100%")
wh:value("800px", "800px")
wh:value("600px", "600px")

-- 其他选项（使用紧凑布局）
border = s:option(Flag, "border", translate("Border"))
border.enabled = "1"
border.disabled = "0"
border.default = "1"
border.width = "10%"

scroll = s:option(Flag, "scrolling", translate("Scroll"))
scroll.default = "1"
scroll.width = "10%"

refresh = s:option(Value, "refresh", translate("Refresh"))
refresh.datatype = "uinteger"
refresh.default = "0"
refresh.width = "10%"

-- 隐藏的高度选项（由Size统一管理）
hidden_height = s:option(HiddenValue, "height", "")
hidden_height.default = "600px"

return m
