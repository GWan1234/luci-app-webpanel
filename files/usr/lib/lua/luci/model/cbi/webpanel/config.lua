local uci = require "luci.model.uci".cursor()
local dispatcher = require "luci.dispatcher"

m = Map("webpanel", translate("Web Panels Management"))

-- 添加CSS样式（确保全局设置描述也生效）
m:append(Template("webpanel/cbi_style"))

-- 面板列表（保持不变）
s = m:section(TypedSection, "panel", "")
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = true
s.extedit = function(self, section)
    return dispatcher.build_url("admin/services/webpanel/config", section)
end

-- 列创建函数（添加class便于CSS定位）
function create_col(s, name, title, width, desc)
    local o = s:option(Value, name, title)
    o.width = width
    o.description = desc
    o.class = "aligned-option"  -- 添加统一class
    return o
end

-- 列定义（调整宽度总和为100%）
name = create_col(s, "name", translate("Name"), "15%", translate("Panel display name"))
url = create_col(s, "url", translate("URL"), "25%", translate("Full URL with http://"))
width = create_col(s, "width", translate("Width"), "15%", translate("e.g. 100% or 800px"))
height = create_col(s, "height", translate("Height"), "15%", translate("e.g. 600px"))
border = create_col(s, "border", translate("Border"), "10%", translate("Show border"))
scroll = create_col(s, "scrolling", translate("Scroll"), "10%", translate("Enable scrollbars"))
refresh = create_col(s, "refresh", translate("Refresh"), "10%", translate("Seconds (0=disable)"))

-- 设置默认值
width.default = "100%"
height.default = "600px"
border.default = "1"
scroll.default = "1"
refresh.default = "0"

return m
