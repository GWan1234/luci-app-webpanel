m = Map("myiframe", translate("Embedded Web Pages Configuration"), 
    translate("Configure external web pages to be embedded in OpenWRT LuCI interface"))

s = m:section(NamedSection, "config", "myiframe", translate("Settings"))
s.addremove = false

o = s:option(Value, "url", translate("Page URL"), 
    translate("Full URL of the page to embed (e.g. http://192.168.1.1:3030)"))
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

o = s:option(Value, "refresh", translate("Refresh Interval (seconds)"), 
    translate("Set to 0 to disable auto-refresh"))
o.datatype = "uinteger"
o.default = "0"

return m
