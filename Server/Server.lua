Calendar = {
	GiftTaken = {
		Day = {},
	},
	Restric = {
		Day = {
			[1] = true,
			[2] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
			[8] = true,
			[9] = true,
			[10] = true,
			[11] = true,
			[12] = true,
			[13] = true,
			[14] = true,
			[15] = true,
			[16] = true,
			[17] = true,
			[18] = true,
			[19] = true,
			[20] = true,
			[21] = true,
			[22] = true,
			[23] = true,
			[24] = true,
		},
	},
	Setting = {
		Items = {
			Min = 1,
			Max = 10,
		},
		Cash = {
			Min = 500,
			Max = 5000,
		},
		Weapon = {
			Min = 25,
			Max = 250,
		},
	},
}

Reward = {
	["Items"] = {
			Rwd = {
				[1] = "water",
				[2] = "weed",
				[3] = "coca",
				[4] = "pespi",
				[5] = "pizza",
				[6] = "burger",
				[7] = "pain",
				[8] = "pencil",
				[9] = "Lorum",
				[10] = "Ipsum",
			},
		},
	["Weapon"] = {
			Rwd = {
				[1] = "weapon_pistol",
				[2] = "weapon_ball",
				[3] = "weapon_rpg",
				[4] = "weapon_mg",
				[5] = "weapon_smg",
				[6] = "weapon_revolver",
				[7] = "weapon_test",
				[8] = "weapon_ntm",
				[9] = "weapon_jesais",
				[10] = "weapon_pasquoimettre",
			},
		},
}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function RandomizeReward(GiftType)
	RandomMax = 0
	for _,v in pairs (Reward[GiftType].Rwd) do
		RandomMax = RandomMax + 1
	end
	RandomIndex = math.random(1, RandomMax)
	return Reward[GiftType].Rwd[RandomIndex]
end

RegisterServerEvent("Calendar:GetDay")
AddEventHandler("Calendar:GetDay", function(DayNbr)
	xPlayer = ESX.GetPlayerFromId(source)
	if not Calendar.GiftTaken[xPlayer.identifier] then
		if not Calendar.Restric[xPlayer.identifier] then 
			Calendar.Restric[xPlayer.identifier] = Calendar.Restric
		else
			Calendar.Restric[xPlayer.identifier] = Calendar.Restric[xPlayer.identifier]
		end
		if Calendar.Restric[xPlayer.identifier].Day[DayNbr] then
			Calendar.Restric[xPlayer.identifier].Day[DayNbr] = false
		end
	end
end)

RegisterServerEvent("Calendar:GetGift")
AddEventHandler("Calendar:GetGift", function(DayNbr, GiftType)
	xPlayer = ESX.GetPlayerFromId(source)
	if not Calendar.Restric[xPlayer.identifier].Day[DayNbr] then
		if GiftType == "Items" then
			RandomItem = RandomizeReward(GiftType)
			RandomCount = math.random(Calendar.Setting.Items.Min, Calendar.Setting.Items.Max)
			print(RandomItem)
			Calendar.GiftTaken[xPlayer.identifier] = true
			--xPlayer.addInventoryItem(RandomItem, RandomCount)
		elseif GiftType == "Cash" then
			RandomCount = math.random(Calendar.Setting.Cash.Min, Calendar.Setting.Cash.Max)
			Calendar.GiftTaken[xPlayer.identifier] = true
			xPlayer.addMoney(RandomCount)
		elseif GiftType == "Weapon" then
			RandomWeapon = RandomizeReward(GiftType)
			RandomCount = math.random(Calendar.Setting.Weapon.Min, Calendar.Setting.Weapon.Max)
			Calendar.GiftTaken[xPlayer.identifier] = true
			print(RandomWeapon)
			--xPlayer.addWeapon(RandomWeapon, RandomCount)
		end
		Calendar.Restric[xPlayer.identifier].Day[DayNbr] = true
	end
end)