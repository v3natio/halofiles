---@diagnostic disable: undefined-global

return {
	entry = function(self, args)
		local h = cx.active.current.hovered
		if h and h.cha.is_dir then
			ya.manager_emit("enter", {})
			return
		end

		if #args > 0 and args[1] == "detatch" then
			os.execute(string.format('yz-open detatch "%s"', h.url))
		else
			ya.manager_emit("open", {})
		end
	end,
}
