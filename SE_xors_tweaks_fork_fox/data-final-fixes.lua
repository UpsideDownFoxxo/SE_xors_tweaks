local mod_prefix = "xor-"

local sand_name = mods["Krastorio2"] and "kr-sand" or "sand"
local glass_name = mods["Krastorio2"] and "kr-sand" or "sand"

local data_util_SE = require("__space-exploration__/data_util")

if mods["Krastorio2"] then
	if settings.startup["xor-enable-robot-cargo-fix"].value == true then
		-- fix bots having way too large cargo size with K2 (oversight by SE integration?)
		data.raw["logistic-robot"]["logistic-robot"].max_payload_size = 2
	end

	if settings.startup["xor-enable-aai-furnace-module-balancing"].value == true then
		-- reduce number of module slots of AAI industrial furnace from 5 to 4 so K2 advanced furnace (with 5 slots) is more of an upgrade
		data.raw["assembling-machine"]["industrial-furnace"].module_specification = { module_slots = 4 }
	end

	if settings.startup["xor-enable-k2-advanced-chem-plant-balancing"].value == true then
		-- nerf: was too strong compared to normal chem plant
		data.raw["assembling-machine"]["kr-advanced-chemical-plant"].crafting_speed = 6
		-- reduce power usage accordingly
		local advanced_chemical_plant_energy_usage_old =
			string.match(data.raw["assembling-machine"]["kr-advanced-chemical-plant"].energy_usage, "%A+")
		data.raw["assembling-machine"]["kr-advanced-chemical-plant"].energy_usage = advanced_chemical_plant_energy_usage_old
				* 6
				/ 8
			.. "MW"
	end
end

if settings.startup["xor-enable-increased-caster-speed"].value == true then
	-- SE: increase speed (by factor of 2) of casting machine so that a less ridicoulous number of machines is needed
	local casting_machine_speed_factor = 2
	data.raw["assembling-machine"]["se-casting-machine"].crafting_speed = data.raw["assembling-machine"]["se-casting-machine"].crafting_speed
		* casting_machine_speed_factor

	-- SE: increase energy_usage to balance out the fewer needed machines and the steam return of water cooling
	local casting_machine_energy_usage_old =
		string.match(data.raw["assembling-machine"]["se-casting-machine"].energy_usage, "%A+")
	data.raw["assembling-machine"]["se-casting-machine"].energy_usage = casting_machine_energy_usage_old
			* casting_machine_speed_factor
		.. "kW"
end

if settings.startup["xor-enable-no-burning-in-space"].value == true then
	-- Gas Power Station for only not-space to make the Isothermic Generator more useful
	-- setting up the collision mask stuff yourself seems complicated so I just copy from something that SE changed to now be placeable in space
	if mods["Krastorio2"] then
		data.raw["generator"]["kr-gas-power-station"].collision_mask =
			data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
	end
	data.raw["burner-generator"]["burner-turbine"].collision_mask =
		data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
	data.raw["boiler"]["boiler"].collision_mask = data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
end

-- BEGIN RECIPE ORDERING

-- stone
data.raw["recipe"]["se-core-fragment-stone"].order = "01"
if mods["Krastorio2"] then -- while SE and AAI have sand (and glass) the recipe name is different to the K2 name; the order of those without K2 seems correct per default
	data.raw["recipe"]["sand"].order = "02"
	data.raw["recipe"]["glass"].order = "03"
end
data.raw["recipe"]["se-glass-vulcanite"].order = "04"
if mods["Krastorio2"] then
	data.raw["recipe"]["kr-quartz"].order = "05"
	data.raw["recipe"]["kr-silicon"].order = "06"
	data.raw["recipe"]["se-kr-silicon-with-vulcanite"].order = "07"
end

-- iron
data.raw["recipe"]["se-core-fragment-iron-ore"].order = "01"
if mods["Krastorio2"] then
	data.raw["recipe"]["kr-filter-iron-ore-from-dirty-water"].order = "02"
end
data.raw["recipe"]["iron-plate"].order = "03"
if mods["Krastorio2"] then
	data.raw["recipe"]["kr-enriched-iron"].order = "04"
	data.raw["recipe"]["kr-iron-plate-from-enriched-iron"].order = "05"
end
data.raw["recipe"]["se-molten-iron"].order = "06"
data.raw["recipe"]["se-iron-ingot"].order = "07"
data.raw["recipe"]["se-iron-ingot-to-plate"].order = "08"

-- steel
data.raw["recipe"]["steel-plate"].order = "09"
data.raw["recipe"]["se-steel-ingot"].order = "10"
data.raw["recipe"]["se-steel-ingot-to-plate"].order = "11"

-- copper
data.raw["recipe"]["se-core-fragment-copper-ore"].order = "01"
if mods["Krastorio2"] then
	data.raw["recipe"]["kr-filter-copper-ore-from-dirty-water"].order = "02"
end
data.raw["recipe"]["copper-plate"].order = "03"
if mods["Krastorio2"] then
	data.raw["recipe"]["kr-enriched-copper"].order = "04"
	data.raw["recipe"]["kr-copper-plate-from-enriched-copper"].order = "05"
end
data.raw["recipe"]["se-molten-copper"].order = "06"
data.raw["recipe"]["se-copper-ingot"].order = "07"
data.raw["recipe"]["se-copper-ingot-to-plate"].order = "08"

-- rare metals
if mods["Krastorio2"] then
	data.raw["recipe"]["se-core-fragment-kr-rare-metal-ore"].order = "01"
	data.raw["recipe"]["kr-filter-rare-metal-ore-from-dirty-water"].order = "02"
	data.raw["recipe"]["kr-rare-metals"].order = "03"
	data.raw["recipe"]["kr-enriched-rare-metals"].order = "04"
	data.raw["recipe"]["kr-rare-metals-from-enriched-rare-metals"].order = "05"
	data.raw["recipe"]["se-kr-rare-metals-with-vulcanite"].order = "06"
end

-- imersite
if mods["Krastorio2"] then
	data.raw["recipe"]["se-core-fragment-kr-imersite"].order = "01"
	data.raw["recipe"]["kr-imersite-powder"].order = "02"
end

-- END RECIPE ORDERING

-- BEGIN ITEM ORDERING

-- stone
data.raw["item"]["se-core-fragment-stone"].order = "01"
data.raw["item"]["stone"].order = "02"
if mods["Krastorio2"] then
	data.raw["item"]["kr-quartz"].order = "05"
	data.raw["item"]["kr-silicon"].order = "06"
	data.raw["item"]["kr-sand"].order = "03"
	data.raw["item"]["kr-glass"].order = "04"
else
	data.raw["item"]["sand"].order = "03"
	data.raw["item"]["glass"].order = "04"
end

-- iron
data.raw["item"]["se-core-fragment-iron-ore"].order = "01"
data.raw["item"]["iron-ore"].order = "02"
if mods["Krastorio2"] then
	data.raw["item"]["kr-enriched-iron"].order = "03"
end
data.raw["item"]["se-iron-ingot"].order = "04"
data.raw["item"]["iron-plate"].order = "05"

-- copper
data.raw["item"]["se-core-fragment-copper-ore"].order = "01"
data.raw["item"]["copper-ore"].order = "02"
if mods["Krastorio2"] then
	data.raw["item"]["kr-enriched-copper"].order = "03"
end
data.raw["item"]["se-copper-ingot"].order = "04"
data.raw["item"]["copper-plate"].order = "05"

-- rare metals
if mods["Krastorio2"] then
	data.raw["item"]["se-core-fragment-kr-rare-metal-ore"].order = "01"
	data.raw["item"]["kr-rare-metal-ore"].order = "02"
	data.raw["item"]["kr-enriched-rare-metals"].order = "03"
	data.raw["item"]["kr-rare-metals"].order = "04"
end

-- END ITEM ORDERING

if settings.startup["xor-enable-coal-landfill"].value == true then
	-- add landfill from coal
	local function landfil_recipe(item_name, count)
		data:extend({
			{
				type = "recipe",
				name = "landfill-" .. item_name,
				energy_required = 1,
				enabled = false,
				category = "hard-recycling",
				icons = {
					{ icon = data.raw.item.landfill.icon, icon_size = data.raw.item.landfill.icon_size },
					{
						icon = data.raw.item[item_name].icon,
						icon_size = data.raw.item[item_name].icon_size,
						scale = 0.33 * 64 / (data.raw.item[item_name].icon_size or 64),
					},
				},
				ingredients = {
					{ type = "item", name = item_name, amount = count },
				},
				results = { { type = "item", name = "landfill", amount = 1 } },
				order = "z-b-" .. item_name,
				allow_decomposition = false,
			},
		})
		table.insert(
			data.raw["technology"]["se-recycling-facility"].effects,
			{ type = "unlock-recipe", recipe = "landfill-" .. item_name }
		)
	end

	landfil_recipe("coal", 50)
end

if mods["Krastorio2"] then
	if settings.startup["xor-enable-chemicals-fuel-value"].value == true then
		-- fuel value for hydrogen
		data.raw["fluid"]["kr-hydrogen"].fuel_value = "450kJ"
		data.raw["fluid"]["kr-hydrogen"].emissions_multiplier = 0.5

		-- fuel value for light oil
		data.raw["fluid"]["light-oil"].fuel_value = "600kJ"
		data.raw["fluid"]["light-oil"].emissions_multiplier = 1.5
	end

	if settings.startup["xor-swap-electrolysis-outputs"].value == true then
		-- QoL: swap fluid outputs to match inputs of another recipe
		-- just copied from original and swapped outputs
		data.raw["assembling-machine"]["kr-electrolysis-plant"].fluid_boxes = {
			-- Input

			{
				production_type = "input",
				pipe_covers = pipecoverspictures(),
				pipe_picture = require("__Krastorio2__.prototypes.buildings.pipe-picture"),
				volume = 100,
				pipe_connections = {
					{
						flow_direction = "input",
						direction = defines.direction.west --[[@as data.Direction]],
						position = { -2, -1 },
					},
				},
			},
			{
				production_type = "input",
				pipe_covers = pipecoverspictures(),
				pipe_picture = require("__Krastorio2__.prototypes.buildings.pipe-picture"),
				volume = 100,
				pipe_connections = {
					{
						flow_direction = "input",
						direction = defines.direction.west --[[@as data.Direction]],
						position = { -2, 1 },
					},
				},
			},
			{
				production_type = "output",
				pipe_covers = pipecoverspictures(),
				pipe_picture = require("__Krastorio2__.prototypes.buildings.pipe-picture"),
				volume = 100,
				pipe_connections = {
					{
						flow_direction = "output",
						direction = defines.direction.east --[[@as data.Direction]],
						position = { 2, -1 },
					},
				},
			},
			{
				production_type = "output",
				pipe_covers = pipecoverspictures(),
				pipe_picture = require("__Krastorio2__.prototypes.buildings.pipe-picture"),
				volume = 100,
				pipe_connections = {
					{
						flow_direction = "output",
						direction = defines.direction.east --[[@as data.Direction]],
						position = { 2, 1 },
					},
				},
			},
		}
		data.raw["assembling-machine"]["kr-electrolysis-plant"].fluid_boxes_off_when_no_fluid_recipe = false
	end
end

--local electric_boiling = require("__space-exploration__/prototypes/phase-3/electric-boiling.lua")

if mods["Krastorio2"] then
	if settings.startup["xor-enable-uranium-balance"].value == true then
		data.raw["recipe"]["uranium-fuel-cell"].ingredients = {
			{ type = "item", name = "steel-plate", amount = 1 },
			{ type = "item", name = "uranium-238", amount = 8 }, -- down from 10
			{ type = "item", name = "uranium-235", amount = 1 }, -- down from 2
		}

		-- SE post process overwrites those:
		--krastorio.recipes.replaceProduct("nuclear-fuel-reprocessing", "uranium-238", {"uranium-238", 3})
		--krastorio.recipes.replaceProduct("nuclear-fuel-reprocessing", "stone", {"stone", 2})

		-- SE post process overwrites those:
		--[[data.raw["recipe"]["nuclear-fuel-reprocessing"].results = {
      {type="item", name="uranium-238", amount = 4}, -- down from 5
      {type="item", name="stone", amount = 2}, -- down from 3
      {type="item", name="tritium", probability = 0.12, amount = 1} --  down from 15%
    }]]

		-- so solution is to make own copy of recipe and...
		local copy_of_reprocessing_recipe = table.deepcopy(data.raw["recipe"]["nuclear-fuel-reprocessing"])
		copy_of_reprocessing_recipe.name = mod_prefix .. copy_of_reprocessing_recipe.name
		copy_of_reprocessing_recipe.results = {
			{ type = "item", name = "uranium-238", amount = 4 }, -- down from 5
			{ type = "item", name = "stone", amount_min = 2, amount_max = 3 }, -- down from 3
			{ type = "item", name = "kr-tritium", probability = 0.12, amount = 1 }, --  down from 15%
		}
		data:extend({ copy_of_reprocessing_recipe })
		-- ...overwrite original in tech
		data.raw["technology"]["nuclear-fuel-reprocessing"].effects = {
			{ type = "unlock-recipe", recipe = copy_of_reprocessing_recipe.name },
		}
		-- removing it breaks mods that modify this recipe after this mod
		--data.raw["recipe"]["nuclear-fuel-reprocessing"] = nil
	end
end

if mods["Krastorio2"] then
	if settings.startup["xor-enable-dirty-water-balance"].value == true then
		data.raw["recipe"]["se-kr-dirty-water-filtration-iridium"].results = {
			{ type = "fluid", name = "water", amount = 90 },
			{ type = "item", name = "stone", probability = 0.40, amount = 1 },
			--{name = "se-iridium-ore-crushed", probability = 0.10, amount = 1},
			{ type = "item", name = "se-iridium-ore-crushed", probability = 0.60, amount = 1 },
			--{name = "se-vulcanite-ion-exchange-beads", probability = 0.6, amount =1}
			{ type = "item", name = "se-vulcanite-ion-exchange-beads", probability = 0.8, amount = 1 },
		}

		data.raw["recipe"]["se-kr-dirty-water-filtration-holmium"].results = {
			{ type = "fluid", name = "water", amount = 90 },
			{ type = "item", name = "stone", probability = 0.40, amount = 1 },
			--{name = "se-holmium-ore-crushed", probability = 0.10, amount = 1},
			{ type = "item", name = "se-holmium-ore-crushed", probability = 0.60, amount = 1 },
			--{name = "se-cryonite-ion-exchange-beads", probability = 0.6, amount =1}
			{ type = "item", name = "se-cryonite-ion-exchange-beads", probability = 0.8, amount = 1 },
		}
	end
end

if mods["Krastorio2"] then
	local data_util_SE_PP = require("__space-exploration-postprocess__/data_util")

	if settings.startup["xor-disable-k2-graphics"].value == true then
		-- items themselves
		data.raw["item"]["iron-plate"].icon = "__base__/graphics/icons/iron-plate.png"
		data.raw["item"]["copper-plate"].icon = "__base__/graphics/icons/copper-plate.png"

		-- from ore
		data.raw["recipe"]["iron-plate"].icons =
			data_util_SE_PP.sub_icons("__base__/graphics/icons/iron-plate.png", "__base__/graphics/icons/iron-ore.png")
		data.raw["recipe"]["copper-plate"].icons = data_util_SE_PP.sub_icons(
			"__base__/graphics/icons/copper-plate.png",
			"__base__/graphics/icons/copper-ore.png"
		)

		-- from enriched
		data.raw["recipe"]["kr-iron-plate-from-enriched-iron"].icons = data_util_SE_PP.sub_icons(
			"__base__/graphics/icons/iron-plate.png",
			data.raw["item"]["kr-enriched-iron"].icon
		)
		data.raw["recipe"]["kr-copper-plate-from-enriched-copper"].icons = data_util_SE_PP.sub_icons(
			"__base__/graphics/icons/copper-plate.png",
			data.raw["item"]["kr-enriched-copper"].icon
		)

		-- steel (from ingot)
		-- vanilla steel "plate" is actually a beam... which is already in use by K2
		-- that's why we use a different graphic instead, silver plate from: https://github.com/kirazy/reskins-angels/blob/master/graphics/icons/smelting/plates/angels-plate-silver.png
		-- it fits the SE steel ingot color so well they now look a bit too similar but *shrug*
		--[[data.raw["item"]["steel-plate"].icon = "__base__/graphics/icons/steel-plate.png"]]
		data.raw["item"]["steel-plate"].icon = "__SE_xors_tweaks_fork_fox__/graphics/icons/angels-plate-silver.png"
		--[[data.raw.recipe["se-steel-ingot-to-plate"].icons =
        data_util_SE_PP.sub_icons("__base__/graphics/icons/steel-plate.png", "__space-exploration-graphics__/graphics/icons/steel-ingot.png")]]
		data.raw.recipe["se-steel-ingot-to-plate"].icons = data_util_SE_PP.sub_icons(
			"__SE_xors_tweaks_fork_fox__/graphics/icons/angels-plate-silver.png",
			"__space-exploration-graphics__/graphics/icons/iron-ingot.png"
		)

		-- casting
		data.raw.recipe["se-iron-ingot-to-plate"].icons = data_util_SE_PP.sub_icons(
			"__base__/graphics/icons/iron-plate.png",
			"__space-exploration-graphics__/graphics/icons/iron-ingot.png"
		)
		data.raw.recipe["se-copper-ingot-to-plate"].icons = data_util_SE_PP.sub_icons(
			"__base__/graphics/icons/copper-plate.png",
			"__space-exploration-graphics__/graphics/icons/copper-ingot.png"
		)

		-- at this point the steel icon has changed, so we can just use the exact SE code to do this
		data.raw.recipe["se-barrel-reprocessing"].icons = data_util_SE.transition_icons({
			icon = data.raw.item["barrel"].icon,
			icon_size = data.raw.item["barrel"].icon_size,
			scale = 0.5,
		}, {
			icon = data.raw.item["steel-plate"].icon,
			icon_size = data.raw.item["steel-plate"].icon_size,
			scale = 0.5,
		})

		-- same here
		data.raw.recipe["se-observation-frame-blank"].icons = data_util_SE.sub_icons(
			"__space-exploration-graphics__/graphics/icons/observation-frame-blank.png",
			data.raw.item["steel-plate"].icon
		)

		-- use AAI sand
		data.raw["item"]["kr-sand"].icon = "__aai-industry__/graphics/icons/sand.png"
		data.raw["item"]["kr-sand"].pictures = nil -- needed because K2 uses the different-icon-variants for sand-on-ground feature
	end

	-- only if non-K2 graphics from above are NOT used:
	-- fixes some inconsistencies with useage of K2 graphics style (e.g. steel/iron color)
	-- SE PP might overwrite some of those or might do that in the future
	if settings.startup["xor-disable-k2-graphics"].value == false then
		data.raw["item"]["se-iron-ingot"].icon = "__space-exploration-graphics__/graphics/icons/steel-ingot.png"
		data.raw["item"]["se-steel-ingot"].icon = "__space-exploration-graphics__/graphics/icons/iron-ingot.png"

		data.raw.recipe["se-steel-ingot-to-plate"].icons = data_util_SE_PP.sub_icons(
			data.raw.item["steel-plate"].icon,
			"__space-exploration-graphics__/graphics/icons/iron-ingot.png"
		)
		data.raw.recipe["se-iron-ingot-to-plate"].icons = data_util_SE_PP.sub_icons(
			data.raw.item["iron-plate"].icon,
			"__space-exploration-graphics__/graphics/icons/steel-ingot.png"
		)

		data.raw.recipe["se-steel-ingot"].icons = data_util_SE_PP.sub_icons(
			"__space-exploration-graphics__/graphics/icons/iron-ingot.png",
			data.raw.fluid["se-molten-iron"].icon
		)
		data.raw.recipe["se-iron-ingot"].icons = data_util_SE_PP.sub_icons(
			"__space-exploration-graphics__/graphics/icons/steel-ingot.png",
			data.raw.fluid["se-molten-iron"].icon
		)

		-- at this point the steel icon has changed, so we can just use the exact SE code to do this
		data.raw.recipe["se-barrel-reprocessing"].icons = data_util_SE.transition_icons({
			icon = data.raw.item["barrel"].icon,
			icon_size = data.raw.item["barrel"].icon_size,
			scale = 0.5,
		}, {
			icon = data.raw.item["steel-plate"].icon,
			icon_size = data.raw.item["steel-plate"].icon_size,
			scale = 0.5,
		})

		-- same here
		data.raw.recipe["se-observation-frame-blank"].icons = data_util_SE.sub_icons(
			"__space-exploration-graphics__/graphics/icons/observation-frame-blank.png",
			data.raw.item["steel-plate"].icon
		)

		data.raw.recipe["se-delivery-cannon-pack-se-iron-ingot"].icon =
			"__space-exploration-graphics__/graphics/icons/steel-ingot.png"
		data.raw.recipe["se-delivery-cannon-pack-se-steel-ingot"].icon =
			"__space-exploration-graphics__/graphics/icons/iron-ingot.png"
	end
end

require("prototypes/phase-3/casting")

if settings.startup["xor-enable-alt-recipe-tweaks"].value == true then
	require("prototypes/phase-3/alt-recipes")
end

-- make lithium chain not chloride positive with prod modules... actually the whole chain is positive, that's not fixable by using catalyst here
--[[
data.raw.recipe["lithium"].results = {
  { type = "fluid", name = "chlorine", amount = 10, catalyst_amount = 10.0 },
  { type = "item", name = "lithium", amount = 5 },
}
data.raw.recipe["lithium"].main_product = "lithium"
]]
