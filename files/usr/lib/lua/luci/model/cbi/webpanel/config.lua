local uci = require "luci.model.uci".cursor()
local dispatcher = require "luci.dispatcher"
local fs = require "nixio.fs"
local sys = require "luci.sys"  -- 用于执行 shell 命令

m = Map("webpanel", translate("Web Panels Management"))

-- 清理缓存并重启服务的函数（带延迟）
local function delayed_cleanup_and_restart()
    -- 等待 5 秒，确保配置保存完成
    os.execute("sleep 5")
    
    -- 删除缓存文件
    for file in fs.glob("/tmp/luci-indexcache.*.json") do
        fs.unlink(file)
    end
    
    -- 重启服务（异步执行）
    os.execute("/etc/init.d/uhttpd restart >/dev/null 2>&1 &")
    os.execute("/etc/init.d/rpcd restart >/dev/null 2>&1 &")
    
    -- 可选：记录日志（调试用）
    sys.exec("logger -t webpanel 'Cleanup and restart completed after 5s delay'")
end

-- 在配置提交后执行清理操作（使用后台执行避免阻塞）
function m.on_after_commit(self)
    -- 使用 `&` 让清理在后台执行，不阻塞页面返回
    os.execute("(sleep 5 && rm -f /tmp/luci-indexcache.*.json && /etc/init.d/uhttpd restart && /etc/init.d/rpcd restart) >/dev/null 2>&1 &")
    return true
end

-- 添加CSS样式（确保全局设置描述也生效）
m:append(Template("webpanel/cbi_style"))

-- 面板列表
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
