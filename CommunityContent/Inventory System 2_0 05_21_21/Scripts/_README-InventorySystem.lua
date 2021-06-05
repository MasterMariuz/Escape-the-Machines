--[[

	For any questions, bugs etc. ping me on discord (Core's Creator server preferably)
		@chipnertkj#5685

	-----------------------------------------------
	Setup:
		- Drag Inventory System 2.0 into your hierarchy.
		- Configurate Inventory System using the InventorySystemConfig script.
	
	-----------------------------------------------
	Adding items:
		You might have to jump between those steps in order to get an item to fully work.

		1. Registry:
			- Open InventorySystemRegistry and register the item (instructions inside).
		2. Pickup:
			- Drag in an Inventory System Pickup template.
			- Deinstance it and abandon its template.
			- Set ItemID (custom property) to the items ItemID.
			  You can check the ItemIDs using config.startupList (in the config script).
			- Set Amount (custom property) to the amount the pickup will provide.
			- The rest of the properties (excluding Model) allow you to configurate the pickups animation.
			  Try messing with those if you need to.
			- Replace the content of the Model group with your model of choice.
			- Rename the object to whatever you want.
			- Create a new template from the object.
		3. Icon:
			This template is mostly for visuals.
			You can customize it however you want, just don't change its structure.

			- Drag in an Inventory System Icon template.
			- Deinstance it and abandon its template.
			- Change the image of Icon to whatever you want.
			  You can even add children to it if you need to.
			  Or even replace it, it just has to keep the name "Icon".
			- Rename the object to whatever you want.
			- Create a new template from the object.

	-----------------------------------------------
	API Legend:
		() - input and output
		<> - output only
		<<>> - input only (output not used atm)
		[] - optional

	-----------------------------------------------
	API (Events):
		Client -> Client:
			- "InventorySystemShowMessage" (string)
				Shows a message to the player.

		Client -> Server:
			- "InventorySystemSend" <player> (type) (data1) [(data2)] [(data3)]
				For internal use. Tells the server about player interactions with the UI.
				Types:
					- move (slotFrom) (slotTo)
					- equip (slotFrom)
					- use (slot)
					- drop (slot)
					- destroy (slot)

		Server -> Client:
			- "InventorySystemLoad" (type) (data1) [(data2)] [(data3)]
				For internal use. Controls a players UI from the server.
				Types:
					- load (slot) ({itemid, amount})
					- move (slotFrom) (slotTo)
					- equip (slot) (equipmentSlot)
					- unequip <<slot>> (equipmentSlot)
					- remove (slot) (amount)
					- lock
						The player won't be able to open the inventory.
					- unlock
					- full
						"Inventory full" message.

		Server -> Server:
			- "InventorySystemAddItem" (player) (itemid) (amount)
				Adds an item to a players inventory.
	
	-----------------------------------------------
	API (Event Requests):
		ListenIDs are used to make sure that only the right script receives the requested data.
		Every script INSTANCE should have its own unique ListenID. You can generate them using RNGs.
		Functions connected to events called by requests ("= ...") have to check if the ListenID returned
		is exactly the same as the one it holds. 

		Server -> Server:
			- "?InventorySystemAddRequest" (player) (itemid) (amount) (listenid)
				Checks if the specified amount of such item can be added to a players inventory.
				Broadcasts "=InventorySystemAddRequest" with (listenid) (bool).

			- "?InventorySystemSlotRequest" (player) (slot) (listenid)
				Requests slot data from a players inventory.
				Broadcasts "=InventorySystemSlotRequest" with (listenid) (itemid) (amount).

			- "?InventorySystemEquipmentRequest" (player) (equipmentSlot) (listenid)
				Request equipment slot data from a players inventory.
				Broadcasts "=InventorySystemEquipmentRequest" with (listenid) (slot) (equipment object).
]]