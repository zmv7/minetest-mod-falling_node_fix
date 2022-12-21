local falling_node = core.registered_entities["__builtin:falling_node"]
assert(falling_node ~= nil)

local normal = falling_node.on_step
function falling_node:on_step(dtime, moveresult)
	local pos = self.object:getpos()
	local name = ""
	if moveresult.collides then
		if self["owner"] then
			name = self["owner"]
		end
		if not core.is_protected(pos, name) then
			return normal(self, dtime, moveresult)
		end
		local drops = core.get_node_drops(self.node.name, "")
		for _,i in pairs(drops) do
			core.add_item(pos, i)
		end
		self.object:remove()
	end
end
