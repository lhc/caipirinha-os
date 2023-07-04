local uci = luci.model.uci.cursor()
local ut = require "luci.util"

module("luci.controller.speedtest", package.seeall)

function index()

	entry({"admin", "services", "speedtest"}, alias("admin", "services", "speedtest", "test"), _("Speedest"),8)
	entry({"admin", "services", "speedtest", "test"}, template("speedtest/test"), nil,1)
	entry({"admin", "services", "speedtest", "run_test"}, post("run_test")).leaf = true
end

function run_test()


	speedtest = io.popen("speedtest --json")

	if speedtest then
		while true do
			local ln = speedtest:read("*l")
			if not ln then break end
			luci.http.write(ln)
			luci.http.write("\n")
		end
	end
	return
end