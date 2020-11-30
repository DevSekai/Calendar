Calendar = {
    {DayTxt = "Mardi ", DayNbr = 1, GiftType = "Weapon", Restricted = true},
    {DayTxt = "Mercredi", DayNbr = 2, GiftType = "Cash", Restricted = true},
    {DayTxt = "Jeudi", DayNbr = 3, GiftType = "Items", Restricted = true},
    {DayTxt = "Vendredi", DayNbr = 4, GiftType = "Items", Restricted = true},
    {DayTxt = "Samedi", DayNbr = 5, GiftType = "Items", Restricted = true},
    {DayTxt = "Dimanche", DayNbr = 6, GiftType = "Items", Restricted = true},
    {DayTxt = "Lundi", DayNbr = 7, GiftType = "Cash", Restricted = true},
    {DayTxt = "Mardi ", DayNbr = 8, GiftType = "Cash", Restricted = true},
    {DayTxt = "Mercredi", DayNbr = 9, GiftType = "Items", Restricted = true},
    {DayTxt = "Jeudi", DayNbr = 10, GiftType = "Cash", Restricted = true},
    {DayTxt = "Vendredi", DayNbr = 11, GiftType = "Cash", Restricted = true},
    {DayTxt = "Samedi", DayNbr = 12, GiftType = "Items", Restricted = true},
    {DayTxt = "Dimanche", DayNbr = 13, GiftType = "Cash", Restricted = true},
    {DayTxt = "Lundi", DayNbr = 14, GiftType = "Items", Restricted = true},
    {DayTxt = "Mardi ", DayNbr = 15, GiftType = "Cash", Restricted = true},
    {DayTxt = "Mercredi", DayNbr = 16, GiftType = "Items", Restricted = true},
    {DayTxt = "Jeudi", DayNbr = 17, GiftType = "Items", Restricted = true},
    {DayTxt = "Vendredi", DayNbr = 18, GiftType = "Cash", Restricted = true},
    {DayTxt = "Samedi", DayNbr = 19, GiftType = "Items", Restricted = true},
    {DayTxt = "Dimanche", DayNbr = 20, GiftType = "Items", Restricted = true},
    {DayTxt = "Lundi", DayNbr = 21, GiftType = "Cash", Restricted = true},
    {DayTxt = "Mardi", DayNbr = 22, GiftType = "Items", Restricted = true},
    {DayTxt = "Mercredi", DayNbr = 23, GiftType = "Items", Restricted = true},
    {DayTxt = "Jeudi", DayNbr = 24, GiftType = "Weapon", Restricted = true},
}

ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
end)

RMenu.Add("Calendar", "Main", RageUI.CreateMenu("", "Calendrier de l'avant", nil, nil, "root_cause", "Banner"), true)

Citizen.CreateThread( function()
    ------------------ Pour check quel jour on est, ce qui te permettra de les bloquer selon le jour
    GreatDay = nil
    year ,month ,day ,hour ,minute ,second  = GetLocalTime()
    for _,v in pairs (Calendar) do
        if day == v.DayNbr then
            v.Restricted = false
            GreatDay = day
        end
    end
    TriggerServerEvent("Calendar:GetDay", 24)
end)

Citizen.CreateThread(function ()
    ------------------ Le menu
    while true do
        Citizen.Wait(0)

        if IsControlJustReleased(1, 51) then
            RageUI.Visible(RMenu:Get("Calendar", "Main"), not RageUI.Visible(RMenu:Get("Calendar", "Main")))
        end

        RageUI.IsVisible(RMenu:Get("Calendar", "Main"), function()
            for _,v in pairs (Calendar) do
                -- Sert toi de if v.Restricted pour le bloqué
                RageUI.Item.Button(v.DayTxt.." "..v.DayNbr, "", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('Calendar:GetGift', 24, v.GiftType) -- Tu renvoie le jour, pour pouvoir le bloquer coter serveur, si y a pas de reboot entre deux jour
                    end,
                })
            end
        end)
    end
end)