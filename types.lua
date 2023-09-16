type store = {
	getState: (self: store) -> { any },
	changed: {
		connect: (self: any, f: (newState: { any }, oldState: { any }) -> ()) -> (),
	},
	dispatch: (action: any) -> (),
	destruct: (self: store) -> (),
	flush: () -> (),
}

type blockController = {
  hitBlock: (self: blockController, pos: Vector3, p2: any) -> any,
  placeBlock: (self: blockController, pos: Vector3, info: any, n: number, p5: any) -> any,
  stopBreakingAnimation: (self: blockController, s2: string, n3: number) -> (),
  startBreakingAnimation: (self: blockController) -> Animation,
  constructor: (self: blockController, p2: any, p3: any, p4: any) -> any,
  onStart: (self: blockController) -> any,
  new: (...any) -> blockController
}

type healthController = {
	getHealth: (self: healthController, player: Player) -> number,
	getShield: (self: healthController, player: Player) -> number,
	animateDamage: (
		self: healthController,
		character: Model,
		damageAmount: number,
		isMobile: boolean,
		playDamageHighlight: boolean,
		createDamageIndicator: boolean
	) -> (),
}

type team = {
	CanRespawn: boolean,
	AliveCount: number,
	Id: string,
	Name: string,
	Color: Color3,
}

type teamController = {
	-- please don't put your british accent in code, it looks awful.
	getPlayerTeamColour: (self: teamController, player: Player) -> Color3,
	getPlayerTeam: (self: teamController, player: Player) -> team,
	getPlayerTeamId: (self: teamController, player: Player) -> string,
	getTeamColour: (self: teamController, teamId: string) -> Color3,
}

type hotbarItem = {
	Type: string,
	Quantity: number,
	Slot: number,
}
type itemInfo = {
	ItemMaterial: string,
	ItemGroup: string,
	Skins: { [string]: any },
	Rewrite: { Type: string }?,
	Name: string,
	DisplayName: string,
	ToolRef: Instance,
	ViewportOptions: { Zoom: number? }?,
}

type hotbarController = {
	getHeldItemInfo: (self: hotbarController) -> itemInfo,
	getSword: (self: hotbarController) -> hotbarItem?,
	getHotbarItems: (self: hotbarController) -> { hotbarItem },
	setupHotbar: (self: hotbarController, inputMaid: any) -> (),
	setActiveSlot: (self: hotbarController, slot: number) -> (),
	updateActiveItem: (self: hotbarController, b: boolean?) -> (),
	getSlotFromKey: (self: hotbarController, key: Enum.KeyCode) -> number,
}

type inventoryItem = {Type: string, Quantity: number, Slot: number}

type storeInventory = {
	Contents: {inventoryItem},
	Size: number
}

type updatePlayerInventoryRet = {
	updated: boolean,
	slotId: number,
	inventory: storeInventory
}

type inventoryUtil = {
  updatePlayerInventory: (inventory: storeInventory, itemType: string, itemQuantity: number) -> updatePlayerInventoryRet,
  updateInventory: (inventory: storeInventory, itemType: string, itemQuantity: number) -> updatePlayerInventoryRet,
  findItem: (inventory: storeInventory, itemType: string) -> inventoryItem?,
  findEmptySlot: (inventory: storeInventory, min: number?, max: number?) -> number,
  cloneInventory: (inventory: storeInventory) -> storeInventory
}

type MeleeController = {
	strike: (self: MeleeController, input: InputObject?) -> (),
	strikeDesktop: (self: MeleeController, mouseLocation: Vector2) -> (),
	onStart: (self: MeleeController) -> (),
	manageShimBlocks: (self: MeleeController, b2: boolean) -> (),
	constructor: (self: MeleeController) -> (),
	-- TODO: find out what strikeMobile returns
	strikeMobile: (self: MeleeController) -> (),
	playAnimation: (self: MeleeController, itemInfo: itemInfo) -> (),
	attemptStrikeDesktop: (self: MeleeController, hit: BasePart) -> boolean,
	new: (...any) -> MeleeController,
}

type inventoryController = {
  registerItemPrediction: (self: inventoryController, p2: any, p3: any) -> string,
  clearInventory: (self: inventoryController) -> (),
  bindControls: (self: inventoryController) -> (),
  toggleInventory: (self: inventoryController) -> (),
  onStart: (self: inventoryController) -> any,
  isInventoryOpen: (self: inventoryController) -> boolean,
  -- TODO?: add screen controller typings
  constructor: (self: inventoryController, screenController: any) -> (),
  updateInventory: (self: inventoryController, p2: any, p3: any, p4: any, p5: any) -> (),
  moveItemToSlot: (self: inventoryController, item: inventoryItem, slot: number) -> (),
  moveItem: (self: inventoryController, itemType: string) -> (),
  hasItem: (self: inventoryController, itemType: string, quantity: number) -> boolean,
  new: (...any) -> inventoryController
}

--[[
	More priority = more indenting, less priority = less indenting
	TODO: write typings for:
			- ItemTable (because why not)
			- MeleeController (useful, currently doing)
			- ProjectileController (why not)
	- AfkController?
	- ScreenController?
	- SprintingController?
	- VelocityController?
--]]

type skywars = {
	AfkController: any,
	Store: store,
	StoreChanged: (k: string, handler: (newState: { any }, oldState: { any }) -> ()) -> (),
	TeamController: teamController,
	BlockController: blockController,
	EventHandler: any,
	Events: { any },
	HealthController: healthController,
	HotbarController: hotbarController,
	ItemTable: any,
	MeleeController: MeleeController,
	ScreenController: any,
	SprintingController: any,
	VelocityController: any,
	InventoryController: inventoryController,
	InventoryUtil: inventoryUtil
}


type Item = {
	Price: number,
	Quantity: number,
	ItemType: string,
	CurrencyType: string,
}

type ItemUpgrade = {
	Items: { Item },
	ItemIndex: number,
	Id: string,
}
type TeamUpgrade = {
	Name: string,
	Tiers: {
		{
			Description: string,
			Price: number,
			CurrencyType: string,
		}
	},
	ItemIndex: number,
	Icon: string,
}

type ItemUpgrades = { ItemUpgrade }

type TeamUpgrades = { TeamUpgrade }


-- use for testing auto-complete (provided by typings)
local testing: skywars
--[[
  example usage:
  skywars = {
			EventHandler = Events,
			Events = eventnames,
			AfkController = require(PlayerScripts.TS.controllers["afk-controller"]).AfkController,
			TeamController = require(PlayerScripts.TS.controllers["team-controller"]).TeamController,
			BlockController = require(PlayerScripts.TS.controllers["block-controller"]).BlockController,
			SprintingController = require(PlayerScripts.TS.controllers["sprinting-controller"]).SprintingController,
			--BlockFunctionHandler = require(PlayerScripts.TS.events).Functions,
			HotbarController = controllers.HotbarController,
			--BlockUtil = require(ReplicatedStorage.TS.util["block-util"]).BlockUtil,
			VelocityController = require(PlayerScripts.TS.controllers["player-velocity-controller"]).PlayerVelocityController,
			ScreenController = controllers.ScreenController,
			MeleeController = Flamework.resolveDependency(controllerids.MeleeController),
			ItemTable = require(ReplicatedStorage.TS.item.item).Items,
			HealthController = Flamework.resolveDependency(controllerids.HealthController),
			GameCurrencies = require(ReplicatedStorage.TS.game["game-currency"]).Currencies,
			Shops = require(ReplicatedStorage.TS.game.shop["game-shop"]).Shops,
      -- ...
  }
--]]
