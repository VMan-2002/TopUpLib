local atlas_inject_ref = SMODS.Atlas.inject
SMODS.Atlas.inject = function(self, ...)
	self.full_path = nil
	local s = {pcall(atlas_inject_ref, self, ...)}
	if not s[1] then
		if self.full_path then
			self.full_path = string.gsub(self.full_path, "assets/2x/", "assets/1x/", 1)
			local file_data = assert(NFS.newFileData(self.full_path),
				('Failed to collect file data for Atlas %s'):format(self.key))
			self.image_data = assert(love.image.newImageData(file_data),
				('Failed to initialize image data for Atlas %s'):format(self.key))
			local imageData2 = love.image.newImageData(bit.lshift(self.image_data:getWidth(), 1), bit.lshift(self.image_data:getHeight(), 1), self.image_data:getFormat())
			imageData2:mapPixel(function(x, y)
				return self.image_data:getPixel(bit.rshift(x, 1), bit.rshift(y, 1))
			end)
			self.image_data:release()
			self.image_data = imageData2
			self.image = love.graphics.newImage(self.image_data,
				{ mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
			G[self.atlas_table][self.key_noloc or self.key] = self

			local mipmap_level = SMODS.config.graphics_mipmap_level_options[SMODS.config.graphics_mipmap_level]
			if not self.disable_mipmap and mipmap_level and mipmap_level > 0 then
				self.image:setMipmapFilter('linear', mipmap_level)
			end
		else
			error(s[2])
		end
	end
	return s[2]
end

