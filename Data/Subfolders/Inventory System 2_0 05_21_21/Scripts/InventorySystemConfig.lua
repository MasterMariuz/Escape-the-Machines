--[[
	Configuration script for Inventory System 2.0.
	Here you can:
		- Configurate the Inventory System
]]

local config = {}

-----------------------------------------------
---------- CONFIG:
----- General:
-- Prints out all registered items and their ids on startup.
config.startupList = false
-- Enables debug message logging in the event log.
config.log = true

-----------------------------------------------
----- Inventory:
-- The number of slots available in an inventory.
config.slots = 30
-- The value used to represent an empty slot (no item).
-- Usually there's no need to change this.
config.clear = 0

----- User Interface:
-- The time a user needs to hover over an item before its tooltip shows up.
config.tooltipDelay = 0.5
-- Whether to apply Depth Of Field when the inventory is open.
config.DOF = true

-----------------------------------------------
----- Storage:
-- Enables automatic inventory saving/loading.
-- Remember that items take up storage space (though it's basically 2-3 values per item so don't worry too much).
-- Set the number of slots to a reasonable value to avoid running out of space.
config.enableStorage = false

-----------------------------------------------
----- Networking:
-- Enables high networked event traffic mode for substantially lower latency (High Traffic Mode - HTM).
-- Setting this to false enables Safe Mode (SM).
-- May interfere with games that frequently use networked events. Make sure that your game supports this feature.
-- (Do your networked broadcasts have fail-safe mechanisms for broadcast rate limits?)
-- ((You should always implement those, not just if you're planning to use this - just saying.))
config.highTrafficMode = false
-- The delay between sending item data to players in SM.
-- Lower values mean lower latency, but only to a certain point.
-- Values that are too low might result in unsafe data broadcasting rates.
-- ~0.06 is the fastest reliable delay, but works only in favorable conditions.
-- Anything above 0.075 should work fine, the default is 0.1 for more reliability where speed doesn't matter.
-- Will fallback to config.loadDelayHTM upon reaching the rate limit.
config.loadDelay = 0.1
-- The delay between sending packs of data to players while loading items in HTM.
-- Applied only when an event broadcast fails and when approaching the rate limit.
-- Lower values do not neccessarily mean lower load times.
config.loadDelayHTM = 0.5

return config