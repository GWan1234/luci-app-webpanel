m = Map("webpanel", translate("Web Panel Configuration"), 
    translate("Configure external web panels to embed in LuCI interface"))

s = m:section(NamedSection, "config", "webpanel", translate("Settings"))
s.addremove = false

o = s:option(Value, "url", translate("Panel URL"), 
    translate("Full URL of the web panel to embed (e.g. http://192.168.1.1:3030)"))
o.datatype = "string"
o.rmempty = false

o = s:option(Value, "width", translate("Width"), 
    translate("Width of the embedded frame (e.g. 100% or 800px)"))
o.default = "100%"
o.datatype = "string"

o = s:option(Value, "height", translate("Height"), 
    translate("Height of the embedded frame (e.g. 600px)"))
o.default = "600px"
o.datatype = "string"

o = s:option(Flag, "border", translate("Show Border"), 
    translate("Show border around the embedded frame"))
o.default = "1"
o.rmempty = false

o = s:option(Flag, "scrolling", translate("Enable Scrolling"), 
    translate("Enable scrollbars if content is larger than frame"))
o.default = "1"
o.rmempty = false

o = s:option(Value, "refresh", translate("Refresh Interval (seconds)"), 
    translate("Set to 0 to disable auto-refresh"))
o.datatype = "uinteger"
o.default = "0"

return m
