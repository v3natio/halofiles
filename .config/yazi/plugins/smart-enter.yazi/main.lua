---@diagnostic disable: undefined-global
---@sync entry

return {
	entry = function(self, job)
		local h = cx.active.current.hovered
		if h.cha.is_dir then
			ya.manager_emit("enter", {})
		else
			if job.args and job.args[1] == "detach" then
				os.execute(string.format('yz_open detach "%s"', h.url))
			else
				ya.manager_emit("open", {})
			end
		end
	end,
}
