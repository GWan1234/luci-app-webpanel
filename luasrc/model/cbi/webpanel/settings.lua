local m = Map("webpanel", translate("Web Panel Settings"),
    translate("Configure URLs of embedded web interfaces"))

local s = m:section(TypedSection, "webpanel", "")
s.addremove = true
s.anonymous = false

s:option(Value, "name", translate("Panel Name"))
s:option(Value, "url", translate("URL"),
    translate("Full URL including port (e.g. http://192.168.1.1:8080)"))
s:option(Value, "width", translate("Width"), "100%")
s:option(Value, "height", translate("Height"), "800px")
s:option(Value, "weight", translate("Sort Priority"), 
    translate("Lower numbers appear first in menu"))
.default = 100

return m
