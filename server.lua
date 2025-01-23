ESX = exports["es_extended"]:getSharedObject()
local allowedGroups = { "support", "admin", "master" }

CreateThread(function ()
    while true do
        print("Sto per deletare tutti i ped del cazzo che sono morti in giro per il mondo")

        local allPeds = GetGamePool("CPed")
        local counter = 0
        for i = 1, #allPeds do
            local this = allPeds[i]

            if IsPedAPlayer(this) then
                goto skip
            end

            if GetEntityHealth(this) then
                goto skip
            end

            DeleteEntity(this)
            counter = counter + 1

            ::skip::
        end
        print("Ho mandato a fanculo ["..counter.."] entità")

        Wait(180000)
    end
end)

RegisterCommand("purga", function (source, args)
    local group = ESX.GetPlayerFromId(source).getGroup()
    local allowed = false
    for i = 1, #allowedGroups do
        if allowedGroups[i] == group then
            allowed = true
        end
    end
    if not allowed then return end

    local range = tonumber(args[1])
    local coords = GetEntityCoords(GetPlayerPed(source))
    if range == nil or range > 20 then
        range = 20
    end

    local allPeds = GetGamePool("CPed")
    local counter = 0
    local arr = {}
    for i = 1, #allPeds do
        local this = allPeds[i]

        if IsPedAPlayer(this) then
            goto skip
        end

        if #(GetEntityCoords(this) - coords) <= range then
            DeleteEntity(this)
            counter = counter + 1
        end



        ::skip::
    end

    print("Ho mandato a fanculo ["..counter.."] entità")
end, false)