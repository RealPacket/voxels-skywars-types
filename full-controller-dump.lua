type ActionBarController = {
	removeActionBar: (p1: any, p2: any) -> any,
	mountActionBarScreen: (p1: any) -> any,
	displayActionBar: (p1: any, p2: any, p3: any, p4: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type AdvertController = {
	createAdvertModel: (p1: any, p2: any, p3: any) -> any,
	playIdleAnimation: (p1: any, p2: any, p3: any, p4: any) -> any,
	createBundleAdvert: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	equipWeapon: (p1: any, p2: any, p3: any, p4: any) -> any,
	onStart: (p1: any) -> any,
	getCosmeticFromProduct: (p1: any, p2: any, p3: any, p4: any) -> any,
	constructor: (p1: any) -> any,
	createSeasonPassAdvert: (p1: any, p2: any, p3: any) -> any,
	createBundleAdverts: (p1: any, p2: any, p3: any) -> any,
	getCosmeticByItemType: (p1: any, p2: any, p3: any) -> any,
	equipArmourItem: (p1: any, p2: any, p3: any, p4: any) -> any,
	equipArmour: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any) -> any,
	playAnimations: (p1: any, p2: any, p3: any, p4: any) -> any,
	new: (...any) -> any,
}
type AfkController = {
	isAfk: (p1: any) -> any,
	setup: (p1: any) -> any,
	pollStatus: (p1: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type AmbientController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type AnimationController = {
	playAnimationTrack: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	playHumanoidAnimation: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any) -> any,
	stopAnimations: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type AnnouncementController = {
	updateQueue: (p1: any) -> any,
	displayAnnouncement: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ArmourController = {
	constructor: (p1: any) -> any,
	getItemInfoFromArmourType: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type BlockController = {
	hitBlock: (p1: any, p2: any) -> any,
	placeBlock: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	stopBreakingAnimation: (p1: any, p2: any, p3: any) -> any,
	startBreakingAnimation: (p1: any) -> any,
	constructor: (p1: any, p2: any, p3: any, p4: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type BlockRaycastController = {
	getBlockRaycastStored: (p1: any) -> any,
	onTick: (p1: any, p2: any) -> any,
	getPlayerFooting: (p1: any, p2: any, p3: any) -> any,
	select: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	voidCast: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	pillarCast: (p1: any) -> any,
	executeRaycast: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	handleBlockEvent: (p1: any, p2: any) -> any,
	raycastBlockLocation: (p1: any, p2: any, p3: any, p4: any) -> any,
	manageState: (p1: any, p2: any) -> any,
	preview: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	new: (...any) -> any,
}
type CameraController = {
	handleFirstPerson: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any) -> any,
	toggleCharacterParticles: (p1: any, p2: any, p3: any) -> any,
	bindToShiftLock: (p1: any) -> any,
	toggleZoom: (p1: any) -> any,
	manageCursorLocking: (p1: any) -> any,
	isCameraLocked: (p1: any) -> any,
	new: (...any) -> any,
	cleanup: (p1: any, p2: any) -> any,
	onLobbyStart: (p1: any, p2: any) -> any,
	disableCrosshair: (p1: any) -> any,
	isFirstPerson: (p1: any) -> any,
	lockCamera: (p1: any) -> any,
	handleInitialFirstPerson: (p1: any, p2: any) -> any,
	handleCrosshairVisibility: (p1: any, p2: any) -> any,
	enableFirstPerson: (p1: any) -> any,
	unlockCamera: (p1: any) -> any,
	enableCrosshair: (p1: any) -> any,
	onGameStart: (p1: any, p2: any) -> any,
	invertCameraLock: (p1: any) -> any,
	bindCameraUpdate: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	enableThirdPerson: (p1: any) -> any,
}
type CharacterController = {
	setOutlineStatus: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	new: (...any) -> any,
}
type ChatController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ChestController = {
	closeChest: (p1: any) -> any,
	updateChest: (p1: any, p2: any, p3: any, p4: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	openChest: (p1: any, p2: any) -> any,
	isChestOpen: (p1: any) -> any,
	getOpenedChest: (p1: any) -> any,
	new: (...any) -> any,
}
type ChunkController = {
	onTick: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ContentController = {
	setLoaded: (p1: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any) -> any,
	destroyLoadingScreen: (p1: any, p2: any) -> any,
	attachLoadingScreen: (p1: any) -> any,
	getSizeOffset: (p1: any, p2: any, p3: any, p4: any) -> any,
	updateProgress: (p1: any, p2: any, p3: any) -> any,
	didUseLoadingScreen: (p1: any) -> any,
	new: (...any) -> any,
}
type CooldownController = {
	isOnCooldown: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type CoreController = {
	disableChat: (p1: any) -> any,
	enableChat: (p1: any) -> any,
	enableProximityPrompts: (p1: any) -> any,
	onStart: (p1: any) -> any,
	getJoystickFrame: (p1: any) -> any,
	constructor: (p1: any) -> any,
	disableJoystick: (p1: any) -> any,
	disableProximityPrompts: (p1: any) -> any,
	getCoreSafe: (p1: any, p2: any) -> any,
	setCoreSafe: (p1: any, p2: any, p3: any) -> any,
	disableDefault: (p1: any) -> any,
	enableJoystick: (p1: any) -> any,
	new: (...any) -> any,
}
type CosmeticsController = {
	getActiveCosmetic: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	ownsCosmetic: (p1: any, p2: any) -> any,
	getArmour: (p1: any, p2: any) -> any,
	getTool: (p1: any, p2: any) -> any,
	getActiveSkinAnimation: (p1: any, p2: any) -> any,
	getActiveSkin: (p1: any, p2: any) -> any,
	enableCosmetic: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type EffectController = {
	removeBlur: (p1: any) -> any,
	setBlur: (p1: any, p2: any) -> any,
	springBlur: (p1: any, p2: any, p3: any, p4: any) -> any,
	tweenFov: (p1: any, p2: any, p3: any, p4: any) -> any,
	getBlur: (p1: any) -> any,
	constructor: (p1: any) -> any,
	polychrome: (p1: any) -> any,
	monochrome: (p1: any) -> any,
	new: (...any) -> any,
}
type EggController = {
	hasNearbyEggChanged: (p1: any, p2: any, p3: any) -> any,
	findNearbyEgg: (p1: any, p2: any) -> any,
	getNearbyEgg: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	updateNearbyEgg: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type EmoteController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type EndScreenController = {
	constructor: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ExperienceController = {
	getLevel: (p1: any) -> any,
	getExperience: (p1: any) -> any,
	constructor: (p1: any) -> any,
	new: (...any) -> any,
}
type FocusedController = {
	disableFocus: (p1: any) -> any,
	enableFocus: (p1: any, p2: any, p3: any) -> any,
	isFocused: (p1: any) -> any,
	constructor: (p1: any, p2: any, p3: any, p4: any) -> any,
	new: (...any) -> any,
}
type FovController = {
	getBaseFov: (p1: any) -> any,
	resetMultiplier: (p1: any) -> any,
	constructor: (p1: any) -> any,
	setMultiplier: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type FriendController = {
	FRIENDS_UPDATE_INTERVAL: number,
	updateOnlineFriends: (p1: any) -> any,
	pullAllFriends: (p1: any) -> any,
	canSendInvites: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type GameController = {
	closeScoreboard: (p1: any) -> any,
	createKillFeedCard: (p1: any, p2: any, p3: any, p4: any) -> any,
	openScoreboard: (p1: any) -> any,
	onGameStart: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type GameShopController = {
	purchaseItem: (p1: any, p2: any, p3: any) -> any,
	getNextUpgradeableItem: (self: GameShopController, p2: any) -> any,
	purchaseItemUpgrade: (p1: any, p2: any, p3: any) -> any,
	purchaseTeamUpgrade: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}

type HealthController = {
	onStart: (p1: any) -> any,
	open: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	getHealth: (p1: any, p2: any) -> any,
	onGameStart: (p1: any, p2: any) -> any,
	animateDamage: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	getShield: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type HotbarController = {
	displayActionBar: (p1: any, p2: any, p3: any) -> any,
	getHeldItemInfo: (p1: any) -> any,
	onStart: (p1: any) -> any,
	getSlotFromKey: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	updateActiveItem: (p1: any, p2: any) -> any,
	setActiveSlot: (p1: any, p2: any) -> any,
	setupHotbar: (p1: any, p2: any) -> any,
	onGameStart: (p1: any, p2: any) -> any,
	getHotbarItems: (p1: any) -> any,
	getSword: (p1: any) -> any,
	new: (...any) -> any,
}
type HumanoidController = {
	addSpeedModifier: (p1: any, p2: any, p3: any) -> any,
	getSpeed: (p1: any) -> any,
	updateJumpPower: (p1: any) -> any,
	setBaseSpeed: (p1: any, p2: any) -> any,
	removeJumpModifier: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	addJumpModifier: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any) -> any,
	updateSpeed: (p1: any) -> any,
	removeSpeedModifier: (p1: any, p2: any) -> any,
	getJumpPower: (p1: any) -> any,
	resetBaseSpeed: (p1: any) -> any,
	getCachedCharacter: (p1: any) -> any,
	handleHumanoid: (p1: any) -> any,
	new: (...any) -> any,
}
type HypeController = {
	onRender: (p1: any, p2: any) -> any,
	playPurchase: (p1: any) -> any,
	destroyFrame: (p1: any) -> any,
	createAnimatedTextObject: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any, p7: any) -> any,
	setupFrame: (p1: any) -> any,
	constructor: (p1: any) -> any,
	waterfallText: (p1: any, p2: any) -> any,
	playLevelUp: (p1: any) -> any,
	playEnding: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type InventoryController = {
	registerItemPrediction: (p1: any, p2: any, p3: any) -> any,
	clearInventory: (p1: any) -> any,
	bindControls: (p1: any) -> any,
	toggleInventory: (p1: any) -> any,
	onStart: (p1: any) -> any,
	isInventoryOpen: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	updateInventory: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	moveItemToSlot: (p1: any, p2: any, p3: any) -> any,
	moveItem: (p1: any, p2: any) -> any,
	hasItem: (p1: any, p2: any, p3: any) -> any,
	new: (...any) -> any,
}
type KeypointController = {
	getPositionFromTarget: (p1: any, p2: any) -> any,
	removeKeypoint: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any) -> any,
	getDistanceToTarget: (p1: any, p2: any) -> any,
	clearKeypoints: (p1: any) -> any,
	addKeypoint: (p1: any, p2: any, p3: any) -> any,
	new: (...any) -> any,
}
type KillEffectController = {
	createDebugCommand: (p1: any) -> any,
	isViewportFrameDescendent: (p1: any, p2: any) -> any,
	createKillEffectsFolder: (p1: any) -> any,
	playKillEffect: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type LeaderboardController = {
	pollLeaderboard: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type LeaveGameController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type LobbyController = {
	setupCosmeticsShopEvents: (p1: any, p2: any, p3: any) -> any,
	onLobbyStart: (p1: any, p2: any) -> any,
	onGameStart: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type LodController = {
	onTick: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	setRender: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any) -> any,
	getLodData: (p1: any, p2: any) -> any,
	getChunkPosition: (p1: any) -> any,
	shouldRender: (p1: any, p2: any, p3: any, p4: any) -> any,
	new: (...any) -> any,
}
type LoginStreakController = {
	convertTzStringToOffset: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type MatchmakingController = {
	joinQueueIn: (p1: any, p2: any) -> any,
	tryLeaveQueue: (p1: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any) -> any,
	joinQueue: (p1: any, p2: any) -> any,
	canQueue: (p1: any) -> any,
	leaveQueue: (p1: any) -> any,
	isInQueue: (p1: any) -> any,
	new: (...any) -> any,
}
type MeleeController = {
	strike: (p1: any, p2: any) -> any,
	strikeDesktop: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	manageShimBlocks: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	strikeMobile: (p1: any) -> any,
	playAnimation: (p1: any, p2: any) -> any,
	attemptStrikeDesktop: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type MetricController = {
	constructor: (p1: any) -> any,
	getDeviceType: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type MobileController = {
	enableButtons: (p1: any) -> any,
	handleHeldItem: (p1: any, p2: any) -> any,
	setCanSprint: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	openSprinting: (p1: any) -> any,
	disableButtons: (p1: any) -> any,
	openButton: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type NotificationController = {
	mouseLeave: (p1: any) -> any,
	mouseEnter: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	displayNotification: (p1: any, p2: any, p3: any) -> any,
	isHovering: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ParticleController = {
	playParticlesAtPosition: (p1: any, p2: any, p3: any) -> any,
	explodeParticlesAtPosition: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any) -> any,
	attachParticleEmitter: (p1: any, p2: any, p3: any) -> any,
	destroyParticlesNicely: (p1: any, p2: any, p3: any) -> any,
	new: (...any) -> any,
}
type PartyController = {
	getPartyId: (p1: any) -> any,
	onStart: (p1: any) -> any,
	sendOfflineInvite: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any, p3: any) -> any,
	toggleScreen: (p1: any) -> any,
	updateInvite: (p1: any, p2: any, p3: any, p4: any) -> any,
	leaveParty: (p1: any) -> any,
	promotePlayer: (p1: any, p2: any) -> any,
	invitePlayer: (p1: any, p2: any, p3: any) -> any,
	removePlayer: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type PlayerHighlightController = {
	createPlayerHighlight: (p1: any) -> any,
	constructor: (p1: any) -> any,
	playDamageHighlight: (p1: any, p2: any) -> any,
	playerThunderstormHighlight: (p1: any, p2: any) -> any,
	playIceSpikeHighlight: (p1: any, p2: any, p3: any) -> any,
	getPlayerHighlight: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type PlayerSettingsController = {
	getSetting: (p1: any, p2: any) -> any,
	onSettingChanged: (p1: any, p2: any, p3: any) -> any,
	handleProfile: (p1: any, p2: any) -> any,
	setSetting: (p1: any, p2: any, p3: any, p4: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type PlayerVelocityController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type PowerUpController = {
	hasPowerUp: (p1: any, p2: any) -> any,
	usePowerUp: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any, p3: any, p4: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type PrivateMatchController = {
	setServerName: (p1: any, p2: any) -> any,
	unbanPlayer: (p1: any, p2: any) -> any,
	joinPrivateServer: (p1: any, p2: any) -> any,
	startGame: (p1: any) -> any,
	new: (...any) -> any,
	setPlayerTeam: (p1: any, p2: any, p3: any) -> any,
	setPrivacy: (p1: any, p2: any) -> any,
	setMap: (p1: any, p2: any) -> any,
	joinTeam: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	banPlayer: (p1: any, p2: any) -> any,
	createPrivateServer: (p1: any, p2: any) -> any,
	leaveTeam: (p1: any) -> any,
	onGameStart: (p1: any) -> any,
	openCustomMatchBrowser: (p1: any) -> any,
	setGameMode: (p1: any, p2: any) -> any,
	setAllowTeamSelection: (p1: any, p2: any) -> any,
	toggleCustomMatchSettings: (p1: any) -> any,
}
type ProjectileController = {
	getPositionAtTime: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	getStrength: (p1: any, p2: any, p3: any) -> any,
	chargeBow: (p1: any, p2: any) -> any,
	playTrailEffect: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type PromotedBundleController = {
	constructor: (p1: any) -> any,
	openPromotedBundleScreen: (p1: any, p2: any) -> any,
	onLobbyStart: (p1: any, p2: any) -> any,
	getPromotedBundle: (p1: any, p2: any) -> any,
	getNewBundles: (p1: any, p2: any) -> any,
	openBundleAnnouncementScreen: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type PurchaseController = {
	promptPurchase: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	toggleGameProductPurchase: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ReportController = {
	hasReported: (p1: any, p2: any) -> any,
	submitReport: (p1: any, p2: any) -> any,
	openReport: (p1: any, p2: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type RoduxController = {
	onStart: (p1: any) -> any,
	constructor: (p1: any) -> any,
	updateQueue: (p1: any, p2: any, p3: any) -> any,
	awaitLoadedProfile: (p1: any) -> any,
	awaitReplication: (p1: any, p2: any) -> any,
	setValue: (p1: any, p2: any, p3: any) -> any,
	moveItem: (p1: any, p2: any, p3: any) -> any,
	new: (...any) -> any,
}
type ScreenController = {
	close: (p1: any, p2: any) -> any,
	closeScreenId: (p1: any, p2: any) -> any,
	save: (p1: any, p2: any) -> any,
	shouldHideCrosshair: (p1: any) -> any,
	toggle: (p1: any, p2: any) -> any,
	getOpenCount: (p1: any, p2: any) -> any,
	new: (...any) -> any,
	delete: (p1: any, p2: any) -> any,
	isHealthBarDisabled: (p1: any) -> any,
	closeFocusedScreens: (p1: any) -> any,
	open: (p1: any, p2: any, p3: any) -> any,
	constructor: (p1: any) -> any,
	isCursorLocked: (p1: any) -> any,
	isFocused: (p1: any) -> any,
	enableGamepadFocus: (p1: any, p2: any) -> any,
	disableFocus: (p1: any) -> any,
	isOpen: (p1: any, p2: any) -> any,
	enableFocus: (p1: any, p2: any) -> any,
	handleDeath: (p1: any) -> any,
	onStart: (p1: any) -> any,
}
type SoundController = {
	startSound: (p1: any, p2: any) -> any,
	playSoundAtPosition: (p1: any, p2: any, p3: any, p4: any, p5: any) -> any,
	onStart: (p1: any) -> any,
	playSound: (p1: any, p2: any, p3: any, p4: any) -> any,
	getSoundProps: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	stopSound: (p1: any, p2: any) -> any,
	playSoundAttachedToPart: (p1: any, p2: any, p3: any, p4: any) -> any,
	createSound: (p1: any, p2: any, p3: any) -> any,
	setSoundVolume: (p1: any, p2: any, p3: any) -> any,
	new: (...any) -> any,
}
type SpectatorController = {
	onStart: (p1: any) -> any,
	constructor: (p1: any) -> any,
	setSpectating: (p1: any, p2: any, p3: any) -> any,
	isSpectating: (p1: any) -> any,
	attachCamera: (p1: any, p2: any) -> any,
	detachCamera: (p1: any) -> any,
	getSpectating: (p1: any) -> any,
	handleSpectateInput: (p1: any) -> any,
	new: (...any) -> any,
}
type SprintingController = {
	getCanSprint: (p1: any) -> any,
	isSprinting: (p1: any) -> any,
	setCanSprint: (p1: any, p2: any) -> any,
	onStart: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	toggleSprinting: (p1: any) -> any,
	disableSprinting: (p1: any) -> any,
	enableSprinting: (p1: any) -> any,
	new: (...any) -> any,
}
type TeamController = {
	getPlayerTeamId: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	getPlayerTeamColour: (p1: any, p2: any) -> any,
	getTeamColour: (p1: any, p2: any) -> any,
	getPlayerTeam: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type TeleController = {
	setupTeleportGui: (p1: any) -> any,
	teleportToHub: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	isTeleporting: (p1: any) -> any,
	teleportToHubInstance: (p1: any, p2: any, p3: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type TitleController = {
	sendTitle: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type TopbarController = {
	disableTopbar: (p1: any) -> any,
	registerTopbarToggle: (p1: any, p2: any, p3: any, p4: any, p5: any, p6: any) -> any,
	enableTopbar: (p1: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type UniqueItemController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type VerificationController = {
	attemptVerification: (p1: any) -> any,
	isVerified: (p1: any) -> any,
	toggleScreen: (p1: any) -> any,
	pollVerification: (p1: any) -> any,
	constructor: (p1: any, p2: any) -> any,
	new: (...any) -> any,
}
type WinEffectController = {
	onRender: (p1: any, p2: any) -> any,
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
type ZoneController = {
	constructor: (p1: any) -> any,
	onStart: (p1: any) -> any,
	new: (...any) -> any,
}
