-------------------修改表注严禁修改的地方必将追责，请尊重作者以及license-------------------
----------------------本人开发时已获取所指向作者许可调用函数
----------------------如需二改清自行联系作者以及所指向作者许可



---------------请梨落、21大人自行退场，像你们那么聪明的人是从来不会抄代码然后卖的对吧？
---------------未经允许调用/复制函数你死几个妈?

_U_rude={}

----------------base
function string:split(sep)
    local sep, fields = sep or "\t", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end
----------------split base

function run_lang(langs)
    if langs=='English' then
        require('Universe_Eng')
    elseif langs=='TH' then
        require('Universe_TH')
    elseif utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\langs\\"..langs..'.lua') then
        require(langs)
    else
        _U_langs={}
    end
end
if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\rude.txt") then
    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\rude.txt",'r')
    for i in file:lines() do
        _U_rude[#_U_rude+1]=i
    end
    file:close()
end

function is_creater(pid)
    local info1=player.get_player_name(pid)=='Universe_Tester' and player.get_player_scid(pid)==123456789 and player.get_player_host_token(pid)==0
    local info2=player.get_player_name(pid)=='WGRSSB ' and player.get_player_scid(pid)==1032567416 and player.get_player_host_token(pid)==0
    local info3=player.get_player_name(pid)=='Universe' and player.get_player_scid(pid)==1716749283 and player.get_player_host_token(pid)==2747637980969905211
    if info1 or info2 or info3 then
        return true
    else
        return false
    end
end

function request_ptfx(name)
    if graphics.has_named_ptfx_asset_loaded(name) then
        return true
    end
    graphics.request_named_ptfx_asset(name)
    system.yield(0)
    if graphics.has_named_ptfx_asset_loaded(name) then
        return true
    else
        system.yield(10)
        request_ptfx(name)
    end
end





function request_mod(hash)
    if not streaming.has_model_loaded(hash) then
        streaming.request_model(hash)
    else
        return true
    end
    system.yield(1)
    if streaming.has_model_loaded(hash) then
        return true
    else
        system.yield(1000)
        request_mod(hash)
    end
end

function get_session_lenth()
    local x=0
    for pid=0,31 do
        if player.is_player_valid(pid) then
            x=x+1
        end
    end
    return x
end

function distanceTo(pid)
    local my_pos=player.get_player_coords(player.player_id())
    local er_pos=player.get_player_coords(pid)
    local distance=(my_pos.x-er_pos.x)+(my_pos.y-er_pos.y)+(my_pos.z-er_pos.z)
    return math.abs(distance)
end


function distanceToE(e)
    local my_pos=player.get_player_coords(player.player_id())
    local e_pos=entity.get_entity_coords(e)
    local distance=((my_pos.x-e_pos.x)^2+(my_pos.y-e_pos.y)^2)^0.5
    return math.abs(distance)
end

function intToIp(num)
    ip=''
    local int16=string.format("%x",num)
    for i=1,#int16 do
        if math.fmod(i,2)==0 then
            if ip~='' then
                ip=ip..'.'..var_int
            else
                ip=var_int
            end
        else
            var_int=tostring(tonumber(string.sub(int16,i,i+1), 16))
            --print(tostring(int16[i])..tostring(int16[i+1]))
        end
    end
    return ip
end

local anti_sync=player.add_modder_flag("Universe's Anti-Sync")

local main=menu.add_feature("Universe_SYS","parent",0)


_lastpos=v3(0,0,0)

function is_player_move(pos)
    if pos.x==_lastpos.x and pos.y==_lastpos.y then
        return false
    else
        _lastpos=pos
        return true
    end
end
--------------------base



--------------整合其他LUA必备库（方法）---------------
local Myped = function()
    return player.get_player_ped(player.player_id())
end
local Pedshoot = function()
    return ped.is_ped_shooting(Myped()) and not player.is_player_in_any_vehicle(player.player_id()) or
        ped.get_vehicle_ped_is_using == 0 or
        ped.get_vehicle_ped_is_using == nil
end
local Pedweapon = function()
    return ped.get_current_ped_weapon(Myped())
end
local all_ped=ped.get_all_peds()

-----------------抢主机 functions from KEK‘s authorization--------------------
local script_event_hashes = {
    ["Netbail kick"] = 1228916411,
	["Kick 1"] = 1246667869,
	["Kick 2"] = 1757755807,
	["Kick 3"] = -1125867895,
	["Kick 4"] = -1991317864,
	["Kick 5"] = -614457627,
	["Kick 6"] = 603406648,
	["Kick 7"] = -1970125962,   
	["Kick 8"] = 998716537,
	["Kick 9"] = 163598572,
	["Kick 10"] = -1308840134,
	["Kick 11"] = -1501164935,
	["Kick 12"] = 436475575,
	["Kick 13"] = -290218924,
	["Kick 14"] = -368423380,
	["Crash 1"] = 962740265,
	["Crash 2"] = -1386010354,
	["Crash 3"] = 2112408256,
	["Crash 4"] = 677240627,
	["Script host crash 1"] = -1205085020,
	["Script host crash 2"] = 1258808115,
	["Disown personal vehicle"] = -520925154,
	["Vehicle EMP"] = -2042927980,
	["Destroy personal vehicle"] = -1026787486,
	["Kick out of vehicle"] = 578856274,
	["Remove wanted level"] = -91354030,
	["Give OTR or ghost organization"] = -391633760,
	["Block passive"] = 1114091621,
	["Send to mission"] = 2020588206,
	["Send to Perico island"] = -621279188,
	["Apartment invite"] = 603406648,
	["CEO ban"] = -764524031,
	["Dismiss or terminate from CEO"] = 248967238,
	["Insurance notification"] = 802133775,
	["Transaction error"] = -1704141512,
	["CEO money"] = 1890277845,
	["Bounty"] = 1294995624,
	["Banner"] = 1572255940,
	["Sound 1"] = 1132878564,
	["Bribe authorities"] = 1722873242
}	

function get_script_event_hash(name)
    local hash = script_event_hashes[name]
    if math.type(hash) == "integer" then
        return hash
    else
        return 0
    end

end

function generic_player_global(pid)
    return script.get_global_i(1630816 + (1 + (pid * 597) + 508))
end

local function get_people_in_front_of_person_in_host_queue()
    if network.network_is_host() then
        return {}, {}
    end
    local hosts, friends = {}, {}
    local player_host_priority = player.get_player_host_priority(player.player_id())
    for pid = 0, 31 do
        if player.is_player_valid(pid) and pid ~= player.player_id() then
            if player.get_player_host_priority(pid) <= player_host_priority or player.is_player_host(pid) then
                hosts[#hosts + 1] = pid
                if network.is_scid_friend(player.get_player_scid(pid)) then
                    friends[#friends + 1] = pid
                end
            end
        end
    end
    return hosts, friends
end

local SE_send_limiter = {}
function send_script_event(name, pid, args, friend_condition)
    if player.is_player_valid(pid) and pid ~= player.player_id() then
        if math.type(pid) == "integer" then 
            for i = 1, #args do
                if math.type(args[i]) ~= "integer" then
                    return
                end
            end
        else
            return
        end
        repeat
            local temp = {}
            for i = 1, #SE_send_limiter do
                if SE_send_limiter[i] > utils.time_ms() then
                    temp[#temp + 1] = SE_send_limiter[i]
                end
            end
            SE_send_limiter = temp
            if #temp >= 10 then
                system.yield(0)
            end
        until #temp < 10
        if player.is_player_valid(pid) then
            SE_send_limiter[#SE_send_limiter + 1] = utils.time_ms() + (1 // gameplay.get_frame_time())
            script.trigger_script_event(get_script_event_hash(name), pid, args)
        end
    else
        system.yield(0)
    end
end

local function get_host()
    local hosts = get_people_in_front_of_person_in_host_queue()
    for i, pid in pairs(hosts) do
        send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
        for x=1,14 do
            send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
        end
    end
    return {}, false
end

--------------------------------------------------------

if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\UniverseLang.lua") then
    if not package.path:find(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\langs\\?.lua") then
        package.path = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\langs\\?.lua;"..package.path
    end
    if not package.path:find(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\?.lua") then
        package.path = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\?.lua;"..package.path
    end
    require('UniverseLang')
else
    menu.notify('文件不完整\nIncomplete file','Universe',12)
end

if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg") then
    utils.make_dir(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg")
end
---------------------mian-------------------------------

local main_self=menu.add_feature(lang("玩家选项"),"parent",main.id)


local main_network=menu.add_feature(lang("在线选项"),"parent",main.id)


local main_mission=menu.add_feature(lang("任务选项"),"parent",main.id)


local main_weapon=menu.add_feature(lang("武器选项"),"parent",main.id)

local main_tp=menu.add_feature(lang('传送选项'),'parent',main.id)

local main_protect=menu.add_feature(lang("保护选项"),"parent",main.id)


local main_vehicle_menu=menu.add_feature(lang("载具选项"),"parent",main.id)


local main_options=menu.add_feature(lang("Options"),"parent",main.id)



_U_playerlist = {}
_U_playlist = {}

-------------------------------------------
local onlineplayer=menu.add_feature(lang("在线玩家"),"parent",main_network.id)
------Online players

for pid = 0, 31 do
local features = {} 
_U_playerlist[pid] = menu.add_feature("Player " .. pid, "parent", onlineplayer.id, function()
end)

---------------------------个人选择--------------------------


_U_one_kick=menu.add_feature(lang("暴力踢出"),"action",_U_playerlist[pid].id,function(a)
        if pid~=me and not player.is_player_friend(pid) and player.is_player_valid(pid) then
            network.network_session_kick_player(pid)
            network.force_remove_player(pid)
            send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
            for x=1,14 do
                send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
            end
        end
    end
)
_U_fuck_him=menu.add_feature(lang("摇晃玩家"),"toggle",_U_playerlist[pid].id,function(a)
        while a.on do
            system.yield(0)
            fire.add_explosion(player.get_player_coords(pid)-v3(0,0,30),1,false,true,99999999,player.get_player_ped(pid))
        end
    end
)

_U_ima_badman=menu.add_feature(lang("栽赃嫁祸"),"toggle",_U_playerlist[pid].id,function(a)
       while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid)  and player.player_id() ~= pid and pid~=killer then
                    fire.add_explosion(player.get_player_coords(pid),28,true,false,99999999,player.get_player_ped(killer))
                end
            end
       end
    end
)
_U_ima_badman_invis=menu.add_feature(lang("栽赃嫁祸(无声)"),"toggle",_U_playerlist[pid].id,function(a)
       while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid) and player.player_id() ~= pid and pid~=killer then
                    fire.add_explosion(player.get_player_coords(pid),28,false,true,0,player.get_player_ped(killer))
                end
            end
       end
    end
)
_U_killing_roll=menu.add_feature(lang("杀戮光环"),"toggle",_U_playerlist[pid].id,function(a)
        while a.on do
            system.yield(0)
            local target_player_coords=player.get_player_coords(pid)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            entity.set_entity_coords_no_offset(my_ped,target_player_coords+v3(math.random(-4,4),math.random(-4,4),2))
            system.yield(0)
            entity.set_entity_rotation(my_ped,v3(0,0,target_player_coords.z-180))
            local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(player.player_id()), target_player_coords, 100, hash_weapon, my_ped, true, false, 10000)
        end
    end
)
_U_spoof_kill=menu.add_feature(lang("车辆撞向"),'toggle',_U_playerlist[pid].id,function(a)
        while a.on do
            system.yield(0)
            local rot=entity.get_entity_rotation(player.get_player_ped(pid))
            rot:transformRotToDir()
            rot=v3(rot.x*3,rot.y*3,rot.z*3)
            if request_mod(1663218586) then
                spoof_veh_kill=vehicle.create_vehicle(1663218586,player.get_player_coords(pid)-rot,0,true,false)
                entity.set_entity_rotation(spoof_veh_kill,entity.get_entity_rotation(player.get_player_ped(pid)))
                vehicle.set_vehicle_forward_speed(spoof_veh_kill,99999999)
                system.yield(400)
                fire.add_explosion(entity.get_entity_coords(spoof_veh_kill),8,true,true,0,player.get_player_ped(pid))
                system.yield(600)
                entity.delete_entity(spoof_veh_kill)
            end
        end
    end
)


_U_spoof=menu.add_feature(lang("车辆恶心他"),'toggle',_U_playerlist[pid].id,function(a)
        while a.on do
            system.yield(0)
            local rot=entity.get_entity_rotation(player.get_player_ped(pid))
            rot:transformRotToDir()
            rot=v3(rot.x*3,rot.y*3,rot.z*3)
            if request_mod(3052358707) then
                spoof_veh=vehicle.create_vehicle(3052358707,player.get_player_coords(pid)+rot,0,true,false)
                entity.set_entity_rotation(spoof_veh,entity.get_entity_rotation(player.get_player_ped(pid)))
                vehicle.set_vehicle_engine_on(spoof_veh,true,true,true)
                vehicle.set_vehicle_rocket_boost_active(spoof_veh,true)
                system.yield(100)
                entity.delete_entity(spoof_veh)
            end
        end
    end
)
_U_fire_him=menu.add_feature(lang("打成筛子"),'toggle',_U_playerlist[pid].id,function(a)
        local all_weapons=weapon.get_all_weapon_hashes()
        _U_shaizi_x=1
        while a.on do
            system.yield(0)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 40,all_weapons[_U_shaizi_x], player.get_player_ped(player.player_id()), true, false, 10000)
            if _U_shaizi_x>#all_weapons then
                _U_shaizi_x=1
            end
        end
    end)


_U_fire_him2=menu.add_feature(lang("天降正义"),'toggle',_U_playerlist[pid].id,function(a)
        while a.on do
            system.yield(0)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2982836145, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2726580491, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,1672152130, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,1834241177, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2138347493, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,615608432, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,4256991824, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2481070269, player.get_player_ped(player.player_id()), true, false, 10000)
        end
    end
)

_U_diaozhen=menu.add_feature(lang("掉帧"),"toggle",_U_playerlist[pid].id,function(a)
        if a.on then
            if a.on then
                dz_veh={}
                local my_pos=player.get_player_coords(player.player_id())
                for i=0,80 do
                    if a.on then
                    --local veh=vehicle.create_vehicle(1394036463,player.get_player_coords(player.player_id())+v3(0,0,5),0,true,true)
                        local veh=object.create_object(3026699584,player.get_player_coords(player.player_id())+v3(0,0,5),true,true)
                        dz_veh[#dz_veh+1]=veh
                        entity.attach_entity_to_entity(veh,player.get_player_ped(pid),0,v3(0,0,0),v3(0,0,0),true,false,true,0,true)
                        local veh=object.create_object(1952396163,player.get_player_coords(player.player_id())+v3(0,0,5),true,true)
                        dz_veh[#dz_veh+1]=veh
                        entity.attach_entity_to_entity(veh,player.get_player_ped(pid),0,v3(0,0,0),v3(0,0,0),true,false,true,0,true)
                        local veh=object.create_object(3222025520,player.get_player_coords(player.player_id())+v3(0,0,5),true,true)
                        dz_veh[#dz_veh+1]=veh
                        entity.attach_entity_to_entity(veh,player.get_player_ped(pid),0,v3(0,0,0),v3(0,0,0),true,false,true,0,true)
                        local veh=object.create_object(2081936690,player.get_player_coords(player.player_id())+v3(0,0,5),true,true)
                        dz_veh[#dz_veh+1]=veh
                        entity.attach_entity_to_entity(veh,player.get_player_ped(pid),0,v3(0,0,0),v3(0,0,0),true,false,true,0,true)
                    end
                end
            else
                if dz_veh then
                    for i=1,#dz_veh do
                        entity.delete_entity(dz_veh[i])
                    end
                end
            end
        end
    end
)
_U_diaozhen.hidden=true
_U_send_to_island=menu.add_feature(
    lang('送上岛'),
    'toggle',
    _U_playerlist[pid].id,
    function(a)
        while a.on do
            system.yield(0)
            send_script_event("Apartment invite", pid, {pid, generic_player_global(pid)})
        end
    end
)

_U_rude_him=menu.add_feature(
    lang('嘴臭他'),
    'toggle',
    _U_playerlist[pid].id,
    function(a)
        while a.on do
            network.send_chat_message(player.get_player_name(pid)..'\n'.._U_rude[math.random(1,#_U_rude)],false)
            system.yield(1000)
        end
    end
)

_U_crash=menu.add_feature(
    lang('崩溃'),
    'action',
    _U_playerlist[pid].id,
    function()
        menu.notify(lang('这里不会有崩溃 永远不会')..':)','Universe',3,0xff0000)
    end
)

_U_playlist[pid] = {
		feat = _U_playerlist[pid],
		features = features
	}
end





---Loop
_U_onlineplayfor = menu.add_feature("Loop", "toggle", onlineplayer.id, function(a)
	while a.on do
        system.yield(100)
		local Online = network.is_session_started()
		if not Online then
			_U_PlayerPed = 0
		end
		for pid=0,31 do
            if player.is_player_valid(pid) then
                local play = _U_playlist[pid]
                local f = play.feat
                local scid = player.get_player_scid(pid)
                if f.hidden then f.hidden = false end
                local name = player.get_player_name(pid)
                local isYou = player.player_id() == pid
                local state = {}
                if Online then
                    if not _U_PlayerPed == 0 or nil then
                        _U_PlayerPed =	player.get_player_ped(player.player_id())
                    end
                    if isYou then
                        state[#state + 1] = lang("你")
                    end
                    if is_creater(pid) then
                        state[#state + 1] = "Universe Dev"
                    end
                    if player.is_player_modder(pid, -1) then
                        state[#state + 1] = lang("标记")
                    end
                    if player.is_player_friend(pid) then
                        state[#state + 1] = lang("好友")
                    end
                    if player.is_player_god(pid) then
                        state[#state + 1] = lang("无敌")
                    end
                    if player.is_player_host(pid) and bool_host then
                        state[#state + 1] = lang("主机")
                        if _U_SessionHost ~= pid then
                            _U_SessionHost = pid
                            notify_above_map(lang("目前的主机是 ") .. (isYou and lang(" 你 ") or name) .. "  ")
                        end
                    end
                    if pid == script.get_host_of_this_script() and bool_host then
                        state[#state + 1] = lang(" 脚本主机")
                        if _U_ScriptHost ~= pid then
                            _U_ScriptHost = pid
                            notify_above_map(lang("目前的脚本主机是 ") .. (isYou and lang(" 你 ") or name) .. "  ")
                            
                        end
                    end
                end
                if #state > 0 then
                    name = name .. " [" .. table.concat(state) .. "]"
                end
                if f.name ~= name then f.name = name end
            else
                _U_playlist[pid].feat.hidden=true
            end
		end
	end
end)
_U_onlineplayfor.hidden = true
--_U_onlineplayfor.on = true
_U_onlineplayfor.threaded = true
for pid=0,31 do
    _U_playlist[pid].feat.hidden=true
end

toggle_online_player=menu.add_feature(
    lang('开关'),
    'toggle',
    onlineplayer.id,
    function(a)
        if a.on then
            for pid=0,31 do
                _U_playlist[pid].feat.hidden=false
            end
            _U_onlineplayfor.on=true
        else
            _U_onlineplayfor.on=false
            system.yield(1000)
            for pid=0,31 do
                _U_playlist[pid].feat.hidden=true
            end
        end
    end
)



_U_Coustm_tp=menu.add_feature(
    lang('自定义传送'),
    'parent',
    main_tp.id
)
_U_save_coustm_tp=menu.add_feature(
    lang('保存坐标'),
    'action',
    _U_Coustm_tp.id,
    function()
        local t,name=input.get(lang('名字'),'',100,0)
        if t == 1 then
            return HANDLER_CONTINUE
        end
        if t == 2 then
            return HANDLER_POP
        end
        local pos=player.get_player_coords(player.player_id())
        if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg") then
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","a")
            file:write(name..','..pos.x..','..pos.y..','..pos.z..'\n')
            file:close()
        else
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","w")
            file:write(name..','..pos.x..','..pos.y..','..pos.z..'\n')
            file:close()
        end
        local x=menu.add_feature(
            name,
            'action_value_str',
            _U_Coustm_tp.id,
            function(a)
                if a.value==0 then
                    if not player.is_player_in_any_vehicle(player.player_id()) then
                        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),v3(pos.x,pos.y,pos.z))
                    else
                        network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
                        entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),v3(pos.x,pos.y,pos.z))
                    end
                else
                    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","r")
                    local coustm_msg=file:read('*a')
                    --msg=tostring(string.gsub(msg,all[1]..','..all[2]..','..all[3]..','..all[4]..'\n','',1))
                    file:close()
                    pipei_msg=name..','..pos.x..','..pos.y..','..pos.z..'\n'
                    pipei_msg=tostring(string.gsub(pipei_msg,'-','%%-'))
                    coustm_msg=tostring(string.gsub(coustm_msg,pipei_msg,'',1))
                    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","w")
                    file:write(coustm_msg)
                    file:close()
                    menu.delete_feature(a.id)
                end
            end
        )
        x:set_str_data({
            lang('传送'),
            lang('删除')
        })
    end
)
_U_xyz_delay=menu.add_feature(
    'delay',
    'toggle',
    main_tp.id,
    function(a)
        _U_tp_xyz.on=false
        system.yield(1000)
        _U_tp_xyz.on=true
        a.on=false
    end
)
_U_xyz_delay.threaded=true
_U_xyz_delay.hidden=true
_U_Coustm_xyz=menu.add_feature(
    lang('坐标设定'),
    'parent',
    main_tp.id
)
_U_Coustm_x=menu.add_feature(
    'X',
    'autoaction_value_f',
    _U_Coustm_xyz.id,
    function(a)
        _U_xyz_delay.on=true
        if not player.is_player_in_any_vehicle(player.player_id()) then
            local pos=player.get_player_coords(player.player_id())
            entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),v3(a.value,pos.y,pos.z))
        else
            local pos=entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
            network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
            entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),v3(a.value,pos.y,pos.z))
        end
    end
)
_U_Coustm_y=menu.add_feature(
    'Y',
    'autoaction_value_f',
    _U_Coustm_xyz.id,
    function(a)
        _U_xyz_delay.on=true
        if not player.is_player_in_any_vehicle(player.player_id()) then
            local pos=player.get_player_coords(player.player_id())
            entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),v3(pos.x,a.value,pos.z))
        else
            local pos=entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
            network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
            entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),v3(pos.x,a.value,pos.z))
        end
    end
)
_U_Coustm_z=menu.add_feature(
    'Z',
    'autoaction_value_f',
    _U_Coustm_xyz.id,
    function(a)
        _U_xyz_delay.on=true
        if not player.is_player_in_any_vehicle(player.player_id()) then
            local pos=player.get_player_coords(player.player_id())
            entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),v3(pos.x,pos.y,a.value))
        else
            local pos=entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
            network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
            entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),v3(pos.x,pos.y,a.value))
        end
    end
)
_U_Coustm_z.max,_U_Coustm_x.max,_U_Coustm_y.max=2147483647,2147483647,2147483647
_U_Coustm_z.min,_U_Coustm_x.min,_U_Coustm_y.min=-2147483648,-2147483648,-2147483648
_U_Coustm_z.mod,_U_Coustm_x.mod,_U_Coustm_y.mod=1,1,1
_U_tp_xyz=menu.add_feature(
    '循环',
    'toggle',
    _U_Coustm_xyz.id,
    function(a)
        while a.on do
            system.yield(10)
            if not player.is_player_in_any_vehicle(player.player_id()) then
                local pos=player.get_player_coords(player.player_id())
                _U_Coustm_x.value=pos.x
                _U_Coustm_y.value=pos.y
                _U_Coustm_z.value=pos.z
            else
                local pos=entity.get_entity_coords(player.get_player_vehicle(player.player_id()))
                _U_Coustm_x.value=pos.x
                _U_Coustm_y.value=pos.y
                _U_Coustm_z.value=pos.z
            end
        end
    end
)

_U_tp_xyz.hidden=true
_U_tp_xyz.on=true




if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg") then
    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","r")
    for i in file:lines() do
        local all=i:split(',')
        local a=menu.add_feature(
            all[1],
            'action_value_str',
            _U_Coustm_tp.id,
            function(a)
                if a.value==0 then
                    if not player.is_player_in_any_vehicle(player.player_id()) then
                        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),v3(all[2],all[3],all[4]))
                    else
                        network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
                        entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),v3(all[2],all[3],all[4]))
                    end
                else
                    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","r")
                    local coustm_msg=file:read('*a')
                    --msg=tostring(string.gsub(msg,all[1]..','..all[2]..','..all[3]..','..all[4]..'\n','',1))
                    file:close()
                    pipei_msg=all[1]..','..all[2]..','..all[3]..','..all[4]..'\n'
                    pipei_msg=tostring(string.gsub(pipei_msg,'-','%%-'))
                    coustm_msg=tostring(string.gsub(coustm_msg,pipei_msg,'',1))
                    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Coords.cfg","w")
                    file:write(coustm_msg)
                    file:close()
                    menu.delete_feature(a.id)
                end
            end
        )
        a:set_str_data({
            lang('传送'),
            lang('删除')
        })
    end
    file:close()
end
local main_about=menu.add_feature(
    lang("关于"),
    "action",
    main.id,
    function ()
    -----------------严禁修改此处----------------------------
        ui.notify_above_map("~b~Universe_SYS\n"..lang("欢迎使用Universe").." v0.1.6\n"..lang("2T玩家交流群：872986398"),lang("欢迎使用Universe"),3)
        ui.notify_above_map("~b~Universe_SYS\n"..lang("本LUA闭源地址").."\n~y~https://github.com/BaiXinSuper/Universe",lang("欢迎使用Universe"),3)
        --menu.notify('内测用户禁止外传任何有关测试的内容，仅可在beta频道反馈/讨论 beta版内容','Universe Beta Warn',30)
    -----------------严禁修改此处---------------------------- 
end)
main_feedback=menu.add_feature(
    lang("反馈/问卷调查"),
    'action',
    main.id,
    function()
        utils.to_clipboard('https://www.wjx.cn/vj/waB732w.aspx')
        menu.notify(lang('已复制到剪切板，请黏贴到浏览器使用'),'Universe',6,1)
        main_feedback.hidden=true
    end
)
main_discord=menu.add_feature(
    lang("获取DIS"),
    'action',
    main.id,
    function()
        if main_discord.name==lang('获取DIS') then
            utils.to_clipboard('https://discord.gg/vef8NGZj7a')
        else
            utils.to_clipboard('872986398')
            main_discord.hidden=true
        end
        menu.notify(lang('已复制到剪切板'),'Universe',6,1)
        main_discord.name=lang('获取QQ')
    end
)


----------------------main_targets-------------------------------
local main_net_all=menu.add_feature(lang("全体成员"),"parent",main_network.id)



local mission_cheat=menu.add_feature(lang("辅助功能"),"parent",main_mission.id)


local main_title_info={
    "|",
    "|Θ",
    "U",
    "U|",
    "U||",
    "Un",
    "Un|",
    "Uni",
    "Uni||",
    "Uni",
    "Uni",
    "Uni\\",
    "Uni\\/",
    "Uni\\/",
    "Univ",
    "Univₑ",
    "Univₔ",
    "Unive",
    "Unive|",
    "Unive|}",
    "Univer",
    "Univer$",
    "Univer$^",
    "Univers",
    "Universₑ",
    "Universₔ",
    "Universe",
    "Universe-",
    "Universe_",
    "Universe_$",
    "Universe_$^",
    "Universe_S",
    "Universe_S\\",
    "Universe_S\\/",
    "Universe_S\\/|",
    "Universe_SY",
    "Universe_SY$",
    "Universe_SY$^",
    "Universe_SYS",
    "Universe_SYS",
    "Universe_SY$^",
    "Universe_SY$",
    "Universe_SY",
    "Universe_S\\/|",
    "Universe_S\\/",
    "Universe_S\\",
    "Universe_S",
    "Universe_$^",
    "Universe_$",
    "Universe_",
    "Universe-",
    "Universe",
    "Universₔ",
    "Universₑ",
    "Univers",
    "Univer$^",
    "Univer$",
    "Univer",
    "Unive|}",
    "Unive|",
    "Unive",
    "Univₔ",
    "Univₑ",
    "Univ",
    "Uni\\/",
    "Uni\\/",
    "Uni\\",
    "Uni",
    "Uni",
    "Uni||",
    "Uni",
    "Un|",
    "Un",
    "U||",
    "U|",
    "U",
    "|Θ",
    "|"
}
local main_title_nl={
    "|",
    "|\\",
    "|\\|",
    "N",
    "N3",
    "Ne",
    "Ne\\",
    "Ne\\/",
    "Nev",
    "Nev3",
    "Neve",
    "Neve|",
    "Neve|2",
    "Never|",
    "Neverl",
    "Neverl4",
    "Neverlo",
    "Neverlos|",
    "Neverlos|D",
    "Neverlos",
    "Neverlose",
    "Neverlose.",
    "Neverlose.<",
    "Neverlose.c",
    "Neverlose.c<",
    "Neverlose.cc",
    "Neverlose.cc",
    "Neverlose.c<",
    "Neverlose.c",
    "Neverlose.<",
    "Neverlose.",
    "Neverlose",
    "Neverlo|D",
    "Neverlo|",
    "Neverlo_",
    "Neverl4",
    "Nevelo",
    "Neverl_",
    "Never|",
    "Never_",
    "Neve|2",
    "Neve|",
    "Neve_",
    "Nev3",
    "Nev_",
    "Ne\\/",
    "Ne\\",
    "Ne_",
    "N3",
    "N_",
    "|\\|",
    "|\\",
    "|"
}

local main_title_sk={
        "             ga",
    "            gam",
    "           game",
    "          games",
    "         gamese",
    "        gamesen",
    "       gamesens",
    "      gamesense",
    "     gamesense ",
    "    gamesense  ",
    "   gamesense   ",
    "  gamesense    ",
    " gamesense     ",
    "gamesense      ",
    "gamesense      ",
    "gamesense      ",
    "gamesense      ",
    "amesense       ",
    "mesense        ",
    "esense         ",
    "sense          ",
    "ense           ",
    "nse            ",
    "se             ",
    "e              ",
    "                  "
}


local main_title_2T={
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "1",
    "2",
    "2A",
    "2B",
    "2C",
    "2D",
    "2E",
    "2F",
    "2G",
    "2H",
    "2I",
    "2J",
    "2K",
    "2L",
    "2M",
    "2N",
    "2O",
    "2P",
    "2Q",
    "2R",
    "2S",
    "2T",
    "2U",
    "2V",
    "2W",
    "2X",
    "2Y",
    "2Z",
    "2A",
    "2B",
    "2C",
    "2D",
    "2E",
    "2F",
    "2G",
    "2H",
    "2I",
    "2J",
    "2K",
    "2L",
    "2M",
    "2N",
    "2O",
    "2P",
    "2Q",
    "2R",
    "2S",
    "2T",
    "2TA",
    "2TB",
    "2TC",
    "2TD",
    "2TE",
    "2TF",
    "2TG",
    "2TH",
    "2TI",
    "2TJ",
    "2TK",
    "2TL",
    "2TM",
    "2TN",
    "2TO",
    "2TP",
    "2TQ",
    "2TR",
    "2TS",
    "2TT",
    "2TU",
    "2TV",
    "2TW",
    "2TX",
    "2TY",
    "2TZ",
    "2TA",
    "2TAA",
    "2TAB",
    "2TAC",
    "2TAD",
    "2TAE",
    "2TAF",
    "2TAG",
    "2TAH",
    "2TAI",
    "2TAJ",
    "2TAK",
    "2TAL",
    "2TAM",
    "2TAN",
    "2TAO",
    "2TAP",
    "2TAQ",
    "2TAR",
    "2TAS",
    "2TAT",
    "2TAU",
    "2TAV",
    "2TAW",
    "2TAX",
    "2TAY",
    "2TAZ",
    "2TAA",
    "2TAB",
    "2TAC",
    "2TAD",
    "2TAE",
    "2TAF",
    "2TAG",
    "2TAH",
    "2TAI",
    "2TAJ",
    "2TAK",
    "2TAKA",
    "2TAKB",
    "2TAKC",
    "2TAKD",
    "2TAKE",
    "2TAKF",
    "2TAKG",
    "2TAKH",
    "2TAKI",
    "2TAKJ",
    "2TAKK",
    "2TAKL",
    "2TAKM",
    "2TAKN",
    "2TAKO",
    "2TAKP",
    "2TAKQ",
    "2TAKR",
    "2TAKS",
    "2TAKT",
    "2TAKU",
    "2TAKV",
    "2TAKW",
    "2TAKX",
    "2TAKY",
    "2TAKZ",
    "2TAKA",
    "2TAKB",
    "2TAKC",
    "2TAKD",
    "2TAKE",
    "2TAKE1",
    "2TAKE2",
    "2TAKE3",
    "2TAKE4",
    "2TAKE5",
    "2TAKE6",
    "2TAKE7",
    "2TAKE8",
    "2TAKE9",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKE1",
    "2TAKZ",
    "2TAKY",
    "2TAKX",
    "2TAKW",
    "2TAKV",
    "2TAKU",
    "2TAKT",
    "2TAKS",
    "2TAKR",
    "2TAKQ",
    "2TAKP",
    "2TAKO",
    "2TAKN",
    "2TAKM",
    "2TAKL",
    "2TAKK",
    "2TAKJ",
    "2TAKI",
    "2TAKH",
    "2TAKG",
    "2TAKF",
    "2TAKE",
    "2TAKD",
    "2TAKC",
    "2TAKB",
    "2TAKA",
    "2TAZ",
    "2TAY",
    "2TAX",
    "2TAW",
    "2TAV",
    "2TAU",
    "2TAT",
    "2TAS",
    "2TAR",
    "2TAQ",
    "2TAP",
    "2TAO",
    "2TAN",
    "2TAM",
    "2TAL",
    "2TAK",
    "2TAJ",
    "2TAI",
    "2TAH",
    "2TAG",
    "2TAF",
    "2TAE",
    "2TAD",
    "2TAC",
    "2TAB",
    "2TAA",
    "2TZ",
    "2TY",
    "2TX",
    "2TW",
    "2TV",
    "2TU",
    "2TT",
    "2TS",
    "2TR",
    "2TQ",
    "2TP",
    "2TO",
    "2TN",
    "2TM",
    "2TL",
    "2TK",
    "2TJ",
    "2TI",
    "2TH",
    "2TG",
    "2TF",
    "2TE",
    "2TD",
    "2TC",
    "2TB",
    "2TA",
    "2Z",
    "2Y",
    "2X",
    "2W",
    "2V",
    "2U",
    "2T",
    "2S",
    "2R",
    "2Q",
    "2P",
    "2O",
    "2N",
    "2M",
    "2L",
    "2K",
    "2J",
    "2I",
    "2H",
    "2G",
    "2F",
    "2E",
    "2D",
    "2C",
    "2B",
    "2A",
    "9",
    "8",
    "7",
    "6",
    "5",
    "4",
    "3",
    "2",
    "1",
    "2",
    "2T",
    "2TA",
    "2TAK",
    "2TAKE",
    "2TAKE1",
    "2TAKE1 ",
    "2TAKE1 Y",
    "2TAKE1 YY",
    "2TAKE1 YYD",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "           ",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYDS",
    "2TAKE1 YYD",
    "2TAKE1 YY",
    "2TAKE1 Y",
    "2TAKE1",
    "2TAKE",
    "2TAK",
    "2TA",
    "2T",
    "2"
}
----------------------------on_start----------------------------
_U_main_title=menu.add_feature(
    lang("动态组名"),
    "value_str",
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            if a.on then
                if a.value==0 then
                    for i=1, #main_title_info do
                        if a.on then
                            main.name=main_title_info[i]
                            system.yield(100)
                        else
                            main.name='Universe_SYS'
                        end
                    end
                elseif a.value==1 then
                    for i=1, #main_title_nl do
                        if a.on then
                            main.name=main_title_nl[i]
                            system.yield(150)
                        else
                            main.name='Universe_SYS'
                        end
                    end
                elseif a.value==2 then
                    for i=1, #main_title_sk do
                        if a.on then
                            main.name=main_title_sk[i]
                            system.yield(300)
                        else
                            main.name='Universe_SYS'
                        end
                    end
                elseif a.value==3 then
                    for i=1, #main_title_2T do
                        if a.on then
                            main.name=main_title_2T[i]
                            system.yield(10)
                        else
                            main.name='Universe_SYS'
                        end
                    end
                end
            else
                main.name='Universe_SYS'
            end
        end
    end
)
_U_main_title:set_str_data({
    "Universe_SYS",
    "NeverLose",
    "Gamesense",
    "2Take1"
})
_U_Rainbow_R={ 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
240, 220, 200, 180, 160, 140, 120, 100, 80, 60, 40, 20, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240 }
_U_Rainbow_G={ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240,
255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 }
_U_Rainbow_B={ 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240,
255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
240, 220, 200, 180, 160, 140, 120, 100, 80, 60, 40, 20, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
_U_Rainbow_X=1

_U_main_title.threaded=true

local title_option=menu.add_feature(
    lang('玩家列表设置'),
    'parent',
    main_options.id
)
_U_title_option1=menu.add_feature(
    lang('字体大小'),
    'action_value_f',
    title_option.id
)
_U_title_option2=menu.add_feature(
    lang('字体间距'),
    'autoaction_value_f',
    title_option.id,
    function(a)
        _U_title_players_x={0}
        for i=2,12 do
            _U_title_players_x[i]=a.value*(i-1)
        end
    end
)
_U_title_option3=menu.add_feature(
    lang('字体'),
    'action_value_i',
    title_option.id
)
_U_title_option3.max,_U_title_option3.min,_U_title_option3.mod=100,0,1
_U_title_option2.max,_U_title_option2.min,_U_title_option2.mod=1,0.01,0.01
_U_title_option1.max,_U_title_option1.min,_U_title_option1.mod=1,0,0.01

local function show_info_name(pid,name,pos,r,g,b,reason)
    if player.is_player_host(pid) then
        name=name..'[H]'
    end
    if script.get_host_of_this_script()==pid then
        name=name..'[S]'
    end
    if interior.get_interior_from_entity(player.get_player_ped(pid))~=0 then
        name=name..'[I]'
    end
    if player.get_player_wanted_level(pid)~=0 then
        if r==255 and g==255 and b==255 then
            r,g,b=159,197,232
        end
        name=name..'['..tostring(player.get_player_wanted_level(pid))..'∑]'
    end
    if reason then
        name=name..'['..tostring(reason)..']'
    end
    --print(#name)
    -- if #name>=18 then
    --     now_x=now_x+1
    --     if not _U_title_players_x[now_x] or _U_title_players_x[now_x]+_U_title_players_x[2]>=0.85+2*_U_title_players_x[2] then
    --         now_x=1
    --         now_y=now_y+0.02
    --     end
    -- end
    ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
    ui.set_text_color(r, g, b, 255)				
    ui.set_text_scale(_U_title_option1.value)
    ui.set_text_font(_U_title_option3.value)
    ui.set_text_centre(false)
    ui.set_text_outline(true)
    ui.draw_text(name,pos)
end



_U_title_players=menu.add_feature(
    lang("玩家列表"),
    "toggle",
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            if not _U_fuck_myself.on and not _U_fuck_them.on then
                now_x=1
                now_y=0
                for pid=0,31 do
                    if player.is_player_valid(pid) then--and pid~=player.player_id() 
                        local player_name=player.get_player_name(pid) --名字
                        local is_modder_MANUAL=player.is_player_modder(pid,1 << 0x00) -- 科技 手动
                        local is_modder_PLAYER_MODEL=player.is_player_modder(pid,1 << 0x01) -- 科技 修改模型
                        local is_modder_SCID_SPOOF=player.is_player_modder(pid,1 << 0x02) -- 科技 Rid欺骗
                        local is_modder_INVALID_OBJECT_CRASH=player.is_player_modder(pid,1 << 0x03) -- 科技 无效物品
                        local is_modder_INVALID_PED_CRASH=player.is_player_modder(pid,1 << 0x04) -- 科技 无效实体
                        local is_modder_MODEL_CHANGE_CRASH=player.is_player_modder(pid,1 << 0x05) -- 科技 修改模型崩溃
                        local is_modder_PLAYER_MODEL_CHANGE=player.is_player_modder(pid,1 << 0x06) -- 科技 玩家模型修改
                        local is_modder_RAC=player.is_player_modder(pid,1 << 0x07) -- 科技 IMP
                        local is_modder_SYNC_CRASH=player.is_player_modder(pid,1 << 0x0D) -- 科技 同步崩溃
                        local is_modder_NET_EVENT_CRASH =player.is_player_modder(pid,1 << 0x0E) -- 科技 网络事件崩溃
                        local is_modder_HOST_TOKEN=player.is_player_modder(pid,1 << 0x10) -- 科技 主机令牌
                        local is_modder_INVALID_VEHICLE=player.is_player_modder(pid,1 << 0x11) -- 科技 无效载具
                        local is_modder_FRAME_FLAGS=player.is_player_modder(pid,1 << 0x12) -- 科技 小助手
                        local is_god=player.is_player_god(pid) --无敌
                        local is_frd=player.is_player_friend(pid) --好友
                        local is_veh_god=player.is_player_vehicle_god(pid) --车无敌
                        if pid==player.player_id() or is_creater(pid) then
                            if is_creater(pid) then
                                show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),_U_Rainbow_R[_U_Rainbow_X],_U_Rainbow_G[_U_Rainbow_X],_U_Rainbow_B[_U_Rainbow_X],lang('脚本作者')) --蓝色
                            else
                                show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),_U_Rainbow_R[_U_Rainbow_X],_U_Rainbow_G[_U_Rainbow_X],_U_Rainbow_B[_U_Rainbow_X],lang('神')) --蓝色
                            end
                            if _U_Rainbow_X >=#_U_Rainbow_R then
                                _U_Rainbow_X=1
                            else
                                _U_Rainbow_X=_U_Rainbow_X+1
                            end

                        elseif is_frd then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),0,50,200,lang('友')) --蓝色
                        elseif is_modder_MANUAL then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),255,255,0,lang('手动标记')) -- 黄色
                        elseif is_modder_SCID_SPOOF or is_modder_HOST_TOKEN then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),65,232,79,lang('ID/令牌欺骗')) --亮绿
                        elseif is_modder_RAC or is_modder_FRAME_FLAGS then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),230,5,250,'KID') --粉色
                        elseif is_modder_PLAYER_MODEL or is_modder_INVALID_OBJECT_CRASH or is_modder_INVALID_PED_CRASH or is_modder_NET_EVENT_CRASH or is_modder_INVALID_VEHICLE or is_modder_MODEL_CHANGE_CRASH or is_modder_PLAYER_MODEL_CHANGE then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),255,0,0,lang('危')) --红色
                        elseif is_god then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),250,125,5,lang('无敌')) --橙色
                        elseif is_veh_god then
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),191,0,255,lang('载具无敌')) --紫色
                        else
                            show_info_name(pid,player_name,v2(_U_title_players_x[now_x],now_y),255,255,255) --白色
                        end
                        now_x=now_x+1
                        if not _U_title_players_x[now_x] or _U_title_players_x[now_x]+_U_title_players_x[2]>=0.85+2*_U_title_players_x[2] then
                            now_x=1
                            now_y=now_y+0.02
                        end
                        
                    end
                end
            end
        end
    end
)

_U_title_players.threaded=true


local on_start_text=menu.add_feature(
    "这是你看不见的",
    "toggle",
    main.id,
    function(a)
        local i=0
        
        while a.on do
            system.yield(0)
            ui.set_text_color(i*10,i*2,100-i, 255)				
            ui.set_text_scale(1)
            ui.set_text_font(0)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text("欢迎使用\nUniverse",v2(0.5,0.3))
            i=i+10
        end
    end
)
on_start_text.hidden=true
on_start_text.threaded=true
local skills={
    "搞人",
    "撒钱",
    "挣钱",
    "友好对待他人",
    "活着",
    "崩人",
    "踢出玩家",
    "钓鱼",
    "骂人",
    "抢劫",
    "赌场"
}


local on_start_end=menu.add_feature(
    "这是你看不见的",
    "toggle",
    main.id,
    function(a)
        local month=os.date("%m")
        local today=os.date("%d")
        local date=month..lang('月')..today..lang('日')
        local i=255
        local x=0
        local randomthing=math.random(1,#skills)
        _U_main_title.on=true
        while a.on and i>0 do
            system.yield(0)
            ui.set_text_color(100-x,x*10, x*10, i)					
            ui.set_text_scale(1)
            ui.set_text_font(0)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text(lang("欢迎使用\nUniverse\n今天是")..date..lang('\n适宜')..skills[randomthing],v2(0.5,0.3))
            i=i-1
            x=x+1
        end
    end
)
on_start_end.hidden=true
on_start_end.threaded=true
local on_start=menu.add_feature(
    "这是你看不见的",
    "action",
    main.id,
    function()
        local me=player.player_id()
        local my_ped=player.get_player_ped(me)
        time.set_clock_time(23, 0, 0)
        entity.set_entity_coords_no_offset(my_ped, v3(-75.392, -819.27, 326.175))
        on_start_text.on=true
        graphics.set_next_ptfx_asset("scr_trevor1")
        while not graphics.has_named_ptfx_asset_loaded("scr_trevor1") do
            graphics.request_named_ptfx_asset("scr_trevor1")
            system.wait(0)
        end
        system.wait(4000)
        graphics.set_next_ptfx_asset("scr_trevor1")
        while not graphics.has_named_ptfx_asset_loaded("scr_trevor1") do
            graphics.request_named_ptfx_asset("scr_trevor1")
            system.wait(0)
        end
        graphics.start_ptfx_looped_on_entity("scr_trev1_trailer_boosh", my_ped, v3(0, 0.0, 0.0), v3(0, 0, 0), 2)
        system.wait(1)
        fire.add_explosion(v3(-50, -819.27, 326.175), 0, true, false, 0, my_ped)
        system.wait(1)
        time.set_clock_time(12, 0, 0)
        on_start_text.on=false
        on_start_end.on=true
        system.wait(4000)
        on_start_end.on=false
    end
)
on_start.hidden=true

--------------------toggle_targets------------------------------

------------自我选项------------------
--------------在地图上隐藏自己 Done----------------
local ranbow={
    '#FF0000', '#FF0014', '#FF0028', '#FF003C', '#FF0050', '#FF0064', '#FF0078', '#FF008C', '#FF00A0',
    '#FF00B4', '#FF00C8', '#FF00DC', '#FF00F0', '#F000FF', '#DC00FF', '#C800FF', '#B400FF', '#A000FF', '#8C00FF', '#7800FF', '#6400FF', '#5000FF',
    '#3C00FF', '#2800FF', '#1400FF', '#0000FF', '#0000FF', '#0014FF', '#0028FF', '#003CFF', '#0050FF', '#0064FF', '#0078FF', '#008CFF', '#00A0FF', '#00B4FF',
    '#00C8FF', '#00DCFF', '#00F0FF', '#00FFF0', '#00FFDC', '#00FFC8', '#00FFB4', '#00FFA0', '#00FF8C', '#00FF78', '#00FF64', '#00FF50', '#00FF3C', '#00FF28', '#00FF14',
    '#00FF00', '#00FF00', '#14FF00', '#28FF00', '#3CFF00', '#50FF00', '#64FF00', '#78FF00', '#8CFF00', '#A0FF00', '#B4FF00', '#C8FF00', '#DCFF00', '#F0FF00', '#FFFF00', '#FFF000',
    '#FFDC00', '#FFC800', '#FFB400', '#FFA000', '#FF8C00', '#FF7800', '#FF6400', '#FF5000', '#FF3C00', '#FF2800', '#FF1400'
}




_U_health_cheat=menu.add_feature(
    lang("在地图上隐藏自己")
    ,"toggle",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            if a.on then
                local me = player.player_id()
                local myid = player.get_player_ped(me)
                ped.set_ped_max_health(myid,0)
                ped.set_ped_health(myid,1000)
            else
                local me = player.player_id()
                local myid = player.get_player_ped(me)
                ped.set_ped_max_health(myid,328)
                ped.set_ped_health(myid,328)
            end
        end
    end
)

_U_health_cheat_inf=menu.add_feature(
    lang('血条无限'),
    'toggle',
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            if a.on then
                ped.set_ped_max_health(player.get_player_ped(player.player_id()),2147480000)
                ped.set_ped_health(player.get_player_ped(player.player_id()),2147480000)
            else
                ped.set_ped_max_health(player.get_player_ped(player.player_id()),328)
                ped.set_ped_health(player.get_player_ped(player.player_id()),328)
            end
        end
    end
)
_U_health_cheat_inf.threaded=true
_U_health_god=menu.add_feature(
    lang('半无敌'),
    'toggle',
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            ped.set_ped_health(player.get_player_ped(player.player_id()),ped.get_ped_max_health(player.get_player_ped(player.player_id())))
        end
    end
)
_U_health_god.threaded=true
local show__U_time_go_back_info=menu.add_feature(
    "这是个显示",
    "toggle",
    main_self.id,
    function(a)
        r,g,b=math.random(0,255),math.random(0,255), math.random(0,255)
        while a.on do
            system.yield(0)
            if a.on then 
                ui.set_text_color(r,g,b, 185)					
                ui.set_text_scale(0.55)
                ui.set_text_font(0)
                ui.set_text_centre(true)
                ui.set_text_outline(true)
                ui.draw_text(lang("你已开启时间折跃\n在时间折跃中\n你需要在两个地点之间不断传送"),v2(0.5,0.3))
            end
        end
    end
)

local show__U_time_go_back_info2=menu.add_feature(
    "这是个显示",
    "toggle",
    main_self.id,
    function(a)
        r,g,b=math.random(0,255),math.random(0,255), math.random(0,255)
        while a.on do
            system.yield(0)
            if a.on then
                ui.set_text_color(r,g,b, 185)					
                ui.set_text_scale(0.55)
                ui.set_text_font(0)
                ui.set_text_centre(true)
                ui.set_text_outline(true)
                ui.draw_text(lang("每次传送间隔为15S\n你可以携带载具进行时间折跃\n将在8秒内开始"),v2(0.5,0.5))
            end
        end
    end
)
show__U_time_go_back_info.hidden=true
show__U_time_go_back_info2.hidden=true
show__U_time_go_back_info.threaded=true
show__U_time_go_back_info2.threaded=true
_U_time_go_back=menu.add_feature(
    lang("时间折跃"),
    "toggle",
    main_self.id,
    function(a)
        local me = player.player_id()
        local new_pos=player.get_player_coords(me)
        last_pos=new_pos
        while a.on do
            local me = player.player_id()
            local my_ped=player.get_player_ped(me)
            if a.on then
                ui.notify_above_map(lang("~r~请注意！\n时间折跃已开始！！"),"Universe",6)
            end
            system.yield(5000)
            if a.on then
                ui.notify_above_map(lang("~r~请注意！\n时间折跃已开始！！"),"Universe",6)
            end
            system.yield(5000)
            if a.on then
                ui.notify_above_map(lang("~r~请注意！\n时间折跃已开始！！"),"Universe",6)
            end
            system.yield(5000)
            if a.on then
                local new_pos=player.get_player_coords(me)
                if player.is_player_in_any_vehicle(me) then
                    entity.set_entity_coords_no_offset(player.get_player_vehicle(me),last_pos)
                else
                    entity.set_entity_coords_no_offset(my_ped,last_pos)
                end
                last_pos=new_pos
            end
        end
    end
)
_U_time_go_back.hidden=true



_U_time_go_back2=menu.add_feature(
    lang("时间折跃"),
    "toggle",
    main_self.id,
    function(a)
        if a.on then
            show__U_time_go_back_info.on=true
            show__U_time_go_back_info2.on=true
            system.yield(8000)
            if a.on then
                show__U_time_go_back_info.on=false
                show__U_time_go_back_info2.on=false
                _U_time_go_back.on=true
            else
                show__U_time_go_back_info2.on=false
                show__U_time_go_back_info.on=false
                _U_time_go_back.on=false
            end
        else
            show__U_time_go_back_info2.on=false
            show__U_time_go_back_info.on=false
            _U_time_go_back.on=false
        end
    end
)


-----------在线玩家---------------


-----------主机掠夺 Done--------------

_U_get_host=menu.add_feature(
    lang("主机掠夺"),
    "toggle",
    main_network.id,
    function(a)
        while a.on  do
            system.yield(0)
            if network.network_is_host() then
                _U_get_host.on=false
            end
			local nothing, friends = get_host()
			if friends then
				break
			end
		end
    end


)
------------------watch dog
_U_active_watch_dog=menu.add_feature(
    "看门狗解析",
    'toggle',
    main_network.id,
    function(a)
        while a.on do
            system.yield(0)
            if controls.get_control_normal(0,114)==1.0 then
                local aim_ent=player.get_entity_player_is_aiming_at(player.player_id())
                if controls.get_control_normal(0,183)==1.0 then
                    fire.add_explosion(entity.get_entity_coords(aim_ent),0, true, false, 0,player.get_player_ped(player.player_id()))
                elseif controls.get_control_normal(0,26)==1.0 and not ped.is_ped_a_player(aim_ent) then
                    entity.set_entity_coords_no_offset(aim_ent,entity.get_entity_coords(aim_ent))
                    entity.freeze_entity(aim_ent,true)
                    system.wait(1000)
                    entity.freeze_entity(aim_ent,false)
                end
                if entity.is_entity_a_ped(aim_ent) and not ped.is_ped_a_player(aim_ent) then
                    if ped.is_ped_in_any_vehicle(aim_ent) then
                        if controls.get_control_normal(0,251)==1.0 then
                            fuck_NPC_car(aim_ent)
                        elseif controls.get_control_normal(0,325)==1.0 then
                            entity.delete_entity(ped.get_vehicle_ped_is_using(aim_ent))
                        elseif controls.get_control_normal(0,252)==1.0 then
                            vehicle.set_vehicle_forward_speed(ped.get_vehicle_ped_is_using(aim_ent),50)
                        elseif controls.get_control_normal(0,46)==1.0 then
                            vehicle.set_vehicle_forward_speed(ped.get_vehicle_ped_is_using(aim_ent),-50) 
                        end
                    end
                    if controls.get_control_normal(0,251)==1.0 then
                        entity.delete_entity(aim_ent)
                    elseif controls.get_control_normal(0,46)==1.0 then
                        ped.set_ped_health(aim_ent,0)
                    end
                elseif entity.is_entity_a_vehicle(aim_ent) then
                    if controls.get_control_normal(0,251)==1.0 then
                        ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),aim_ent,-1)
                    elseif controls.get_control_normal(0,325)==1.0 then
                        entity.delete_entity(aim_ent)
                    elseif controls.get_control_normal(0,252)==1.0 then
                        vehicle.set_vehicle_forward_speed(aim_ent,50)
                    elseif controls.get_control_normal(0,46)==1.0 then
                        vehicle.set_vehicle_forward_speed(aim_ent,-50) 
                    end
                elseif entity.is_entity_a_ped(aim_ent) and ped.is_ped_a_player(aim_ent) then
                    if ped.is_ped_in_any_vehicle(aim_ent) then
                        if controls.get_control_normal(0,251)==1.0 then
                            fuck_Player_car(aim_ent)
                        elseif controls.get_control_normal(0,325)==1.0 then
                            entity.delete_entity(ped.get_vehicle_ped_is_using(aim_ent))
                        elseif controls.get_control_normal(0,252)==1.0 then
                            vehicle.set_vehicle_forward_speed(ped.get_vehicle_ped_is_using(aim_ent),50)
                        elseif controls.get_control_normal(0,46)==1.0 then
                            vehicle.set_vehicle_forward_speed(ped.get_vehicle_ped_is_using(aim_ent),-50) 
                        end
                    end
                    if controls.get_control_normal(0,26)==1.0 then
                        ped.clear_ped_tasks_immediately(aim_ent)
                    end
                end
            elseif player.is_player_in_any_vehicle(player.player_id()) then
                if controls.get_control_normal(0,252)==1.0 then
                    network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
                    vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()),50)
                elseif controls.get_control_normal(0,46)==1.0 then
                    network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
                    vehicle.set_vehicle_forward_speed(player.get_player_vehicle(player.player_id()),entity.get_entity_speed(player.get_player_vehicle(player.player_id()))+200)
                    system.yield(500)
                end
            end
            if not _U_watch_dog.on then
                _U_active_watch_dog.on=false
            end
        end
    end
)

_U_active_watch_dog.hidden=true
_U_active_watch_dog.threaded=true

function show____ped(aim_ent)
    if ped.is_ped_in_any_vehicle(aim_ent) then
        ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
        ui.set_text_color(255, 255, 0, 255)				
        ui.set_text_scale(0.5)
        ui.set_text_font(0)
        ui.set_text_centre(true)
        ui.set_text_outline(true)
        --ui.draw_text(string.format(),v2(0.5,0.96))
        ui.draw_text(string.format('G:%s C:%s V:%s X:%s E:%s F:%s ',lang('爆炸'),lang('冻结'),lang('删除'),lang('加速'),lang('倒车'),lang('上车')),v2(0.5,0.96))
    elseif ped.is_ped_a_player(aim_ent) then
        ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
        ui.set_text_color(255, 255, 0, 255)				
        ui.set_text_scale(0.5)
        ui.set_text_font(0)
        ui.set_text_centre(true)
        ui.set_text_outline(true)
        ui.draw_text(string.format('G:%s C:%s ',lang('爆炸'),lang('冻结')),v2(0.5,0.96))
        --ui.draw_text('G:爆炸 C:冻结',v2(0.5,0.96))
    else
        ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
        ui.set_text_color(255, 255, 0, 255)				
        ui.set_text_scale(0.5)
        ui.set_text_font(0)
        ui.set_text_centre(true)
        ui.set_text_outline(true)
        ui.draw_text(string.format('G:%s C:%s F:%s E:%s ',lang('爆炸'),lang('冻结'),lang('删除'),lang('杀死')),v2(0.5,0.96))
        --ui.draw_text('G:爆炸 C:冻结 F:删除 E:杀死',v2(0.5,0.96))
    end
end


function show____veh(aim_ent)
    ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
    ui.set_text_color(255, 255, 0, 255)				
    ui.set_text_scale(0.5)
    ui.set_text_font(0)
    ui.set_text_centre(true)
    ui.set_text_outline(true)
    ui.draw_text(string.format('G:%s C:%s V:%s X:%s E:%s F:%s ',lang('爆炸'),lang('冻结'),lang('删除'),lang('加速'),lang('倒车'),lang('上车')),v2(0.5,0.96))
end


function _U_Show(aim_ent)
    if entity.is_entity_a_ped(aim_ent) then
        show____ped(aim_ent)
    elseif entity.is_entity_a_vehicle(aim_ent) then
        show____veh(aim_ent)
    end
end


_U_watch_dog=menu.add_feature(
    lang("看门狗模式"),
    'toggle',
    main_network.id,
    function(a)
        if a.on then
            _U_active_watch_dog.on=true
            menu.notify(lang('按右键使用\n请不要在空中使用\n在空中使用可能导致崩溃'),'Universe',10)
            while a.on do
                system.yield(0)
                ui.show_hud_component_this_frame(14)
                while controls.get_control_normal(0,114)==1.0 do
                    system.yield(0)
                    local aim_ent=player.get_entity_player_is_aiming_at(player.player_id())
                    if aim_ent then
                        _U_Show(aim_ent)
                    end
                end
                if player.is_player_in_any_vehicle(player.player_id()) then
                    ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
                    ui.set_text_color(255, 255, 0, 255)				
                    ui.set_text_scale(0.5)
                    ui.set_text_font(0)
                    ui.set_text_centre(true)
                    ui.set_text_outline(true)
                    ui.draw_text(string.format('X:%s E:%s',lang('加速'),lang('超级加速')),v2(0.5,0.96))
                    --ui.draw_text('X:加速 E:超级加速',v2(0.5,0.96))
                end
            end
        else
            _U_active_watch_dog.on=false
        end
        
    end
)

------------------watch dog end


_U_walk_on_water=menu.add_feature(
    lang('水上行走'),
    'toggle',
    main_self.id,
    function(a)
        while a.on and not player.is_player_in_any_vehicle(player.player_id()) do
            system.yield(0)
            local dir=entity.get_entity_rotation(player.get_player_ped(player.player_id()))
            dir:transformRotToDir()
            if not water_obj then
                if request_mod(110106994) then
                    water_obj=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj,false)
                end
            end
            if not water_obj3 then
                if request_mod(110106994) then
                    water_obj3=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj3,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj3,false)
                end
            end
            if not water_obj4 then
                if request_mod(110106994) then
                    water_obj4=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj4,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj4,false)
                end
            end
            if not water_obj2 then
                if request_mod(3188223741) then
                    water_obj2=ped.create_ped(4,3188223741,player.get_player_coords(player.player_id())+v3(0,0,5.25),0,false,true)
                    system.yield(0)
                    entity.set_entity_god_mode(water_obj2,true)
                    system.yield(0)
                    entity.set_entity_visible(water_obj2,false)
                end
            end
            if water_obj2 then
                entity.set_entity_coords_no_offset(water_obj2,player.get_player_coords(player.player_id())-v3(0,0,3))
                system.yield(0)
                entity.set_entity_rotation(water_obj2,entity.get_entity_rotation(player.get_player_ped(player.player_id())))
            end
            if water_obj2 and entity.is_entity_in_water(water_obj2) and is_player_move(player.get_player_coords(player.player_id())) then
                if water_obj then
                        entity.set_entity_coords_no_offset(water_obj,player.get_player_coords(player.player_id())-v3(0,0,1))
                else
                    water_obj=object.create_world_object(110106994,player.get_player_coords(player.player_id())-v3(0,0,1.25),true,true)
                    system.yield(0)
                    entity.set_entity_visible(water_obj,false)
                end
                if water_obj3 then
                    entity.set_entity_coords_no_offset(water_obj3,player.get_player_coords(player.player_id())+v3(dir.x*90,dir.y*90,-1))
                else
                    water_obj3=object.create_world_object(110106994,player.get_player_coords(player.player_id())-v3(0,0,1.25),true,true)
                    system.yield(0)
                    entity.set_entity_visible(water_obj3,false)
                end
                if water_obj4 then
                    entity.set_entity_coords_no_offset(water_obj4,player.get_player_coords(player.player_id())+v3(dir.x*180,dir.y*180,-1))
                else
                    water_obj4=object.create_world_object(110106994,player.get_player_coords(player.player_id())-v3(0,0,1.25),true,true)
                    system.yield(0)
                    entity.set_entity_visible(water_obj4,false)
                end
            else
                return HANDLER_CONTINUE
            end
            if water_obj2 and entity.get_entity_model_hash(water_obj2)==0 then
                water_obj2=nil
                water_obj=nil
                water_obj3=nil
                water_obj4=nil
            end
        end
    end
)
_U_walk_on_water.threaded=true

_U_fire_fist=menu.add_feature(
    lang("火焰拳"),
    "toggle",
    main_self.id,
    function(a)
        menu.notify(lang("按住右键蓄力，左键使用"),"Universe",2,0x180014)
        while a.on do
            local max_time=20
            system.yield(0)
            if not player.is_player_in_any_vehicle(player.player_id()) then
                if ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))==2725352035 then
                    if controls.get_control_normal(0,142)==1.0 and xuli_time~=0 then
                        for i=1,xuli_time do
                            local pos = player.get_player_coords(player.player_id())
                            for c=9,15,0.1 do
                                dir = cam.get_gameplay_cam_rot()
                                dir:transformRotToDir()
                                dir = dir * i*c
                                pos = pos + dir
                                fire.add_explosion(pos,29,true,false,0,player.get_player_ped(player.player_id()))
                            end
                        end
                        xuli_time=0
                        system.yield(1000)
                    elseif controls.get_control_normal(0,114)==1.0 and controls.get_control_normal(0,143)==0.0 then
                        if xuli_time==max_time-1 then
                            fire.add_explosion(player.get_player_coords(player.player_id())-v3(0,0,2),38,true,false,0,player.get_player_ped(player.player_id()))
                            xuli_time=xuli_time+1
                            system.yield(1000-(20-xuli_time)*50)
                        elseif xuli_time<max_time then
                            fire.add_explosion(player.get_player_coords(player.player_id())-v3(0,0,5),24,true,false,0,player.get_player_ped(player.player_id()))
                            xuli_time=xuli_time+1
                            system.yield(1000-(20-xuli_time)*50)
                        end
                    elseif controls.get_control_normal(0,114)==1.0 then
                        pass()
                    else
                        xuli_time=0
                    end
                    ui.show_hud_component_this_frame(14)
                end
            end
        end
    end
)


_U_fire_fist.threaded=true









-------------主机检测 Done--------------

_U_is_host=menu.add_feature(
    lang("成为主机通知"),
    "toggle",
    main_network.id,
    function(a)
        while a.on do
            system.yield(0)
            if network.network_is_host() then
                ui.set_text_color(255, 0, 155, 255)					
                    ui.set_text_scale(0.5)
                    ui.set_text_font(0)
                    ui.set_text_centre(true)
                    ui.set_text_outline(true)
                    ui.draw_text(lang("主机模式"),v2(0.95,0.96))
            end
        end
    end
)


---------------踢出玩家 Done-------------------
_U_kick=menu.add_feature(
    lang("主机踢"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            for pid =0,31 do
                if pid ~= me and not player.is_player_friend(pid) then
                    network.network_session_kick_player(pid)
                end
            end
        end
    end

)

local sms_list={
    -- "fuck u",
    -- "qwertyuioplkjghsazxcvbnm",
    -- "abcdefg",
    -- "bitch",
    "操你妈",
    "不会吧不会吧，不会真的还有人没有2Take1吧？",
    "不会吧不会吧，不会真的还有人的外挂不支持脚本吧？",
    "祖安大舞台，有妈你就来",
    "生活中总能遇到奇葩的人或事",
    "就连打一局游戏，遇到的傻逼也是一批接着一批",
    "时常被气得忍不住想口吐芬芳，比如现在，操你妈",
    "您真是莎士比亚去个士字",
    "我看您是新型冠状癞蛤蟆跳悬崖，想装蝙蝠侠？",
    "您打字这速度，是在查新华字典吗？",
    "对不起啊，我没有资格骂你神经病，毕竟我不是兽医",
    "百度搜不到您，搜狗一下就找到了",
    "巴黎圣母院烧了您没地方住了是吧",
    "凭你的智商可以过一辈子的六一",
    "我走我的阳关道，您过您的奈何桥",
    "您就是国家素质教育的漏网之鱼吧",
    "还好您不在上海，不然真不知道要把您分到哪里去",
    "我已经三天没吃饭了，但看到您的行为还是忍不住想吐",
    "您真是上帝造人用的草稿",
    "妹妹的腮红够不够？要不要你爹的巴掌凑",
    "你不讨厌，可是毫无用处。——钱钟书",
    "您脑子里的水倒出来是不是当初冲了龙王庙又漫了金山",
    "快把手腾出来吧，别用脚玩了",
    "我跟你们打游戏就是逛菜市场，各种菜",
    "你已被封禁",
}


------------骚扰玩家
_U_sms_cheat=menu.add_feature(
    lang("SMS短信轰炸"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            for pid =0,31 do
                if pid ~= me then
                    local sms=lang(sms_list[math.random(1,#sms_list)])
                    player.send_player_sms(pid,sms)
                end
            end
        end
    end

)



-------------------反载具

local Anti_Vehicle=menu.add_feature(
    lang("禁止载具"),
    "parent",
    main_net_all.id
)

local function Anti_Vehicle_Func(veh,anti_veh,pid,name)
    if entity.get_entity_model_hash(veh)==anti_veh then
        ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
        menu.notify(lang("检测到非法载具")..name..lang("使用人：")..player.get_player_name(pid),"Universe",3)
    end
end


_U_Anti_MK2=menu.add_feature(
    lang("反MK2"),
    "toggle",
    Anti_Vehicle.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) then
                    Anti_Vehicle_Func(player.get_player_vehicle(pid),2069146067,pid,"MK2")
                end
            end
        end
    end
)
_U_Anti_MK1=menu.add_feature(
    lang("反MK1"),
    "toggle",
    Anti_Vehicle.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and player.is_player_in_any_vehicle(pid) then
                    Anti_Vehicle_Func(player.get_player_vehicle(pid),884483972,pid,"MK1")
                end
            end
        end
    end
)

----------------反载具





-----------------暴力踢出 Done-----------------
_U_force_kick=menu.add_feature(
    lang("暴力踢出"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            for pid=0,31 do
                if pid~=me and not player.is_player_friend(pid) and player.is_player_valid(pid) then
                    network.network_session_kick_player(pid)
                    network.force_remove_player(pid)
                    send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
                    for x=1,14 do
                        send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
                    end
                end
            end
        end
    end
)





_U_killing_eye_noice_time=0



-------------------激光眼 Done--------------------
_U_killing_eye_v1=menu.add_feature(
    lang("激光眼").." V1",
    "toggle",
    main_self.id,
    function(a)
        if _U_killing_eye_noice_time<10 then
            menu.notify("按X使用","Universe",5,6)
            _U_killing_eye_noice_time=_U_killing_eye_noice_time+1
        end
        local me=player.player_id()
        local my_ped=player.get_player_ped(me)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            weapon.give_weapon_component_to_ped(my_ped,177293209,0x89EBDAA7)
            local my_ped=player.get_player_ped(me)
            if controls.get_control_normal(0,252)==0.0 then
                state=nil
            else
                state=1
            end
            while state do
                local success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                while not success do
                    success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                    system.wait(0)
                end
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1.5
                v3_start = v3_start + dir + v3(0,0,1)
                dir = nil
                local v3_end = player.get_player_coords(me)
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1500
                v3_end = v3_end + dir
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 0, 3056410471, my_ped, true, false, 1000)
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, 177293209, my_ped, true, false, 1000)
                system.yield(0)
                ui.show_hud_component_this_frame(14)
                return HANDLER_CONTINUE
            end
            ui.show_hud_component_this_frame(14)
        end
    end

)

_U_killing_eye_v2=menu.add_feature(
    lang("激光眼").." V2",
    "toggle",
    main_self.id,
    function(a)
        if _U_killing_eye_noice_time<10 then
            menu.notify("按X使用","Universe",5,6)
            _U_killing_eye_noice_time=_U_killing_eye_noice_time+1
        end
        local me=player.player_id()
        local my_ped=player.get_player_ped(me)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            weapon.give_weapon_component_to_ped(my_ped,1432025498,0x3BE4465D)
            local my_ped=player.get_player_ped(me)
            if controls.get_control_normal(0,252)==0.0 then
                state=nil
            else
                state=1
            end
            while state do
                local success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                while not success do
                    success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                    system.wait(0)
                end
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1.5
                v3_start = v3_start + dir + v3(0,0,1)
                dir = nil
                local v3_end = player.get_player_coords(me)
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1500
                v3_end = v3_end + dir
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 0, 3056410471, my_ped, true, false, 1000)
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, 1432025498, my_ped, true, false, 1000)
                system.yield(0)
                ui.show_hud_component_this_frame(14)
                return HANDLER_CONTINUE
            end
            ui.show_hud_component_this_frame(14)
        end
    end

)

_U_killing_eye_v3=menu.add_feature(
    lang("激光眼").." V3",
    "toggle",
    main_self.id,
    function(a)
        if _U_killing_eye_noice_time<10 then
            menu.notify("按X使用","Universe",5,6)
            _U_killing_eye_noice_time=_U_killing_eye_noice_time+1
        end
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if controls.get_control_normal(0,252)==0.0 then
                state=nil
            else
                state=1
            end
            while state do
                local success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                while not success do
                    success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                    system.wait(0)
                end
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1.5
                v3_start = v3_start + dir + v3(0,0,1)
                dir = nil
                local v3_end = player.get_player_coords(me)
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1500
                v3_end = v3_end + dir
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 0, 3056410471, my_ped, true, false, 1000)
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, 1834241177, my_ped, true, false, 1000)
                system.yield(0)
                ui.show_hud_component_this_frame(14)
                return HANDLER_CONTINUE
            end
            ui.show_hud_component_this_frame(14)
        end
    end

)


-------------------------激光眼系列-------------------------------------
_U_protect_shield=menu.add_feature(
    lang("强光护盾"),
    "slider",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            fire.add_explosion(player.get_player_coords(me)+v3(0,0,a.value),70,false,false,0,player.get_player_ped(me))
        end
    end
)
_U_protect_shield.max,_U_protect_shield.min,_U_protect_shield.mod=5,0,0.1


_U_invis_shield=menu.add_feature(
    lang("无光之盾").."("..lang("匿名")..lang("栽赃")..")",
    "toggle",
    main_self.id,
    function(a)
        ui.notify_above_map(lang("请确保无敌已经开启\n请确保战局里有其他非好友玩家"),"",0)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local pid=math.random(0,31)
            local my_ped=player.get_player_ped(me)
            ped.set_ped_health(my_ped,3280)
            if pid~=me and player.is_player_valid(pid) and not player.is_player_friend(pid) then
                fire.add_explosion(player.get_player_coords(me),29,false,true,0,player.get_player_ped(pid))
            end
            system.yield(0)
            ped.set_ped_health(my_ped,328)
        end
    end
)
_U_invis_shield_v2=menu.add_feature(
    lang("无光之盾").."("..lang("匿名")..")",
    "toggle",
    main_self.id,
    function(a)
        ui.notify_above_map("请确保无敌已经开启","",0)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            ped.set_ped_health(my_ped,3280)
            fire.add_explosion(player.get_player_coords(me),29,false,true,0,me)
            system.yield(0)
            ped.set_ped_health(my_ped,328)
        end
    end
)
_U_invis_shield_v3=menu.add_feature(
    lang("无光之盾"),
    "toggle",
    main_self.id,
    function(a)
        ui.notify_above_map(lang("请确保无敌已经开启"),"",0)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            ped.set_ped_health(my_ped,3280)
            fire.add_explosion(player.get_player_coords(me),29,false,true,0,player.get_player_ped(me))
            system.yield(0)
            ped.set_ped_health(my_ped,328)
        end
    end
)

function pass()
    return nil
end





function is_pz(hash)
    if hash==487013001 or hash==1432025498 or hash==2017895192 or hash==2640438543 or hash==3800352039 or hash==2828843422 or hash==984333226 or hash==4019527611 or hash==317205821 or hash==94989220 then
        return 177293209
    else
        return hash
    end
end

_U_spin_16=menu.add_feature(     --翻译是这个-> _U_spin
    lang("大陀螺1.6"),
    "value_str",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            local rot=entity.get_entity_rotation(my_ped)
            if controls.get_control_normal(0,32)==1.0 or controls.get_control_normal(0,34)==1.0 or controls.get_control_normal(0,33)==1.0 or controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,21)==1.0 or controls.get_control_normal(0,142)==1.0 or controls.get_control_normal(0,143)==1.0 then
                pass()
            else
                entity.set_entity_rotation(my_ped,rot + v3(math.random(0,1000),math.random(0,1000),math.random(0,1000)))
            end
            if a.value==0 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i])-v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            elseif a.value==1 then
                for i=1,31 do
                    if player.is_player_valid(i) and i~=player.player_id() then
                        if not entity.is_entity_dead(player.get_player_ped(i)) then
                            local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(i)+v3(0,0,0.5), player.get_player_coords(i)-v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                            return HANDLER_CONTINUE
                        end
                    end
                end
            elseif a.value==2 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if entity.is_entity_a_ped(all_peds[i]) and all_peds[i]~=my_ped and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i])-v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            end
        end
    end
)

_U_spin=menu.add_feature( --翻译是这个-> _U_spin
    lang("大陀螺"),
    "value_str",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            local rot=entity.get_entity_rotation(my_ped)
            if controls.get_control_normal(0,32)==1.0 or controls.get_control_normal(0,34)==1.0 or controls.get_control_normal(0,33)==1.0 or controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,21)==1.0 or controls.get_control_normal(0,143)==1.0 then
                pass()
            else
                entity.set_entity_rotation(my_ped,v3(0,0,math.random(0,1000)))
            end
            if a.value==0 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i]), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            elseif a.value==1 then
                for i=1,31 do
                    if player.is_player_valid(i) and i~=player.player_id() then
                        if not entity.is_entity_dead(player.get_player_ped(i)) then
                            local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(i)+v3(0,0,0.5), player.get_player_coords(i), 1, hash_weapon, my_ped, true, false, 1000)
                        end
                    end
                end
            elseif a.value==2 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if entity.is_entity_a_ped(all_peds[i]) and all_peds[i]~=my_ped and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), entity.get_entity_coords(all_peds[i]), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            end
        end
    end
)


local spin_little=menu.add_feature(
    lang("小陀螺"),
    "value_str",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            _U_spin.on=false
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            local rot=entity.get_entity_rotation(my_ped)
            if controls.get_control_normal(0,32)==1.0 or controls.get_control_normal(0,34)==1.0 or controls.get_control_normal(0,33)==1.0 or controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,21)==1.0 or controls.get_control_normal(0,143)==1.0 then
                pass()
                local z=cam.get_gameplay_cam_rot().z
                if controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-180))--wasd
                elseif controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z+90))--wad
                elseif controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z+45))--wa
                elseif controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,35)==1.0 then   
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-45))--wd
                elseif controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,35)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-135))--sd
                elseif controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z+135))--sa
                elseif controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-180))--s
                elseif controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z+90))--a
                elseif controls.get_control_normal(0,35)==1.0 then
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-90))--d
                else
                    entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z))
                end
                system.yield(50)
                entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-180))
                is_running=true
            else
                local z=cam.get_gameplay_cam_rot().z
                entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-180))
                is_running=false
            end
            if a.value==0 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        local npc_pos=entity.get_entity_rotation(all_peds[i])
                        if not is_running then
                            entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,npc_pos.z-180))
                            system.yield(0)
                            entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,cam.get_gameplay_cam_rot().z-180))
                        end
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i]), entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            elseif a.value==1 then
                for i=1,31 do
                    if player.is_player_valid(i) and i~=player.player_id() then
                        if not entity.is_entity_dead(player.get_player_ped(i)) then
                            local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                            local npc_pos=player.get_player_coords(i)
                            if not is_running then
                                entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,npc_pos.z-180))
                                system.yield(0)
                                entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,cam.get_gameplay_cam_rot().z-180))
                            end
                            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(i), player.get_player_coords(i)+v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                        end
                    end
                end
            elseif a.value==2 then
                local all_peds=ped.get_all_peds()
                for i=1,#all_peds do
                    if all_peds[i]~=my_ped and not entity.is_entity_dead(all_peds[i]) then
                        local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
                        local npc_pos=entity.get_entity_rotation(all_peds[i])
                        if not is_running then
                            entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,npc_pos.z-180))
                            system.yield(0)
                            entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,cam.get_gameplay_cam_rot().z-180))
                        end
                        gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(all_peds[i]), entity.get_entity_coords(all_peds[i])+v3(0,0,0.5), 1, hash_weapon, my_ped, true, false, 1000)
                    end
                end
            end
        end
    end
)
_U_spin_16.threaded=true
_U_spin.threaded=true
spin_little.threaded=true
_U_spin_16:set_str_data({
    lang("转NPC"),
    lang("转玩家"),
    lang("转NPC&玩家"),
    lang("假身")
})

_U_spin:set_str_data({
    lang("转NPC"),
    lang("转玩家"),
    lang("转NPC&玩家"),
    lang("假身")
})
spin_little:set_str_data({
    lang("转NPC"),
    lang("转玩家"),
    lang("转NPC&玩家"),
    lang("假身")
})




_U_karma=menu.add_feature(
    lang('因果报应'),
    'toggle',
    main_self.id,
    function(a)
        karma_pid=nil
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and player.player_id() ~= pid then
                    if player.get_entity_player_is_aiming_at(pid)==player.get_player_ped(player.player_id()) then
                        karma_pid=pid
                    end
                end
            end
            if entity.is_entity_dead(player.get_player_ped(player.player_id())) then
                if karma_pid then
                    for i=0,30 do
                        fire.add_explosion(player.get_player_coords(karma_pid),8,true,false,0,player.get_player_ped(player.player_id()))
                        system.yield(100)
                    end
                end
            end
        end
    end
)





_U_lighting=menu.add_feature(
    lang('闪电侠'),
    'slider',
    main_self.id,
    function(a)
        menu.notify(lang('有更好的特效代码联系我'),'Universe',3)
        while a.on do
            system.yield(0)
            entity.set_entity_max_speed(player.get_player_ped(player.player_id()),2147000000)
            local dir=entity.get_entity_rotation(player.get_player_ped(player.player_id()))
            dir:transformRotToDir()
            dir=v3(dir.x*100*a.value,dir.y*100*a.value,dir.z*100*a.value)
            if controls.get_control_normal(0,21)==1.0 then
                if controls.get_control_normal(0,32)==1.0 then
                    if controls.get_control_normal(0,21)==1.0 then
                        if not entity.is_entity_in_air(player.get_player_ped(player.player_id())) then
                            while not graphics.has_named_ptfx_asset_loaded("scr_trevor1") and a.on do
                                graphics.request_named_ptfx_asset("scr_trevor1")
                                system.wait(0)
                            end
                            graphics.set_next_ptfx_asset("scr_trevor1")
                            graphics.start_networked_ptfx_non_looped_on_entity('scr_trev1_trailer_boosh',player.get_player_ped(player.player_id()),v3(0,0,0),v3(0,0,0),1)
                            entity.set_entity_velocity(player.get_player_ped(player.player_id()),dir)
                        end
                    else
                        entity.set_entity_velocity(player.get_player_ped(player.player_id()),v3(0,0,0))
                    end
                end
            end
        end
    end
)
_U_lighting.max,_U_lighting.min,_U_lighting.mod=100,1,5



_U_fast_respawn=menu.add_feature(
    lang("复活时归位"),
    "toggle",
    main_self.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if ped.get_ped_health(my_ped)==0 then
                local lastpos=player.get_player_coords(me)
                c=0
                while true do
                    system.yield(0)
                    entity.set_entity_coords_no_offset(my_ped,lastpos)
                    if controls.is_control_pressed(0,32) or controls.is_control_pressed(0,34) or controls.is_control_pressed(0,33) or controls.is_control_pressed(0,35) or controls.is_control_pressed(0,21) or controls.is_control_pressed(0,114) or controls.is_control_pressed(0,142) or controls.is_control_pressed(0,143) then
                        break
                    end
                    
                end
            end
        end
    end
)



--------------载具驾驶枪 Done----------------------
local cross_hair = menu.add_feature(
    "AN_get_aim_function",
    "toggle",
    main_weapon.id,
    function(a)
        if a.on then
            ui.show_hud_component_this_frame(14)
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
  end
)
cross_hair.hidden=true
function fuck_NPC_car(veh)
    entity.set_entity_coords_no_offset(veh,entity.get_entity_coords(veh))
    if _U_kill_fuck_NPC_car.on then
        ped.set_ped_health(veh,0)
    end
    system.yield(0)
    local me=player.player_id()
    local my_ped=player.get_player_ped(me)
    cross_hair.on=true
    local veh=player.get_entity_player_is_aiming_at(me)
    local hash=entity.get_entity_model_hash(veh)
    if streaming.is_model_a_vehicle(hash) then
        ped.set_ped_into_vehicle(my_ped,veh,-1)
        cross_hair.on=false
    elseif streaming.is_model_a_ped(hash) then
        fuck_NPC_car(player.get_entity_player_is_aiming_at(me))
    end
end

function fuck_Player_car(veh)
    ped.clear_ped_tasks_immediately(veh)
    system.yield(0)
    local me=player.player_id()
    local my_ped=player.get_player_ped(me)
    cross_hair.on=true
    local veh=player.get_entity_player_is_aiming_at(me)
    local hash=entity.get_entity_model_hash(veh)
    if streaming.is_model_a_vehicle(hash) then
        cross_hair.on=false
        ped.set_ped_into_vehicle(my_ped,veh,-1)
    elseif ped.is_ped_a_player(veh) then
        fuck_Player_car(veh)
    else
        fuck_NPC_car(veh)
    end
end

_U_vehicle_driver_weapon=menu.add_feature(
    lang("载具驾驶枪"),
    "toggle",
    main_weapon.id,
    function(a)
        local hash=0
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            local veh=player.get_entity_player_is_aiming_at(me)
            local hash=entity.get_entity_model_hash(veh)
            local pos=player.get_player_coords(me)
            if ped.is_ped_shooting(my_ped) then
                if streaming.is_model_a_vehicle(hash) then
                    ped.set_ped_into_vehicle(my_ped,veh,-1)
                elseif ped.is_ped_a_player(veh) then
                    fuck_Player_car(veh)
                elseif streaming.is_model_a_ped(hash) and ped.is_ped_in_any_vehicle(veh) then
                    fuck_NPC_car(veh)
                end
            end
        end
    end

)


_U_kill_fuck_NPC_car=menu.add_feature(
    lang("阻止NPC悬赏你"),
    'toggle',
    main_weapon.id,
    function(a)
    end
)


-----------------绳索枪-----------------------------


local rope_resolve=menu.add_feature(
    "绳索解析",
    "toggle",
    main_weapon.id,
    function(a)
        local me=player.player_id()
        local my_ped=player.get_player_ped(me)
        local rot = entity.get_entity_rotation(my_ped)
        while a.on do
            system.yield(0)
            --print(entity.has_entity_collided_with_anything(my_ped))
            if not entity.has_entity_collided_with_anything(my_ped) and _U_rope_weapon.on  then
                local pos=player.get_player_coords(me)
                local dir = cam.get_gameplay_cam_rot()
                entity.set_entity_collision(my_ped,true,true,true)
                dir:transformRotToDir()
                dir=v3(dir.x*1,dir.y*1,dir.z*1)
                pos=pos + dir
                entity.set_entity_coords_no_offset(my_ped,pos)
                entity.set_entity_rotation(my_ped,rot)
                system.yield(1)
            else
                rope_resolve.on=false
            end
        end
    end
)
rope_resolve.threaded=true



_U_rope_weapon=menu.add_feature(
    "绳索枪",
    "toggle",
    main_weapon.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if ped.is_ped_shooting(my_ped) then
                rope_resolve.on=true
            end
            if entity.has_entity_collided_with_anything(my_ped) then
                rope_resolve.on=false
            end
        end
    end
)


_U_rope_weapon.hidden=true
rope_resolve.hidden=true









------------------快速射击 Done---------------------------
---------------------此处代码基于 revive---------------
_U_fast_shooter=menu.add_feature(
    lang("快速射击"),
    "toggle",
    main_weapon.id,
    function(a)
        while a.on do
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            system.yield(0)
            if controls.get_control_normal(0,142)==0.0 then
                state=nil
            else
                state=1
            end
            while state do
                local v3_start = player.get_player_coords(me)
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                local v3_start = v3_start + dir*v3(1.5,1.5,1.5)+v3(0,0,0.4)
                local v3_end = v3_start + dir* v3(1500,1500,1500)+v3(0,0,0.4)
                local hash_weapon = ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, hash_weapon, my_ped, true, false, 1000)
                system.yield(0)
                return HANDLER_CONTINUE
            end
        end
    end


)
-------------------------------------------------------

--_U_DT
_U_DT=menu.add_feature(     -- Double Tap <-翻译是这个
    lang("双击"),
    "toggle",
    main_weapon.id,
    function(a)
        while a.on do
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            system.yield(0)
            while ped.is_ped_shooting(my_ped) do
                local success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                while not success do
                    success, v3_start = ped.get_ped_bone_coords(my_ped, 0x67f2, v3())
                    system.wait(0)
                end
                local dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1.5
                v3_start = v3_start + dir
                dir = nil
                local v3_end = player.get_player_coords(me)
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir * 1500
                v3_end = v3_end + dir
                local hash_weapon = ped.get_current_ped_weapon(my_ped)
                gameplay.shoot_single_bullet_between_coords(v3_start, v3_end, 1, hash_weapon, my_ped, true, false, 1000)
                system.yield(0)
                return HANDLER_CONTINUE
            end
        end
    end
)

---------------冻结战局 Done---------------------

_U_freeze_session=menu.add_feature(
    lang("冻结战局"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid = 0, 31 do
				if player.is_player_valid(pid) 
				and player.player_id() ~= pid 
				and not player.is_player_friend(pid) 
				and not player.is_player_modder(pid, -1) 
				and not entity.is_entity_dead(player.get_player_ped(pid)) then
					ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
				end
			end
        end
    end
)
------------------战局混乱------------------------
function get_random_pid()
    local pid=math.random(0,31)
    if player.is_player_valid(pid) and not player.is_player_friend(pid) and player.player_id() ~= pid then
        return pid
    else
        return false
    end
end

_U_fuck_session=menu.add_feature(
    lang("战局混乱"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid)  and player.player_id() ~= pid then
                    local killer=get_random_pid()
                    if killer then
                        fire.add_explosion(player.get_player_coords(pid),8,true,false,99999999,player.get_player_ped(killer))
                    end
                end
            end
        end
    end
)
-----------------摇晃战局--------------------
_U_fuck_session2=menu.add_feature(
    lang("摇晃战局"),
    "toggle",
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid)  and player.player_id() ~= pid then
                    local killer=get_random_pid()
                    if killer then
                        fire.add_explosion(player.get_player_coords(pid)-v3(0,0,30),1,false,true,99999999,player.get_player_ped(killer))
                    end
                end
            end
        end
    end
)
_U_firework_session=menu.add_feature(
    lang('战局烟花'),
    'toggle',
    main_net_all.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) then
                    system.yield(10)
                    local pos=player.get_player_coords(pid)
                    local r1=math.random(-200,200)
                    local r2=math.random(-200,200)
                    gameplay.shoot_single_bullet_between_coords(pos+v3(r1,r2,8),pos+v3(r1,r2,12), 0, 2138347493, player.get_player_ped(pid), false, true, 1000)
                end
            end
        end
    end
)


local clip_board_chat_bot=menu.add_feature(
    "将剪贴板的内容发送到公屏",
    "action",
    main_network.id,
    function(a)
        now_msg=''
        local msg=utils.from_clipboard()
        -- print(string.byte(msg),1)
        -- local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_clip.cfg",'wb')
        -- file:write(msg)
        -- file:close()
        -- local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_clip.cfg",'rb')
        -- now_msg=file:read('*a')
        -- file:close()
        now_msg=string.rep(msg,1)
        network.send_chat_message(tostring(now_msg),false)
    end
)

clip_board_chat_bot.hidden=true

---------------刷屏机器人------------------

_U_ad_m=menu.add_feature(
    lang("刷屏机器人"),
    "toggle",
    main_network.id,
    function(a)
        local start_time=utils.time()
        while a.on do
            system.yield(0)
            network.send_chat_message("你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了\n你\n妈\n死\n了",false)
            if utils.time()-start_time>=5 then
                cd_ad2.on=true
            end
        end
    end
)
cd_ad=menu.add_feature(
    "CD_刷屏机器人",
    "toggle",
    main_network.id,
    function(a)
        menu.notify(lang("刷屏机器人进入CD期 - 30秒"),"Universe",2)
        system.yield(30000)
        cd_ad2.on=false
        menu.notify(lang("刷屏机器人已完成CD"),"Universe",2)
    end
)
cd_ad2=menu.add_feature(
    "CD_刷屏机器人",
    "toggle",
    main_network.id,
    function(a)
        cd_ad.on=true
        while a.on do
            system.yield(0)
            _U_ad_m.on=false
        end
    end
)

cd_ad.hidden=true
cd_ad.threaded=true
cd_ad2.hidden=true
cd_ad2.threaded=true




_U_ad_bot=menu.add_feature(
    lang('广告机'),
    'parent',
    main_network.id
)

_U_ad_bot_send=menu.add_feature(
    lang('开始'),
    'toggle',
    _U_ad_bot.id,
    function(a)
        _U_ad_msg=''
        if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_ad_bot_msg.cfg") then
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_ad_bot_msg.cfg",'r')
            _U_ad_msg=file:read('*a')
            file:close()
        else
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_ad_bot_msg.cfg",'w')
            file:write('')
            file:close()
        end
        while a.on do
            if not network.is_session_started() then
                script.set_global_i(1574587,1)
            end
            system.yield(0)
            if network.is_session_started() then
                _U_ad_start_time=utils.time()
                while a.on do
                    system.yield(_U_ad_bot_delay.value)
                    network.send_chat_message(_U_ad_msg,false)
                    if utils.time()-_U_ad_start_time>=_U_ad_bot_cd2.value then
                        script.set_global_i(1574587,0)
                        system.yield(1000)
                        script.set_global_i(1574587,1)
                        system.yield(1000)
                        script.set_global_i(1574587,0)
                        system.yield(1000)
                        script.set_global_i(1574587,1)
                        system.yield(1000)
                    end
                end
            end
        end
    end
)
_U_ad_bot_delay=menu.add_feature(
    lang('延迟(毫秒)'),
    'action_value_i',
    _U_ad_bot.id
)
_U_ad_bot_delay.max,_U_ad_bot_delay.min,_U_ad_bot_delay.mod=60000,0,10
_U_ad_bot_ter=menu.add_feature(
    lang('教程'),
    'action',
    _U_ad_bot.id,
    function()
        menu.notify(lang('打开')..utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_ad_bot_msg.cfg"..lang('文件，写入你想要发送的广告内容'),'Universe',20)
    end
)
_U_ad_bot_cd2=menu.add_feature(
    lang('超时(秒)'),
    'action_value_i',
    _U_ad_bot.id
)
_U_ad_bot_cd2.max,_U_ad_bot_cd2.min,_U_ad_bot_cd2.mod=60,0,1





















------------------------菜单设置--------------------------

_U_ozark_titles={
    "欧扎克的跑路骗局？",
    "这真是个天大的笑话，对吗？",
    "欧扎克永远的神！！！",
    "这是个多么明显的骗局",
    "欧扎克更新V38？",
    '噢！我们表示真挚的道歉',
    "这就像精美的葡萄酒",
    "它看起来很火!!!!做得好",
    "Øzark",
    "是的，我们拿了你们的钱跑了！！",
    "我们没有公布源代码，懂了吗？",
    "你为什么还在用欧扎克？",
    "你为什么不买个2Take1？这听起来很荒唐，对吧？",
    "记得叫你的亲朋好友买个Øzark，因为这很酷",
    "Øzark Beta",
    "Øzark退出骗局？",
    "噢！不！你为什么要走~",
    "是的，我们在今天收到了来自Take2的传真",
    "要求我们立即关停Øzark的服务器",
    "不要悲伤，不要难过，因为所有经销商都是亏损的！",
    "请不要为难他们，他们都是很出色的人",
    "我不知道该怎么告诉你这个悲痛的消息",
    "没错，如你所见，老子回来了！",
    "fun menu?",
    "I never meaning a fun lua!"
}




_U_ozark_title=menu.add_feature(
    "Øzark"..lang("的头部信息"),
    "toggle",
    main_options.id,
    function(a)
        local x=math.random(1,#_U_ozark_titles)
        local lenth=#_U_ozark_titles[x]*0.002+0.012
        while a.on do
            system.yield(0)
            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
            ui.set_text_color(255, 255, 255, 125)				
            ui.set_text_scale(0.35)
            ui.set_text_font(0)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text("F4",v2(0.5,0.16))
            ui.set_text_scale(0.4)
            ui.set_text_color(255, 100, 100, 225)
            ui.draw_text(lang(_U_ozark_titles[x]),v2(0.5-lenth,0.13))
        end
    end


)
local test=menu.add_feature(
    'test',
    'toggle',
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            for i=0,999 do
                if controls.get_control_normal(0,251)==1.0 then
                    print(i)
                end
            end
        end
    end
)
test.hidden=true






_U_time_title_options=menu.add_feature(
    lang('时间信息设置'),
    'parent',
    main_options.id
)

_U_time_title_option1=menu.add_feature(
    lang('字体大小'),
    'action_value_f',
    _U_time_title_options.id
)
_U_time_title_option2=menu.add_feature(
    lang('字体'),
    'action_value_i',
    _U_time_title_options.id
)

_U_time_title_optionx=menu.add_feature(
    'X',
    'action_value_i',
    _U_time_title_options.id
)
_U_time_title_optiony=menu.add_feature(
    'Y',
    'action_value_i',
    _U_time_title_options.id
)
_U_time_title_option3=menu.add_feature(
    lang('样式'),
    'action_value_str',
    _U_time_title_options.id
)
_U_time_title_optionr=menu.add_feature(
    'R',
    'action_value_i',
    _U_time_title_options.id
)
_U_time_title_optiong=menu.add_feature(
    'G',
    'action_value_i',
    _U_time_title_options.id
)
_U_time_title_optionb=menu.add_feature(
    'B',
    'action_value_i',
    _U_time_title_options.id
)
_U_time_title_option1.max,_U_time_title_option1.min,_U_time_title_option1.mod=1,0,0.01
_U_time_title_option2.max,_U_time_title_option2.min,_U_time_title_option2.mod=100,0,1
_U_time_title_optionx.max,_U_time_title_optionx.min,_U_time_title_optionx.mod=100,0,1
_U_time_title_optiony.max,_U_time_title_optiony.min,_U_time_title_optiony.mod=100,0,1
_U_time_title_optionr.max,_U_time_title_optionr.min,_U_time_title_optionr.mod=255,0,1
_U_time_title_optiong.max,_U_time_title_optiong.min,_U_time_title_optiong.mod=255,0,1
_U_time_title_optionb.max,_U_time_title_optionb.min,_U_time_title_optionb.mod=255,0,1
_U_time_title_option3:set_str_data({
    '%H:%M:%S',
    '%Y-%m-%d %H:%M:%S',
    '%m-%d %H:%M:%S',
    '%m-%d',
    '%H:%M',
    '%m-%d %H:%M',
    '%Y/%m/%d %H:%M:%S',
    '%m-%d-%Y %H:%M:%S',
    '%m/%d/%Y %H:%M:%S',
})



_U_time_title=menu.add_feature(
    lang("时间信息"),
    "toggle",
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            local date=os.date(_U_time_title_option3:get_str_data()[_U_time_title_option3.value+1])
            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
            ui.set_text_color(_U_time_title_optionr.value,_U_time_title_optiong.value,_U_time_title_optionb.value, 255)				
            ui.set_text_scale(_U_time_title_option1.value)
            ui.set_text_font(_U_time_title_option2.value)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text(date,v2(_U_time_title_optionx.value*0.01,_U_time_title_optiony.value*0.01))
        end
    end


)
_U_time_title.threaded=true
_U_time_title.hidden=false



--主机列表

_U_host_info=menu.add_feature(
    lang("主机序列"),
    "toggle",
    main_options.id,
    function(a)
        local r,g,b=math.random(0,255),math.random(0,255),math.random(0,255)
        while a.on do
            local msg=''
            local msg2=''
            local msg3=''
            local msg4=''
            local msg5=''
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) then
                    player__U_host_info=player.get_player_host_priority(pid)
                    player_name=player.get_player_name(pid)
                    if player__U_host_info==1 then
                        msg='1. '..player_name
                    elseif player__U_host_info==2 then
                        msg2='\n2. '..player_name
                    elseif player__U_host_info==3 then
                        msg3='\n3. '..player_name
                    elseif player__U_host_info==4 then
                        msg4='\n4. '..player_name
                    elseif player__U_host_info==5 then
                        msg5='\n5. '..player_name
                    end
                end
            end
            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
            ui.set_text_color(r,g,b, 255)				
            ui.set_text_scale(0.35)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text(msg..msg2..msg3..msg4..msg5..'\n'..lang('你的序号')..': '..player.get_player_host_priority(player.player_id()),v2(0.8,0.3),9999)
        end
    end
)























--------------------保护选项-------------------
----------------标记所有玩家 Done------------------
_U_fuck_them=menu.add_feature(
    lang("阻止同步--标记所有玩家"),
    "toggle",
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            if a.on then
                for pid=0,31 do
                    if pid~=me and player.is_player_valid(pid) then
                        player.set_player_as_modder(pid,anti_sync)
                    end
                end
            else
                for pid=0,31 do
                    if pid~=me and player.is_player_valid(pid) then
                        player.unset_player_as_modder(pid,anti_sync)
                    end
                end
            end
        end
    end
                
)

_U_unmark=menu.add_feature(
    lang('取消标记'),
    'toggle',
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                for i=2,13 do
                    if player.is_player_modder(pid,i) then
                        player.unset_player_as_modder(pid,i)
                    end 
                end
            end
        end
    end
)


_U_key_words={
    "QQ",
    "VX",
    "V.X",
    "Q.Q",
    "vx",
    "qq",
    "q.q",
    "v.x",
    "shua",
    "Shua",
    "SHUA",
    "SHUa",
    "sHUA",
    "微信",
    "威信",
    "萌新一起玩",
    "信用保障",
    "安全稳定",
    "解锁",
    "解所",
    "Q群",
    "q群",
    "全网最低",
    "全往最低",
    "店铺",
    "激情大片",
    "澳门赌场",
    "抠逼自慰",
    "加群",
    "刷钱",
    "淘宝",
    "十年店铺",
    "支持花呗",
    "地堡刷金",
    "有妹子",
    "扣群",
    "扣扣",
    "淘b",
    "代刷",
    "淘β",
    "代帅",
    "平台安全保障",
    "外褂",
    "加Q",
    "加q",
    "+q",
    "+Q",
    "永不",
    "金b",
    "Î¢ÐÅ",
    "ÍþÐÅ",
    "ÃÈÐÂÒ»ÆðÍæ",
    "ÐÅÓÃ±£ÕÏ",
    "°²È«ÎÈ¶¨",
    "½âËø",
    "½âËù",
    "QÈº",
    "qÈº",
    "È«Íø×îµÍ",
    "È«Íù×îµÍ",
    "µêÆÌ",
    "¼¤Çé´óÆ¬",
    "°ÄÃÅ¶Ä³¡",
    "¿Ù±Æ×ÔÎ¿",
    "¼ÓÈº",
    "Ë¢Ç®",
    "ÌÔ±¦",
    "Ê®ÄêµêÆÌ",
    "Ö§³Ö»¨ßÂ",
    "µØ±¤Ë¢½ð",
    "ÓÐÃÃ×Ó",
    "¿ÛÈº",
    "¿Û¿Û",
    "Е�®Д©ӯ",
    "Е�ғД©ӯ",
    "ХҚҲФ–°Д�қХӢ·ГҶ�",
    "Д©ӯГ”�Д©�И��",
    "Е®‰Е…�Г�ЁЕ®�",
    "Х§ёИ”ғ",
    "Х§ёФ‰қ",
    "QГ�¤",
    "qГ�¤",
    "Е…�Г�‘Ф�қД�Ҷ",
    "Е…�Е�қФ�қД�Ҷ",
    "Е�—И“�",
    "Ф©қФҒ…Е¤§Г‰‡",
    "Ф�ЁИ—�ХӢҲЕ��",
    "Фҳ�Иқ�Х‡�Ф…°",
    "Еҳ�Г�¤",
    "Е�·И’±",
    "Ф·�Е®�",
    "ЕҷғЕ№�Е�—И“�",
    "Ф”�ФҲғХҳ±Е‘—",
    "Е�°Е�ӯЕ�·И‡‘",
    "Ф�‰Е¦№Е­Қ",
    "Ф‰ёГ�¤",
    "Ф‰ёФ‰ё",
    "寰�淇�",
    "濞佷俊",
    "钀屾柊涓€璧风帺",
    "淇＄敤淇濋殰",
    "瀹夊叏绋冲畾",
    "瑙ｉ攣",
    "瑙ｆ墍",
    "Q缇�",
    "q缇�",
    "鍏ㄧ綉鏈€浣�",
    "鍏ㄥ線鏈€浣�",
    "搴楅摵",
    "婵€鎯呭ぇ鐗�",
    "婢抽棬璧屽満",
    "鎶犻€艰嚜鎱�",
    "鍔犵兢",
    "鍒烽挶",
    "娣樺疂",
    "鍗佸勾搴楅摵",
    "鏀�鎸佽姳鍛�",
    "鍦板牎鍒烽噾",
    "鏈夊�瑰瓙",
    "鎵ｇ兢",
    "鎵ｆ墸",
    "ๅพฎไฟก",
    "ๅจ�ไฟก",
   "��ๆ–ฐไธ€่ตท็�ฉ",
   "ไฟก็”จไฟ�้��",
   "ๅฎ�ๅ…จ็จณๅฎ�",
   "งฃ้”�",
   "งฃๆ�€",
   "Q็พค",
   "q็พค",
    "ๅ…จ็ฝ‘ๆ�€ไฝ�",
    "ๅ…จๅพ€ๆ�€ไฝ�",
    "ๅบ—้“บ",
    "ๆฟ€ๆ�…ๅคง็��",
    "ๆพณ้—จ่ต�ๅ�บ",
    "ๆ� ้€ผ่�ชๆ…ฐ",
    "ๅ� ็พค",
    "ๅ�ท้’ฑ",
    "ๆท�ๅฎ�",
    "ๅ��ๅนดๅบ—้“บ",
    "ๆ”ฏๆ��่�ฑๅ‘—",
    "ๅ�ฐๅ กๅ�ท้�‘",
    "ๆ��ๅฆนๅญ�",
    "ๆ�ฃ็พค",
    "ๆ�ฃๆ�ฃ",
    ".com",
    ".cn",
    ".cc",
    ".xyz",
    ".top",
    ".us",
    ".ru",
    ".net",
    ".ad",
    ".ae",
    ".wang",
    ".pub",
    ".xin",
    ".cc",
    ".tv",
    ".uk",
    ".org",
    ".jp",
    ".edu",
    ".gov",
    ".mil",
    ".online",
    "ltd",
    ".shop",
    ".beer",
    ".art",
    ".luxe",
    ".co",
    ".vip",
    ".club",
    ".fun",
    ".tech",
    ".store",
    ".red",
    ".pro",
    ".kim",
    ".ink",
    ".group",
    ".work",
    ".ren",
    ".biz",
    ".mobi",
    ".site",
    ".asia",
    ".law",
    ".me",
    ".COM",
    ".CN",
    ".CC",
    ".XYZ",
    ".TOP",
    ".US",
    ".RU",
    ".NET",
    ".AD",
    ".AE",
    ".WANG",
    ".PUB",
    ".XIN",
    ".CC",
    ".TV",
    ".UK",
    ".ORG",
    ".JP",
    ".EDU",
    ".GOV",
    ".MIL",
    ".ONLINE",
    ".LTD",
    ".SHOP",
    ".BEER",
    ".ART",
    ".LUXE",
    ".CO",
    ".VIP",
    ".CLUB",
    ".FUN",
    ".TECH",
    ".STORE",
    ".RED",
    ".PRO",
    ".KIM",
    ".INK",
    ".GROUP",
    ".WORK",
    ".REN",
    ".BIZ",
    ".MOBI",
    ".SITE",
    ".ASIA",
    ".LAW",
    ".ME",
    ".cloud",
    ".love",
    ".press",
    ".space",
    ".video",
    ".fit",
    ".yoga",
    ".info",
    ".design",
    ".link",
    ".live",
    ".wiki",
    ".life",
    ".world",
    ".run",
    ".show",
    ".city",
    ".gold",
    ".today",
    ".plus",
    ".cool",
    ".icu",
    ".company",
    ".chat",
    ".zone",
    ".fans",
    ".host",
    ".center",
    ".email",
    ".fund",
    ".social",
    ".team",
    ".guru",
    ".CLOUD",
    ".LOVE",
    ".PRESS",
    ".SPACE",
    ".VIDEO",
    ".FIT",
    ".YOGA",
    ".INFO",
    ".DESIGN",
    ".LINK",
    ".LIVE",
    ".WIKI",
    ".LIFE",
    ".WORLD",
    ".RUN",
    ".SHOW",
    ".CITY",
    ".GOLD",
    ".TODAY",
    ".PLUS",
    ".COOL",
    ".ICU",
    ".COMPANY",
    ".CHAT",
    ".ZONE",
    ".FANS",
    ".HOST",
    ".CENTER",
    ".EMAIL",
    ".FUND",
    ".SOCIAL",
    ".TEAM",
    ".GURU"
}
if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\banned_chat.cfg") then
    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\banned_chat.cfg",'r')
    _U_key_words=file:read('*a'):split('\n')
    file:close()
end


_U_key_words_name={
    "shua",
    "Shua",
    "SHua",
    "SHUa",
    "SHUA",
    "sHua",
    "sHUa",
    "sHUA",
    "shUa",
    "ShUA",
    "shuA",
    "coin",
    "Coin",
    "COin",
    "COIn",
    "COIN",
    "cOin",
    "cOIn",
    "cOIN",
    "QQ",
    "Qq",
    "qQ",
    "qq",
    'VX',
    "vx",
    "Vx",
    "vX",
    "Qqun",
    "qQun",
    "q_qun",
    "q_Qun",
    "Q_Qun",
    "Q_QUN",
    "QUN_",
    "qun_",
    "Qun_"
}





if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\name_banned.cfg") then
    local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\name_banned.cfg",'r')
    _U_key_words_name=file:read('*a'):split('\n')
    file:close()
end
-------------------拦截广告机-----------------



local user_name_trial=menu.add_feature(
    "检测玩家名字",
    "toggle",
    main_protect.id,
    function(a)
        if a.on then
            user_name_trial_id=event.add_event_listener("player_join",function(b)
                local pid=b.player
                local player_name=player.get_player_name(pid)
                for i=1,#_U_key_words_name do
                    if player_name:match("%".._U_key_words_name[i]) and player.is_player_friend(pid) and pid~=player.player_id() then
                        if _U_show_block_msg.on then
                            menu.notify(lang("检测到类似广告机昵称\n正在混合崩溃+踢出玩家+混合任务+公寓邀请+送上岛+交易错误的玩家名为：").."\n\n"..player.get_player_name(pid).."\nR*ID为\n"..player.get_player_scid(pid).."\nIP:"..intToIp(player.get_player_ip(pid)),"Universe",6,8)
                        end
                        for x=1,4 do
                            send_script_event("Crash "..tostring(x), pid, {pid, generic_player_global(pid)})
                        end
                        network.network_session_kick_player(pid)
                        network.force_remove_player(pid)
                        send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
                        for x=1,14 do
                            send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
                        end
                        for x=1,300 do
                            send_script_event("Transaction error", pid, {pid, generic_player_global(pid)})
                        end
                    
                        for x=1,300 do
                            send_script_event("Send to mission", pid, {pid, generic_player_global(pid)})
                        end
                        for x=1,300 do
                            send_script_event("Send to Perico island", pid, {pid, generic_player_global(pid)})
                        end
                        for x=1,300 do
                            send_script_event("Apartment invite", pid, {pid, generic_player_global(pid)})
                        end
                        return HANDLER_CONTINUE
                    end
                end
            end)
        else
            event.remove_event_listener("player_join",user_name_trial_id)
        end
    end
)
user_name_trial.hidden=true
user_name_trial.threaded=true



_U_send_block_msg=menu.add_feature(
    lang("发送拦截信息"),
    "toggle",
    main_protect.id,
    function()
        if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Block_msg.cfg") then
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Block_msg.cfg",'r')
            Block_msg=file:read('*a')
            file:close()
        else
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Block_msg.cfg",'w')
            file:write('\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nUniverse已为您拦截广告机:&name&')
            file:close()
            Block_msg='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nUniverse已为您拦截广告机:&name&'
        end
    end
)

_U_show_block_msg=menu.add_feature(
    lang('显示拦截信息'),
    'toggle',
    main_protect.id
)


_U_Chat_trial=menu.add_feature(
    "拦截广告机",
    "toggle",
    main_protect.id,
    function(a)
        if a.on then
            _U_Chat_trial_id=event.add_event_listener("chat",function(b)
                local pid=b.player
                local msg=b.body
                if player.is_player_valid(pid) and not player.is_player_friend(pid) and pid~=player.player_id() then
                    for i=1,#_U_key_words do
                        if msg:match("%".._U_key_words[i]) then
                            if _U_show_block_msg.on then
                                menu.notify(lang("检测到广告机\n正在混合崩溃+踢出玩家+混合任务+公寓邀请+送上岛+交易错误+黑名单的玩家名为：").."\n\n"..player.get_player_name(pid).."\nR*ID为\n"..player.get_player_scid(pid).."\nIP:"..intToIp(player.get_player_ip(pid)),"Universe",6,8)
                            end
                            if _U_send_block_msg.on then
                                --local fasong_msg=string.format("U\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nn\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ni\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nv\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ne\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nr\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ns\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ne\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nUniverse1.6\n拦截广告机：%s",player.get_player_name(pid))
                                --local fasong_msg=fasong_msg.."\nIP:"..intToIp(player.get_player_ip(pid)).."\nR*ID:\n"..player.get_player_scid(pid).."\n欢迎加入2T交流群:872986398"
                                if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Block_msg.cfg") or Block_msg=='\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nUniverse已为您拦截广告机:&name&' then
                                    Block_msg2='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'..'Universe已为您拦截广告机:'..player.get_player_name(pid)
                                else
                                    Block_msg2=tostring(string.gsub(Block_msg,'&name&',player.get_player_name(pid)))
                                    Block_msg2=tostring(string.gsub(Block_msg2,'&ip&',intToIp(player.get_player_ip(pid))))
                                    Block_msg2=tostring(string.gsub(Block_msg2,'&scid&',player.get_player_scid(pid)))
                                    Block_msg2=tostring(string.gsub(Block_msg2,'\\n','\n'))
                                    Block_msg2=tostring(string.gsub(Block_msg2,'&me&',player.get_player_name(player.player_id())))
                                    Block_msg2=Block_msg2..'  ---------Universe Lua'
                                end
                                network.send_chat_message(Block_msg2,false)
                            end
                            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\cfg\\scid.cfg","a+")
                            local msg=file:read('*a')
                            if not string.find(msg,string.format("%x",player.get_player_scid(pid))) then
                                file:write("\nad_bot:"..string.format("%x",player.get_player_scid(pid))..":c")
                            end
                            file:close()
                            for x=1,4 do
                                send_script_event("Crash "..tostring(x), pid, {pid, generic_player_global(pid)})
                            end
                            network.network_session_kick_player(pid)
                            send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
                            network.force_remove_player(pid)
                            for x=1,14 do
                                send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
                            end
                            for x=1,300 do
                                send_script_event("Transaction error", pid, {pid, generic_player_global(pid)})
                            end
                        
                            for x=1,300 do
                                send_script_event("Send to mission", pid, {pid, generic_player_global(pid)})
                            end
                            for x=1,300 do
                                send_script_event("Send to Perico island", pid, {pid, generic_player_global(pid)})
                            end
                            for x=1,300 do
                                send_script_event("Apartment invite", pid, {pid, generic_player_global(pid)})
                            end
                            return HANDLER_CONTINUE
                        end
                    end
                end
            end)
        else
            event.remove_event_listener("chat",_U_Chat_trial_id)
        end
    end
)
_U_Chat_trial.hidden=true
_U_Chat_trial2=menu.add_feature(
    lang('智能拦截广告机'),
    'toggle',
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            if get_session_lenth()<=4 then
                if _U_Chat_trial.on then
                    _U_Chat_trial.on=false
                    user_name_trial.on=false
                end
            else
                if not _U_Chat_trial.on then
                    _U_Chat_trial.on=true
                    user_name_trial.on=true
                end
            end
        end
    end
)
menu.add_feature(lang('拦截广告机自定义教程'),
'action',
main_protect.id,
function()
    menu.notify(lang('打开')..utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Block_msg.cfg"..lang('文件，写入你想要发送的内容，&name&表示作弊者名字,&ip&表示作弊者IP,&scid&表示作弊者R*ID,&me&表示你的名字'),'Universe',20)
end)

-----------------反弹脚本--------------------
_U_anti_scrpit=menu.add_feature(
    lang("反弹脚本事件").." Beta",
    "toggle",
    main_protect.id,
    function(a)
        menu.notify(lang("此功能正处于测试状态，可能会有意想不到的BUG"),"Universe",5,6)
        if a.on then
            scrpit_hook_id=hook.register_script_event_hook(function(pid,me,script)
                --print(pid,me,scrpit)
                if pid~=me then
                    local script_id=script[1]
                    table.remove(script,1)
                    script.trigger_script_event(script_id,pid,script)
                    menu.notify(lang("收到来自")..player.get_player_name(pid)..lang("的脚本事件，已反弹"),"Universe",5)
                end
            end)
        else
            hook.remove_script_event_hook(scrpit_hook_id)
        end
    end
)




------------------Ozark's protect Done------------------
_U_fuck_myself=menu.add_feature(
    "Øzark"..lang("的紧急避险"),
    "toggle",
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            if a.on then
                gameplay.clear_area_of_objects(player.get_player_coords(player.player_id()),1000,0)
                gameplay.clear_area_of_vehicles(player.get_player_coords(player.player_id()),100,false,false,false,false,false)
                gameplay.clear_area_of_peds(player.get_player_coords(player.player_id()),1000,false)
                gameplay.clear_area_of_cops(player.get_player_coords(player.player_id()),1000,false)
                local all_objs=object.get_all_objects()
                local all_peds=ped.get_all_peds()
                local all_vehicles=vehicle.get_all_vehicles()
                if all_objs[1] then
                    for i=1,#all_objs do
                        if all_objs[i] and all_objs[i]~=water_obj and all_objs[i]~=water_obj4 and all_objs[i]~=water_obj3 then
                            entity.delete_entity(all_objs[i])
                        end
                    end
                end
                if all_peds[1] then
                    for i=1,#all_peds do
                        if all_peds[i] and not ped.is_ped_a_player(all_peds[i]) and all_peds[i]~=water_obj2 then
                            entity.delete_entity(all_peds[i])
                        end
                    end
                end
                if all_vehicles[1] then
                    for i=1,#all_vehicles do
                        if all_vehicles[i] and all_vehicles[i]~=player.get_player_vehicle(player.player_id()) then
                            entity.delete_entity(all_vehicles[i])
                        end
                    end
                end
                for pid=0,31 do
                    if pid~=player.player_id() and player.is_player_valid(pid) and a.on then
                        player.set_player_as_modder(pid,anti_sync)
                        entity.set_entity_visible(player.get_player_ped(pid),false)
                        player.set_player_visible_locally(pid,false)
                    end
                end
            else
                for pid=0,31 do
                    if pid~=player.player_id() and player.is_player_valid(pid) then
                        player.unset_player_as_modder(pid,anti_sync)
                        entity.set_entity_visible(player.get_player_ped(pid),true)
                        player.set_player_visible_locally(pid,true)
                    end
                end
            end
        end
    end
)



--------------------------functions of AA-----------------------------

local function AA_location(me)
    local my_ped=player.get_player_ped(me)
    local pos=player.get_player_coords(me)
    entity.set_entity_coords_no_offset(my_ped,pos + v3(math.random(0,3),math.random(0,3),0))
    system.yield(0)
    entity.set_entity_coords_no_offset(my_ped,pos - v3(math.random(1,3),math.random(1,3),0))

end


local function Back_kill(pid,my_ped,me)
    local pos=player.get_player_coords(pid)
    local my_pos=player.get_player_coords(me)
    if my_pos>pos then
        entity.set_entity_coords_no_offset(my_ped,pos - v3(math.random(0,3),math.random(0,3),0))
    else
        entity.set_entity_coords_no_offset(my_ped,pos + v3(math.random(0,3),math.random(0,3),0))
    end
end

local function remove_player_gun(pid)
    local enemy_ped=player.get_player_ped(pid)
    local current_weapon=ped.get_current_ped_weapon(enemy_ped)
    weapon.remove_weapon_from_ped(enemy_ped,current_weapon)
end

local function freeze_player(pid)
    local enemy_ped=player.get_player_ped(pid)
    ped.clear_ped_tasks_immediately(enemy_ped)
end

local function ghost_head(pid,me,my_ped)
    local enemy_ped=player.get_player_ped(pid)
    local z=cam.get_gameplay_cam_rot().z
    if ped.is_ped_shooting(enemy_ped) then
        entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z+90))
    else
        entity.set_entity_rotation(player.get_player_ped(player.player_id()),v3(0,0,z-90))
    end
    
end



----------------Anti - Aim-----------------------------
_U_Anti_aim=menu.add_feature(
    lang("反自瞄"),
    "value_str",
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            for pid=0,31 do
                if player.is_player_valid(pid) and pid~=me and player.get_entity_player_is_aiming_at(pid)==my_ped then
                    if a.value==0 then
                        AA_location(me)
                    elseif a.value==1 then
                        Back_kill(pid,my_ped,me)
                    elseif a.value==2 then
                        remove_player_gun(pid)
                    elseif a.value==3 then
                        freeze_player(pid)
                    elseif a.value==4 then
                        ghost_head(pid,me,my_ped)
                    end
                end
            end
        end
    end

)
_U_Anti_aim:set_str_data({
    lang("假身"),
    lang("背刺"),
    lang("收枪"),
    lang("冻结"),
    lang("鬼探头")
}

)


_U_hack_list={}
_U_lisc_hack=menu.add_feature(
    lang("监听作弊者"),
    "toggle",
    main_protect.id,
    function(a)
        for pid=0,31 do
            if pid~= player.player_id() then
                if player.is_player_modder(pid,1 << 0x03) or player.is_player_modder(pid,1 << 0x04) or player.is_player_modder(pid,1 << 0x05) or player.is_player_modder(pid,1 << 0x0C) or player.is_player_modder(pid,1 << 0x0D) or player.is_player_modder(pid,1 << 0x0E) then
                    if not _U_hack_list[pid+1] then
                        _U_hack_list[pid+1]=true
                    end
                else
                    _U_hack_list[pid+1]=false
                end
            end
        end
        if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_msg.cfg") then
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_msg.cfg",'r')
            msg_h=file:read('*a')
            file:close()
        else
            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_msg.cfg",'w')
            file:write('&name&你这个傻逼正在尝试崩溃一个2Take1用户，请立即停手并即刻反悔你的所作所为')
            file:close()
            msg_h='&name&你这个傻逼正在尝试崩溃一个2Take1用户，请立即停手并即刻反悔你的所作所为'
        end
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if pid~= player.player_id() then
                    if player.is_player_modder(pid,1 << 0x03) or player.is_player_modder(pid,1 << 0x04) or player.is_player_modder(pid,1 << 0x05) or player.is_player_modder(pid,1 << 0x0C) or player.is_player_modder(pid,1 << 0x0D) or player.is_player_modder(pid,1 << 0x0E) then
                        if not _U_hack_list[pid+1] then
                            if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_msg.cfg") or msg_h=='&name&你这个傻逼正在尝试崩溃一个2Take1用户，请立即停手并即刻反悔你的所作所为' then
                                msg_h2=player.get_player_name(pid)..lang('你这个傻逼正在尝试崩溃一个2Take1用户，请立即停手并即刻反悔你的所作所为')
                            else
                                msg_h2=tostring(string.gsub(msg_h,'&name&',player.get_player_name(pid)))
                                msg_h2=tostring(string.gsub(msg_h2,'&ip&',intToIp(player.get_player_ip(pid))))
                                msg_h2=tostring(string.gsub(msg_h2,'&scid&',player.get_player_scid(pid)))
                                msg_h2=tostring(string.gsub(msg_h2,'\\n','\n'))
                                msg_h2=tostring(string.gsub(msg_h2,'&me&',player.get_player_name(player.player_id())))
                                msg_h2=msg_h2..'  ---------Universe Lua'
                            end
                            network.send_chat_message(msg_h2,false)
                            _U_hack_list[pid+1]=true
                        end
                    end
                end
            end
            user_name_trial_id2=event.add_event_listener("player_join",function(b)
                if b.player==player.player_id() then
                    _U_hack_list={}
                end
            end)
            event.remove_event_listener("player_join",user_name_trial_id2)
        end
    end
)
menu.add_feature(lang('自定义嘲讽教程'),
'action',
main_protect.id,
function()
    menu.notify(lang('打开')..utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_msg.cfg"..lang('文件，写入你想要发送的内容，&name&表示作弊者名字,&ip&表示作弊者IP,&scid&表示作弊者R*ID,&me&表示你的名字'),'Universe',20)
end)
---------------------观察者检测 Done---------------
_U_fuck_spectater=menu.add_feature(
    lang("监听观察者"),
    "toggle",
    main_protect.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and player.is_player_spectating(pid) and pid~=player.player_id() then
                    who = player.get_player_name(network.get_player_player_is_spectating(pid))
                    if who then
                        who_spec=player.get_player_name(pid)
                        ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
                        ui.set_text_color(255, 255, 0, 255)				
                        ui.set_text_scale(0.5)
                        ui.set_text_font(0)
                        ui.set_text_centre(true)
                        ui.set_text_outline(true)
                        ui.draw_text(who_spec..lang(" 正在观察 ")..who,v2(0.5,0.96))
                    end
                end
            end
        end
    end

)



_U_Anti_spectater=menu.add_feature(
    lang("反观察"),
    "toggle",
    main_protect.id,
    function(a)
        local me=player.player_id()
        local last_pos=player.get_player_coords(me)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            local last_pos=player.get_player_coords(me)
            if a.on then
                for pid=0,31 do
                    if player.is_player_valid(pid) and player.is_player_spectating(pid) and pid~=player.player_id() then
                        if network.get_player_player_is_spectating(pid)==player.player_id() then
                            local last_pos=player.get_player_coords(player.player_id())
                            while player.is_player_valid(pid) and player.is_player_spectating(pid) and network.get_player_player_is_spectating(pid)==player.player_id() do
                                if player.is_player_valid(pid) and player.is_player_spectating(pid) and network.get_player_player_is_spectating(pid)==player.player_id()then
                                    system.yield(0)
                                    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),player.get_player_coords(pid))
                                    entity.set_entity_visible(player.get_player_ped(player.player_id()),false)
                                else
                                    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),last_pos)
                                    entity.set_entity_visible(player.get_player_ped(player.player_id()),true)
                                end
                            end
                        end
                    end
                end
            else
                entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),last_pos)
                entity.set_entity_visible(player.get_player_ped(player.player_id()),true)
            end
        end
    end

)



_U_notify_anti_fps_att=menu.add_feature(
    lang('性能优化通知'),
    'toggle',
    main_protect.id
)

_U_vehicleNearByStorage = {}
_U_lastNotify = 0
_U_Anti_Fps_attack=menu.add_feature(
    lang('性能优化 - 强度'),
    'value_i',
    main_protect.id,
    function(a)
        local limit = a.max-a.value
        for i in ipairs(vehicle.get_all_vehicles())do
            local veh = vehicle.get_all_vehicles()[i]
            if _U_vehicleNearByStorage[entity.get_entity_model_hash(veh)] ~= nil then
            _U_vehicleNearByStorage[entity.get_entity_model_hash(veh)] = _U_vehicleNearByStorage[entity.get_entity_model_hash(veh)]+1
            else
            _U_vehicleNearByStorage[entity.get_entity_model_hash(veh)] = 1
            end    
            if (_U_vehicleNearByStorage[entity.get_entity_model_hash(veh)] > limit) 
            and ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())) ~= veh then
            local pos = entity.get_entity_coords(veh)
            pos.y = 20000
            network.request_control_of_entity(veh)
            entity.set_entity_coords_no_offset(veh,pos)
            entity.freeze_entity(veh,true)
            entity.set_entity_as_no_longer_needed(veh)
            if (os.time() - _U_lastNotify) > 1 and a.value~=a.max and _U_notify_anti_fps_att.on then
                menu.notify("优化了可能导致掉帧的车辆 " .. '0x'..string.format("%x",tonumber(entity.get_entity_model_hash(veh))),"Universe",5,140) 
                _U_lastNotify = os.time()
            end
            entity.delete_entity(veh)
        end
      end
      for i in ipairs(vehicle.get_all_vehicles())do
        local veh = vehicle.get_all_vehicles()[i]
        if entity.is_entity_dead(veh) then
          local pos = entity.get_entity_coords(veh)
          pos.y = 20000
          network.request_control_of_entity(veh)
          entity.set_entity_coords_no_offset(veh,pos)
          entity.freeze_entity(veh,true)  
          entity.set_entity_as_no_longer_needed(veh)
          entity.delete_entity(veh)
        end    
      end  
      _U_vehicleNearByStorage = {}
      if a.on then
          return HANDLER_CONTINUE
      else
          return HANDLER_POP
      end
    end
)
_U_Anti_Fps_attack.max,_U_Anti_Fps_attack.min,_U_Anti_Fps_attack.mod=10,0,1

--------------------武器--------------------
-------------------彩虹枪 Done-------------
_U_main_weapon_color=menu.add_feature(
    lang("彩虹枪"),
    "toggle",
    main_weapon.id,
    function(a)
        while a.on do
            for i, weapon_hash in pairs(weapon.get_all_weapon_hashes()) do
                if weapon.has_ped_got_weapon(player.get_player_ped(player.player_id()), weapon_hash) then
                    local number_of_tints = weapon.get_weapon_tint_count(weapon_hash)
                    if weapon_hash and weapon_hash ~= 2725352035 and number_of_tints > 0 then
                        weapon.set_ped_weapon_tint_index(player.get_player_ped(player.player_id()), weapon_hash, math.random(1, number_of_tints))
                    end
                end
            end
            system.yield(50)
        end
    end



)

_U_firework_gun=menu.add_feature(
    lang("烟花枪"),
    "toggle",
    main_weapon.id,
    function(a)
        while a.on do
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            system.yield(0)
            while ped.is_ped_shooting(my_ped) do
                local pos1=player.get_player_coords(me)
                local pos2 = player.get_player_coords(me)
                dir = cam.get_gameplay_cam_rot()
                dir:transformRotToDir()
                dir = dir*v3(30,30,30)
                pos1 = pos1 + dir
                dir = dir*v3(60,60,60)
                pos2 = pos2 + dir
                gameplay.shoot_single_bullet_between_coords(pos1,pos2, 1, 2138347493, my_ped, false, false, 2000)
                system.yield(0)
                return HANDLER_CONTINUE
            end
        end
    end
)

-------------------导弹连发 Done--------------

_U_speed_fire_veh=menu.add_feature(
    lang("车载武器快速射击"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        if a.on then
            local myped = player.get_player_ped(player.player_id())
            if ped.is_ped_in_any_vehicle(myped) == true then
              local Curveh = ped.get_vehicle_ped_is_using(myped)
              vehicle.set_vehicle_fixed(Curveh)
              vehicle.set_vehicle_deformation_fixed(Curveh)
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
_U_unlock_max_speed=menu.add_feature(
    lang("解锁载具速度上限"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        while a.on do
            system.yield(0)
            local my_veh=player.get_player_vehicle(player.player_id())
            entity.set_entity_max_speed(my_veh,999999999999999999)
        end

    end
)
_U_fast_get_car=menu.add_feature(
    lang('快速上下车'),
    'toggle',
    main_vehicle_menu.id,
    function(a)
        while a.on do
            system.yield(0)
            if controls.is_control_just_pressed(0,251) then
                if player.is_player_in_any_vehicle(player.player_id()) then
                    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()),player.get_player_coords(player.player_id()))
                else
                    local all_vehicles=vehicle.get_all_vehicles()
                    local nearleast_veh=0
                    local nearleast_dis=100000
                    for i=1,#all_vehicles do
                        if distanceToE(all_vehicles[i]) <=nearleast_dis then
                            nearleast_dis=distanceToE(all_vehicles[i])
                            nearleast_veh=all_vehicles[i]
                        end
                    end
                    if nearleast_dis<=7 and nearleast_dis>=0 and nearleast_veh~=0 then
                        system.yield(100)
                        if controls.get_control_normal(0,251)==1.0 then
                            system.yield(100)
                            if controls.get_control_normal(0,251)==1.0 then
                                local veh=nearleast_veh
                                local hash=entity.get_entity_model_hash(veh)
                                if streaming.is_model_a_vehicle(hash) then
                                    ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),veh,-1)
                                elseif ped.is_ped_a_player(veh) then
                                    fuck_Player_car(veh)
                                elseif streaming.is_model_a_ped(hash) and ped.is_ped_in_any_vehicle(veh) then
                                    fuck_NPC_car(veh)
                                end
                            end
                        else
                            ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()),nearleast_veh,vehicle.get_free_seat(nearleast_veh))
                        end
                    end
                end
            end
        end
    end)

_U_vehicle_flier=menu.add_feature(
    lang("载具飞行"),
    "slider",
    main_vehicle_menu.id,
    function(a)
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if player.is_player_in_any_vehicle(me) then
                local my_veh=player.get_player_vehicle(me)
                --network.request_control_of_entity(my_veh)
                entity.set_entity_max_speed(my_veh,a.value)
                if controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,35)==1.0 or controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())
                    vehicle.set_vehicle_forward_speed(my_veh,0)
                elseif controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 and controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif  controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()+v3(0,0,45))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,32)==1.0 and controls.get_control_normal(0,35)==1.0 then 
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()-v3(0,0,45))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,35)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()-v3(0,0,135))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,33)==1.0 and controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()+v3(0,0,135))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,33)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())
                    vehicle.set_vehicle_forward_speed(my_veh,a.value*-1)
                elseif controls.get_control_normal(0,34)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()+v3(0,0,90))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,35)==1.0 then
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot()-v3(0,0,90))
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                elseif controls.get_control_normal(0,32)==1.0 then
                    vehicle.set_vehicle_forward_speed(my_veh,a.value)
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())
                else
                    vehicle.set_vehicle_forward_speed(my_veh,0)
                    entity.set_entity_rotation(my_veh,cam.get_gameplay_cam_rot())

                end
                if controls.get_control_normal(0,21)==1.0 or controls.get_control_normal(0,143)==1.0 then
                    entity.set_entity_velocity(my_veh,v3(0,0,a.value))
                elseif controls.get_control_normal(0,132)==1.0 then
                    entity.set_entity_velocity(my_veh,v3(0,0,a.value*-1))
                end

            -- else
            --     set_vehicle_fixed(player.get_player_ped(player.player_id()))
            end
        end
    end
)
--_U_vehicle_flier.hidden=true

_U_vehicle_flier.max,_U_vehicle_flier.min,_U_vehicle_flier.mod=1500,50,50
-------------------车载降落伞-----------------------
--------------------------------------------------

_U_veh_boost=menu.add_feature(
    lang("载具快速充能"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        local state=0
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if ped.is_ped_in_any_vehicle(my_ped) then
                local veh=ped.get_vehicle_ped_is_using(my_ped)
                vehicle.set_vehicle_rocket_boost_refill_time(veh,0)
            end
        end
    end
)

_U_veh_boost_infinity=menu.add_feature(
    lang("载具无限充能加速"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        local state=0
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if ped.is_ped_in_any_vehicle(my_ped) then
                local veh=ped.get_vehicle_ped_is_using(my_ped)
                vehicle.set_vehicle_rocket_boost_percentage(veh,999999.0)
            end
        end
    end
)


_U_veh_auto_boost=menu.add_feature(
    lang("载具自动加速"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        local state=0
        while a.on do
            system.yield(0)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            if ped.is_ped_in_any_vehicle(my_ped) then
                local veh=ped.get_vehicle_ped_is_using(my_ped)
                vehicle.set_vehicle_rocket_boost_active(veh,true)
            end
        end
    end
)



_U_veh_on_water=menu.add_feature(
    lang("载具水上驾驶"),
    "toggle",
    main_vehicle_menu.id,
    function(a)
        while a.on and player.is_player_in_any_vehicle(player.player_id()) do
            system.yield(0)
            local dir=entity.get_entity_rotation(player.get_player_ped(player.player_id()))
            dir:transformRotToDir()
            if not water_obj then
                if request_mod(110106994) then
                    water_obj=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj,false)
                end
            end
            if not water_obj3 then
                if request_mod(110106994) then
                    water_obj3=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj3,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj3,false)
                end
            end
            if not water_obj4 then
                if request_mod(110106994) then
                    water_obj4=object.create_world_object(110106994,player.get_player_coords(player.player_id())+v3(0,0,5.25),false,true)
                    system.yield(0)
                    entity.set_entity_coords_no_offset(water_obj4,v3(0,0,100))
                    system.yield(0)
                    entity.set_entity_visible(water_obj4,false)
                end
            end
            if not water_obj2 then
                if request_mod(3188223741) then
                    water_obj2=ped.create_ped(4,3188223741,player.get_player_coords(player.player_id())+v3(0,0,5.25),0,false,true)
                    system.yield(0)
                    entity.set_entity_god_mode(water_obj2,true)
                    system.yield(0)
                    entity.set_entity_visible(water_obj2,false)
                end
            end
            if water_obj2 then
                entity.set_entity_coords_no_offset(water_obj2,entity.get_entity_coords(player.get_player_vehicle(player.player_id()))-v3(0,0,3))
                system.yield(0)
                entity.set_entity_rotation(water_obj2,entity.get_entity_rotation(player.get_player_vehicle(player.player_id())))
            end
            if water_obj2 and entity.is_entity_in_water(water_obj2) then
                if water_obj then
                    entity.set_entity_coords_no_offset(water_obj,entity.get_entity_coords(player.get_player_vehicle(player.player_id()))-v3(0,0,0.5))
                end
                if water_obj3 then
                    entity.set_entity_coords_no_offset(water_obj3,entity.get_entity_coords(player.get_player_vehicle(player.player_id()))+v3(dir.x*90,dir.y*90,-1))
                end
                if water_obj4 then
                    entity.set_entity_coords_no_offset(water_obj4,entity.get_entity_coords(player.get_player_vehicle(player.player_id()))+v3(dir.x*180,dir.y*180,-1))
                end
            else
                return HANDLER_CONTINUE
            end
            if water_obj2 and entity.get_entity_model_hash(water_obj2)==0 then
                water_obj2=nil
                water_obj=nil
                water_obj3=nil
                water_obj4=nil
            end
        end
    end
)
_U_veh_on_water.threaded=true
_U_auto_fz=menu.add_feature(
    lang('载具自动翻转'),
    'toggle',
    main_vehicle_menu.id,
    function(a)
        while a.on do
            system.yield(0)
            if player.is_player_in_any_vehicle(player.player_id()) then
                if entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).y>=60 or entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).y<=-60 or  entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).x<=-160 or entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).x>=160 then
                    entity.set_entity_rotation(player.get_player_vehicle(player.player_id()),v3(0,0,entity.get_entity_rotation(player.get_player_vehicle(player.player_id())).z))
                end
            end
        end
    end
)

_U_veh_cjb=menu.add_feature(
    lang('载具冲击波'),
    'toggle',
    main_vehicle_menu.id,
    function(a)
        while a.on do
            system.yield(0)
            if player.is_player_in_any_vehicle(player.player_id()) then
                fire.add_explosion(entity.get_entity_coords(player.get_player_vehicle(player.player_id())),83,false,false,0,player.get_player_ped(player.player_id()))
            end
        end
    end
)

--------------自动切枪 Done----------------
_U_main_weapon_switch=menu.add_feature(
    lang("自动切枪"),
    "toggle",
    main_weapon.id,
    function(a)
        if a.on then
            if Pedshoot() then
                if Pedweapon() == 0xA284510B then
                    weapon.remove_weapon_from_ped(Myped(), 0xA284510B)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0xA284510B, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0xA284510B, 2147483647)
                elseif Pedweapon() == 0xB1CA77B1 then
                    weapon.remove_weapon_from_ped(Myped(), 0xB1CA77B1)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0xB1CA77B1, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0xB1CA77B1, 2147483647)
                elseif Pedweapon() == 0x7F7497E5 then
                    weapon.remove_weapon_from_ped(Myped(), 0x7F7497E5)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x7F7497E5, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x7F7497E5, 2147483647)
                elseif Pedweapon() == 0x6D544C99 then
                    weapon.remove_weapon_from_ped(Myped(), 0x6D544C99)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x6D544C99, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x6D544C99, 2147483647)
                elseif Pedweapon() == 0x63AB0442 then
                    weapon.remove_weapon_from_ped(Myped(), 0x63AB0442)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x63AB0442, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x63AB0442, 2147483647)
                elseif Pedweapon() == 0x0781FE4A then
                    weapon.remove_weapon_from_ped(Myped(), 0x0781FE4A)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x0781FE4A, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x0781FE4A, 2147483647)
                elseif Pedweapon() == 0x05FC3C11 then
                    weapon.remove_weapon_from_ped(Myped(), 0x05FC3C11)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x05FC3C11, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x05FC3C11, 2147483647)
                elseif Pedweapon() == 0x0C472FE2 then
                    weapon.remove_weapon_from_ped(Myped(), 0x0C472FE2)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x0C472FE2, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x0C472FE2, 2147483647)
                elseif Pedweapon() == 0xA914799 then
                    weapon.remove_weapon_from_ped(Myped(), 0xA914799)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0xA914799, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0xA914799, 2147483647)
                elseif Pedweapon() == 0xC734385A then
                    weapon.remove_weapon_from_ped(Myped(), 0xC734385A)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0xC734385A, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0xC734385A, 2147483647)
                elseif Pedweapon() == 0x6A6C02E0 then
                    weapon.remove_weapon_from_ped(Myped(), 0x6A6C02E0)
                    weapon.give_delayed_weapon_to_ped(Myped(), 0x6A6C02E0, 0, 1)
                    weapon.set_ped_ammo(Myped(), 0x6A6C02E0, 2147483647)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end
)
-- _U_veh_guns_veh={
--     {'Universe',2067820283}--名字+hash
-- }
-- _U_vehicle_gun=menu.add_feature(
--     "载具枪设置",
--     "parent",
--     main_weapon.id
-- )
-- _U_vehicle_gun_is_on=menu.add_feature(
--     "开/关",
--     'toggle',
--     _U_vehicle_gun.id,
--     function()
--     end
-- )
-- _U_spawned_vehs={}

-- menu.add_feature(
--     "删除载具库",
--     'action',
--     _U_vehicle_gun.id,
--     function()
--         if _U_spawned_vehs[1] then
--             for i=1,#_U_spawned_vehs do
--                 entity.delete_entity(_U_spawned_vehs[i])
--             end
--             _U_spawned_vehs={}
--         end
--     end
-- )

-- menu.add_feature(
--     "无效点我",
--     'action',
--     _U_vehicle_gun.id,
--     function()
--         if vehicle.get_all_vehicles() then
--             for i=1,#vehicle.get_all_vehicles() do
--                 entity.delete_entity(vehicle.get_all_vehicles()[i])
--             end
--         end
--     end
-- )


-- for i=1,#_U_veh_guns_veh do
--     menu.add_feature(
--         _U_veh_guns_veh[i][1],
--         'toggle',
--         _U_vehicle_gun.id,
--         function(a)
--             while a.on do
--                 system.yield(0)
--                 if _U_vehicle_gun_is_on.on then
--                     if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
--                         local dir=cam.get_gameplay_cam_rot()
--                         dir:transformRotToDir()
--                         dir=v3(dir.x*10,dir.y*10,dir.z*10)
--                         if request_mod(_U_veh_guns_veh[i][2]) then
--                             local veh=vehicle.create_vehicle(_U_veh_guns_veh[i][2],player.get_player_coords(player.player_id())+dir,0,true,true)
--                             _U_spawned_vehs[#_U_spawned_vehs+1]=veh
--                             entity.set_entity_coords_no_offset(veh,player.get_player_coords(player.player_id())+dir)
--                             entity.set_entity_rotation(veh,cam.get_gameplay_cam_rot())
--                             vehicle.set_vehicle_forward_speed(veh,99999999)
--                             if #_U_spawned_vehs>=60 then
--                                 for i=1,#_U_spawned_vehs do
--                                     entity.delete_entity(_U_spawned_vehs[i])
--                                 end
--                                 _U_spawned_vehs={}
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--     )
-- end


_U_guide_missile=menu.add_feature(
    lang('午时已到(范围)'),
    'value_i',
    main_weapon.id,
    function(a)
        while a.on do
            system.yield(0)
            if ped.is_ped_shooting(player.get_player_ped(player.player_id())) then
                for pid=0,31 do
                    if pid~=player.player_id() and not player.is_player_friend(pid) then
                        if distanceTo(pid)<a.value then
                            local hash_weapon = ped.get_current_ped_weapon(player.get_player_ped(player.player_id()))
                            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(player.player_id()), player.get_player_coords(pid), 2147483647, hash_weapon, player.get_player_ped(player.player_id()), true, false, 1000)
                        end
                    end
                end
            end
        end
    end
)
_U_guide_missile.min,_U_guide_missile.max,_U_guide_missile.mod=100,10000,25


-------------自动跳过过场动画 Done--------------
_U_main_auto_skip=menu.add_feature(
    lang("自动跳过过场动画"),
    "toggle",
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            if cutscene.is_cutscene_active() or cutscene.is_cutscene_playing() then
                cutscene.stop_cutscene_immediately()
                cutscene.remove_cutscene()
            else
                return HANDLER_CONTINUE
            end
        end
    end
)
_U_main_tp_auto=menu.add_feature(
    lang('自动传送到标记点'),
    'toggle',
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            local pos2=ui.get_waypoint_coord()
            tp_ped=player.get_player_ped(player.player_id())
            if player.is_player_in_any_vehicle(player.player_id()) then
                tp_ped=player.get_player_vehicle(player.player_id())
                network.request_control_of_entity(tp_ped)
            end
            if math.abs(ui.get_waypoint_coord().x) < 16000 and math.abs(ui.get_waypoint_coord().x) > 10 and math.abs(ui.get_waypoint_coord().y) > 10 then
                local is_success,z=gameplay.get_ground_z(v3(pos2.x,pos2.y,1000))
                for i=0,5 do
                    local is_success,z=gameplay.get_ground_z(v3(pos2.x,pos2.y,z))
                end
                entity.set_entity_coords_no_offset(tp_ped,v3(pos2.x,pos2.y,z))
            end
        end
    end
)

local go_forward=menu.add_feature(
    lang('向前前进一段距离'),
    "action",
    mission_cheat.id,
    function()
        local me=player.player_id()
        local my_ped=player.get_player_ped(me)
        local pos=player.get_player_coords(me)
        local dir = entity.get_entity_rotation(player.get_player_ped(player.player_id()))
        dir:transformRotToDir()
        -- dir = dir +1.5
        -- dir=dit*2
        dir=v3(dir.x*3,dir.y*3,dir.z*3)
        pos=pos + dir
        if player.is_player_in_any_vehicle(player.player_id()) then
            network.request_control_of_entity(player.get_player_vehicle(player.player_id()))
            entity.set_entity_coords_no_offset(player.get_player_vehicle(player.player_id()),pos)
        else
            entity.set_entity_coords_no_offset(my_ped,pos)
        end
        
    end
)

_U_clear_notice=menu.add_feature(lang("清理通知"), "toggle", mission_cheat.id, function(a)
    while a.on do
        ui.get_current_notification(ui.remove_notification(0))
    if not a.on then return end
    system.wait(1)
    end
    end)




----------------------Anti - NPC---------------------
_U_Anti_Npc=menu.add_feature(
    lang("杀死").."NPC",
    "toggle",
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            all_peds=ped.get_all_peds()
            for i=1,#all_peds do
                if not ped.is_ped_a_player(all_peds[i]) then
                    ped.set_ped_health(all_peds[i],0)
                end
            end
        end
    end
)

-----------------恶心NPC?--------------------
_U_Anti_Npc_Aim_Shoot=menu.add_feature(
    lang("恶心").."NPC",
    "toggle",
    mission_cheat.id,
    function(a)
        local c={}
        while a.on do
            system.yield(0)
            all_peds=ped.get_all_peds()
            if all_peds then
                for i=1,#all_peds do
                    system.yield(0)
                    if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) then
                        ped.set_ped_can_switch_weapons(all_peds[i],false)
                        weapon.remove_all_ped_weapons(all_peds[i])
                        entity.freeze_entity(all_peds[i],true)
                    end
                end
            end
        end
    end
)

_U_Anti_Npc_Aim_Shoot.threaded=true

_U_fly_npc=menu.add_feature(
    lang('芜湖起飞'),
    'toggle',
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            local all_peds=ped.get_all_peds()
            if all_peds then
                for i=1,#all_peds do
                    if not ped.is_ped_a_player(all_peds[i]) then
                        if ped.is_ped_in_any_vehicle(all_peds[i]) then
                            entity.set_entity_velocity(ped.get_vehicle_ped_is_using(all_peds[i]),v3(0,0,50))
                        else
                            entity.set_entity_velocity(all_peds[i],v3(0,0,50))
                        end
                    end
                end
            end
        end
    end
)
_U_fly_npc.threaded=true

_U_make_NPC_Fire=menu.add_feature(
    "点燃NPC",
    "toggle",
    mission_cheat.id,
    function(a)
        local c={}
        while a.on do
            system.yield(0)
            all_peds=ped.get_all_peds()
            if all_peds then
                for i=1,#all_peds do
                    if not ped.is_ped_a_player(all_peds[i]) and entity.is_entity_a_ped(all_peds[i]) and not entity.is_entity_dead(all_peds[i]) and a.on then
                        fire.start_entity_fire(all_peds[i])
                    end
                    system.yield(10)
                end
            end
        end
    end
)
_U_make_NPC_Fire.hidden=true
_U_make_NPC_Fire.threaded=true
_U_main_title.on=true


_U_cai_dan_alien=menu.add_feature("外星蛋运货(彩蛋)", "toggle", mission_cheat.id, function(a)
    menu.notify("2T玩家交流群：872986398\n买科技加群775255063", "解锁大师", 3, 0x6414F0FF)
    while a.on do
        if a.on then
            system.yield(0)
            local ALN_EG_MS = {
                {"LFETIME_BIKER_BUY_COMPLET5", 600},
                {"LFETIME_BIKER_BUY_UNDERTA5", 600}
            }
            local hash0 = stats.stat_get_int(gameplay.get_hash_key("MP0_LFETIME_BIKER_BUY_COMPLET5"),0,true)
            local hash1 = stats.stat_get_int(gameplay.get_hash_key("MP1_LFETIME_BIKER_BUY_COMPLET5"),0,true)
            local hash2 = stats.stat_get_int(gameplay.get_hash_key("MP0_LFETIME_BIKER_BUY_UNDERTA5"),0,true)
            local hash3 = stats.stat_get_int(gameplay.get_hash_key("MP1_LFETIME_BIKER_BUY_UNDERTA5"),0,true)
            if hash0<600 or hash1<600 or hash2<600 or hash3<600 then
                stats.stat_set_int(gameplay.get_hash_key("MP0_LFETIME_BIKER_BUY_UNDERTA5"), 600,true)
                stats.stat_set_int(gameplay.get_hash_key("MP1_LFETIME_BIKER_BUY_UNDERTA5"), 600,true)
                stats.stat_set_int(gameplay.get_hash_key("MP0_LFETIME_BIKER_BUY_COMPLET5"), 600,true)
                stats.stat_set_int(gameplay.get_hash_key("MP1_LFETIME_BIKER_BUY_COMPLET5"), 600,true)
            end
            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
            ui.set_text_color(255, 0, 0, 255)				
            ui.set_text_scale(0.5)
            ui.set_text_font(0)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text('你正处于彩蛋运货模式，做任务/出售货物请关闭此功能\n否则会有致命bug',v2(0.5,0.85))
            --script.set_global_i(2544210+5191+342,20)
            scrpit_hook_id2=hook.register_script_event_hook(function(pid,me,script)
                --print(pid,me,scrpit)
                if pid==me then
                    local script_id=script[1]
                    table.remove(script,1)
                    --script.trigger_script_event(script_id,pid,script)
                    print(script_id,pid,script)
                    menu.notify("收到来自"..player.get_player_name(pid).."的脚本事件","Universe",5)
                end
            end)
        else
            hook.remove_script_event_hook(scrpit_hook_id2)
        end
    end
end)
_U_cai_dan_alien.hidden=true
_U_reset_ceamre=menu.add_feature(
    lang('修复侦查照片无法发送的情况'),
    'action',
    mission_cheat.id,
    function()
        stats.stat_set_int(gameplay.get_hash_key("MP1_H3OPT_ACCESSPOINTS"), 0,true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_H3OPT_POI"), 0,true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_H3OPT_ACCESSPOINTS"), 0,true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_H3OPT_POI"), 0,true)
        menu.notify(lang('完成，重新做拍照任务即可'),'Universe',3)
    end
)



main____ylbs={}
ylbs___pids={}
_U_spawn_ylb=menu.add_feature(
    "强保",
    'toggle',
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) then-- and pid~=player.player_id()
                    if player.get_player_max_health(pid)>player.get_player_health(pid) then
                        for i=1,#ylbs___pids do
                            if pid==ylbs___pids[i] then
                                return HANDLER_CONTINUE
                            end
                        end
                        local obj=object.create_world_object(410882957,player.get_player_coords(pid),true,true)
                        entity.attach_entity_to_entity(obj,player.get_player_ped(pid),0,v3(0,0,0),v3(0,0,0),true,true,true,0,true)
                        main____ylbs[#main____ylbs+1]=obj
                        system.yield(1)
                        entity.set_entity_visible(obj,false)
                        local obj=object.create_world_object(410882957,player.get_player_coords(pid),true,true)
                        entity.attach_entity_to_entity(obj,player.get_player_ped(pid),0,v3(0,0,-0.5),v3(0,0,0),true,true,true,0,true)
                        main____ylbs[#main____ylbs+1]=obj
                        system.yield(1)
                        entity.set_entity_visible(obj,false)
                        local obj=object.create_world_object(410882957,player.get_player_coords(pid),true,true)
                        entity.attach_entity_to_entity(obj,player.get_player_ped(pid),0,v3(0,0,0.5),v3(0,0,0),true,true,true,0,true)
                        main____ylbs[#main____ylbs+1]=obj
                        system.yield(1)
                        entity.set_entity_visible(obj,false)
                        ylbs___pids[#ylbs___pids+1]=pid
                        if #main____ylbs>15 then
                            for i=1,#main____ylbs do
                                entity.delete_entity(main____ylbs[i])
                            end
                            main____ylbs={}
                        end
                        system.yield(100)
                    end
                end
            end
        end
    end
)
_U_spawn_ylb.threaded=true
_U_spawn_ylb.hidden=true




_U_Tp_all_to_me=menu.add_feature(
    lang('传送队友给我'),
    'toggle',
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and pid~=player.player_id() then
                    if player.is_player_in_any_vehicle(pid) then
                        while a.on and distanceTo(pid) >100 do
                            system.yield(0)
                            local dir = cam.get_gameplay_cam_rot()
                            dir:transformRotToDir()
                            dir=v3(dir.x*5,dir.y*5,dir.z*5)
                            local veh=player.get_player_vehicle(pid)
                            network.request_control_of_entity(veh)
                            system.yield(10)
                            entity.set_entity_coords_no_offset(veh,player.get_player_coords(player.player_id())+dir)
                        end
                        --system.yield(1000)
                    end
                end
            end
        end 
    end
)
-- _U_Tp_all_to_me.hidden=true
local clear_dead=menu.add_feature(
    lang("清除被杀记录").."[!]",
    "toggle",
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            stats.stat_set_int(gameplay.get_hash_key('MP0_ARCHENEMY_KILLS'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_ARCHENEMY_KILLS'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DEATHS'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DEATHS'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DIED_IN_EXPLOSION'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DIED_IN_EXPLOSION'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DIED_IN_FALL'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DIED_IN_FALL'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DIED_IN_FIRE'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DIED_IN_FIRE'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DIED_IN_ROAD'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DIED_IN_ROAD'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP0_DIED_IN_DROWNING'),0,true)
            stats.stat_set_int(gameplay.get_hash_key('MP1_DIED_IN_DROWNING'),0,true)
        end
    end
)
local cooldown_clear=menu.add_feature(
    lang("移除赌场筹码冷却").."[!]",
    "toggle",
    mission_cheat.id,
    function(a)
        while a.on do
            system.yield(0)
            if stats.stat_get_int(gameplay.get_hash_key('MPPLY_CASINO_CHIPS_PUR_GD'),0)~=0 then
                menu.notify(lang('已重置购买记录'),'Universe',3,2)
                stats.stat_set_int(gameplay.get_hash_key('MPPLY_CASINO_CHIPS_PUR_GD'),0,true)
            end
        end
    end
)



local clear_cash=menu.add_feature(
    lang("移除收支差").."[!]",
    "action",
    mission_cheat.id,
    function()
        local a=stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_WEAPON_ARMOR'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_WEAPON_ARMOR'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_VEH_MAINTENANCE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_VEH_MAINTENANCE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_STYLE_ENT'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_STYLE_ENT'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_PROPERTY_UTIL'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_PROPERTY_UTIL'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_JOB_ACTIVITY'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_JOB_ACTIVITY'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_CONTACT_SERVICE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_CONTACT_SERVICE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_HEALTHCARE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_HEALTHCARE'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_DROPPED_STOLEN'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_DROPPED_STOLEN'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_SHARED'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_SHARED'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_SPENT_JOBSHARED'),0)
        a=a+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_SPENT_JOBSHARED'),0)
        local b=stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBS'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_JOBS'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_SELLING_VEH'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_SELLING_VEH'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_BETTING'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_BETTING'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_GOOD_SPORT'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_GOOD_SPORT'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_PICKED_UP'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_PICKED_UP'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_SHARED'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_SHARED'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBSHARED'),0)
        b=b+stats.stat_get_int(gameplay.get_hash_key('MP1_MONEY_EARN_JOBSHARED'),0)
        if a>b then
            local m=a-b
            menu.notify(lang('你的收支差为：')..m..'$\n'..lang('已为您清除收支差'),'Universe',6,1)
            stats.stat_set_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBSHARED'),stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBSHARED'),0)+m,true)
            --stats.stat_set_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBSHARED'),stats.stat_get_int(gameplay.get_hash_key('MP0_MONEY_EARN_JOBSHARED'),0)+m,true)
        else
            menu.notify(lang('很好!!!!你没有收支差！'),'Universe',6,1)
        end
    end
)

local stat_Accuracy=menu.add_feature(
    lang("命中率").."[!]",
    "autoaction_value_f",
    mission_cheat.id,
    function(a)
        stats.stat_set_float(gameplay.get_hash_key('MP0_WEAPON_ACCURACY'),a.value,true)
    end
)
stat_Accuracy.min,stat_Accuracy.max,stat_Accuracy.mod=0,100000,0.1
stat_Accuracy.value=stats.stat_get_float(gameplay.get_hash_key('MP0_WEAPON_ACCURACY'),0)

local stat_kills=menu.add_feature(
    lang("杀死的玩家").."[!]",
    "autoaction_value_i",
    mission_cheat.id,
    function(a)
        stats.stat_set_int(gameplay.get_hash_key('MPPLY_KILLS_PLAYERS'),a.value,true)
    end
)
stat_kills.min,stat_kills.max,stat_kills.mod=0,2147483647,5
stat_kills.value=stats.stat_get_int(gameplay.get_hash_key('MPPLY_KILLS_PLAYERS'),0)

local Unlock_ws=menu.add_feature(
    '解锁外星人',
    'action',
    mission_cheat.id,
    function()
        stats.stat_set_int(gameplay.get_hash_key('MP0_TATTOO_FM_CURRENT_32'),32768,true)
        stats.stat_set_int(gameplay.get_hash_key('MP0_TATTOO_FM_CURRENT_32'),67108864,true)
        stats.stat_set_int(gameplay.get_hash_key('MP1_TATTOO_FM_CURRENT_32'),32768,true)
        stats.stat_set_int(gameplay.get_hash_key('MP1_TATTOO_FM_CURRENT_32'),67108864,true)
    end
)
Unlock_ws.hidden=true
local Unlock_xmas=menu.add_feature(
    '解锁节日限定皮肤',
    'action',
    mission_cheat.id,
    function()
        for i=0,20 do
            stats.stat_set_int(gameplay.get_hash_key('MPPLY_XMASLIVERIES'..i),-1,true)
        end
    end)
Unlock_xmas.hidden=true
local no_1=menu.add_feature(
    lang("全球声望排名第一"),
    "action",
    mission_cheat.id,
    function()
        menu.notify(lang('修改完成'),'Universe',3,1)
        stats.stat_set_int(gameplay.get_hash_key('MPPLY_GLOBALXP'),1,true)
    end
)






no_1.hidden=true
clear_cash.hidden=true
clear_dead.hidden=true
cooldown_clear.hidden=true
stat_kills.hidden=true
stat_Accuracy.hidden=true
_notice=menu.add_feature(
    lang("开启隐藏功能"),
    "action",
    mission_cheat.id,
    function()
        if not menu.is_trusted_mode_enabled() then
            menu.notify(lang('打开信任模式以启用隐藏功能'),'Universe',3,3)
        else
            menu.notify(lang('已启用隐藏功能'),'Universe',3,3)
            no_1.hidden=false
            clear_cash.hidden=false
            clear_dead.hidden=false
            cooldown_clear.hidden=false
            stat_kills.hidden=false
            stat_Accuracy.hidden=false
            _notice.hidden=true
        end
    end
    )


if menu.is_trusted_mode_enabled() then
    no_1.hidden=false
    clear_cash.hidden=false
    clear_dead.hidden=false
    cooldown_clear.hidden=false
    stat_kills.hidden=false
    stat_Accuracy.hidden=false
    _notice.hidden=true
end
_U_login_start=menu.add_feature(
    lang("启动欢迎"),
    "toggle",
    main_options.id,
    function(a)
        if a.on then
            _U_main_title.on=false
            main.name='BX Loading...'
            on_start.on=true
        end
    end
)


main_about.on=true






---------------------------个人选择--------------------------

local choice_menu=menu.add_player_feature("Universe","parent",0)

_U_one_kick_c=menu.add_player_feature(
    lang("暴力踢出"),
    "action",
    choice_menu.id,
    function(a,pid)
        if pid~=me and not player.is_player_friend(pid) and player.is_player_valid(pid) then
            network.network_session_kick_player(pid)
            network.force_remove_player(pid)
            send_script_event("Netbail kick", pid, {pid, generic_player_global(pid)})
            for x=1,14 do
                send_script_event("Kick "..tostring(x), pid, {pid, generic_player_global(pid)})
            end
        end
    end
)
_U_fuck_him_c=menu.add_player_feature(
    lang("摇晃玩家"),
    "toggle",
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            fire.add_explosion(player.get_player_coords(pid)-v3(0,0,30),1,false,true,99999999,player.get_player_ped(pid))
        end
    end
)

_U_ima_badman_c=menu.add_player_feature(
    lang("栽赃嫁祸"),
    "toggle",
    choice_menu.id,
    function(a,killer)
       while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid)  and player.player_id() ~= pid and pid~=killer then
                    fire.add_explosion(player.get_player_coords(pid),28,true,false,99999999,player.get_player_ped(killer))
                end
            end
       end
    end
)
_U_ima_badman_invis_c=menu.add_player_feature(
    lang("栽赃嫁祸(无声)"),
    "toggle",
    choice_menu.id,
    function(a,killer)
       while a.on do
            system.yield(0)
            for pid=0,31 do
                if player.is_player_valid(pid) and not player.is_player_friend(pid) and player.player_id() ~= pid and pid~=killer then
                    fire.add_explosion(player.get_player_coords(pid),28,false,true,0,player.get_player_ped(killer))
                end
            end
       end
    end
)
_U_killing_roll_c=menu.add_player_feature(
    lang("杀戮光环"),
    "toggle",
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            local target_player_coords=player.get_player_coords(pid)
            local me=player.player_id()
            local my_ped=player.get_player_ped(me)
            entity.set_entity_coords_no_offset(my_ped,target_player_coords+v3(math.random(-4,4),math.random(-4,4),2))
            system.yield(0)
            entity.set_entity_rotation(my_ped,v3(0,0,target_player_coords.z-180))
            local hash_weapon = is_pz(ped.get_current_ped_weapon(my_ped))
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(player.player_id()), target_player_coords, 500, hash_weapon, my_ped, true, false, 1000)
        end
    end
)
_U_spoof_kill_c=menu.add_player_feature(
    lang("车辆撞向"),
    'toggle',
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            local rot=entity.get_entity_rotation(player.get_player_ped(pid))
            rot:transformRotToDir()
            rot=v3(rot.x*3,rot.y*3,rot.z*3)
            if request_mod(1663218586) then
                spoof_veh_kill_c=vehicle.create_vehicle(1663218586,player.get_player_coords(pid)-rot,0,true,false)
                entity.set_entity_rotation(spoof_veh_kill_c,entity.get_entity_rotation(player.get_player_ped(pid)))
                vehicle.set_vehicle_forward_speed(spoof_veh_kill_c,99999999)
                system.yield(400)
                fire.add_explosion(entity.get_entity_coords(spoof_veh_kill_c),8,true,true,0,player.get_player_ped(pid))
                system.yield(600)
                entity.delete_entity(spoof_veh_kill_c)
            end
        end
    end
)


_U_spoof_c=menu.add_player_feature(
    lang("车辆恶心他"),
    'toggle',
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            local rot=entity.get_entity_rotation(player.get_player_ped(pid))
            rot:transformRotToDir()
            rot=v3(rot.x*3,rot.y*3,rot.z*3)
            if request_mod(3052358707) then
                spoof_veh_c=vehicle.create_vehicle(3052358707,player.get_player_coords(pid)+rot,0,true,false)
                entity.set_entity_rotation(spoof_veh_c,entity.get_entity_rotation(player.get_player_ped(pid)))
                vehicle.set_vehicle_engine_on(spoof_veh_c,true,true,true)
                vehicle.set_vehicle_rocket_boost_active(spoof_veh_c,true)
                system.yield(100)
                entity.delete_entity(spoof_veh_c)
            end
        end
    end
)
_U_fire_him_c=menu.add_player_feature(
    lang("打成筛子"),
    'toggle',
    choice_menu.id,
    function(a,pid)
        local all_weapons=weapon.get_all_weapon_hashes()
        _U_shaizi_x_c=1
        while a.on do
            system.yield(0)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 40,all_weapons[_U_shaizi_x_c], player.get_player_ped(player.player_id()), true, false, 10000)
            if _U_shaizi_x_c>#all_weapons then
                _U_shaizi_x_c=1
            end
        end
    end
)


_U_fire_him2_c=menu.add_player_feature(
    lang("天降正义"),
    'toggle',
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2982836145, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2726580491, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,1672152130, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,1834241177, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2138347493, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,615608432, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,4256991824, player.get_player_ped(player.player_id()), true, false, 10000)
            gameplay.shoot_single_bullet_between_coords(player.get_player_coords(pid)+v3(math.random(-10,10),math.random(-10,10),10), player.get_player_coords(pid)+v3(0,0,0.5), 1,2481070269, player.get_player_ped(player.player_id()), true, false, 10000)
        end
    end
)


_U_send_to_island_c=menu.add_player_feature(
    lang('送上岛'),
    'toggle',
    choice_menu.id,
    function(a,pid)
        while a.on do
            system.yield(0)
            send_script_event("Apartment invite", pid, {pid, generic_player_global(pid)})
        end
    end
)

_U_rude_him_c=menu.add_player_feature(
    lang('嘴臭他'),
    'toggle',
    choice_menu.id,
    function(a,pid)
        while a.on do
            network.send_chat_message(player.get_player_name(pid)..'\n'.._U_rude[math.random(1,#_U_rude)],false)
            system.yield(1000)
        end
    end
)

_U_crash_c=menu.add_player_feature(
    lang('崩溃'),
    'action',
    choice_menu.id,
    function()
        menu.notify(lang('这里不会有崩溃 永远不会')..':)','Universe',3)
    end
)
_U_show_notice_settings=menu.add_feature(lang('通知信息设置'),'parent',main_options.id)

_U_show_notice_x=menu.add_feature('X','action_value_i',_U_show_notice_settings.id)
_U_show_notice_y=menu.add_feature('Y','action_value_i',_U_show_notice_settings.id)
_U_show_notice_r=menu.add_feature('R','action_value_i',_U_show_notice_settings.id)
_U_show_notice_g=menu.add_feature('G','action_value_i',_U_show_notice_settings.id)
_U_show_notice_b=menu.add_feature('B','action_value_i',_U_show_notice_settings.id)
_U_show_notice_max=menu.add_feature(lang('最大数'),'action_value_i',_U_show_notice_settings.id)
_U_show_notice_x.max,_U_show_notice_x.min,_U_show_notice_x.mod=100,0,1
_U_show_notice_y.max,_U_show_notice_y.min,_U_show_notice_y.mod=100,0,1
_U_show_notice_r.max,_U_show_notice_r.min,_U_show_notice_r.mod=255,0,1
_U_show_notice_g.max,_U_show_notice_g.min,_U_show_notice_g.mod=255,0,1
_U_show_notice_b.max,_U_show_notice_b.min,_U_show_notice_b.mod=255,0,1
_U_show_notice_max.max,_U_show_notice_max.min,_U_show_notice_max.mod=50,0,1




_U_show_notice=menu.add_feature(
    lang('显示通知信息'),
    'toggle',
    main_options.id,
    function(a)
        if a.on then
            if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\notification.log") then
                while a.on do
                    system.yield(0)
                    _U_noticed_x=0
                    _U_notice_msgs={}
                    notice_file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\notification.log",'r')
                    for i in notice_file:lines() do
                        _U_notice_msgs[#_U_notice_msgs+1]=i
                    end
                    for i=#_U_notice_msgs,1,-1 do
                        if #_U_notice_msgs<=_U_show_notice_max.value or #_U_notice_msgs-i<=_U_show_notice_max.value then
                            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
                            ui.set_text_color(_U_show_notice_r.value, _U_show_notice_g.value, _U_show_notice_b.value,255)	
                            ui.set_text_scale(0.3)
                            ui.set_text_font(1)
                            ui.set_text_centre(false)
                            ui.set_text_outline(true)
                            ui.draw_text(_U_notice_msgs[i],v2(_U_show_notice_x.value*0.01,_U_show_notice_y.value*0.01+0.02*_U_noticed_x))
                            _U_noticed_x=_U_noticed_x+1
                        end
                    end
                    notice_file:close()
                    notice_file=nil
                end
            else
                notice_file=nil
                menu.notify(lang('请打开2T本体的记录功能'))
                a.on=false
            end
        else
            if notice_file then
                notice_file:close()
                notice_file=nil
            end
        end
    end
)


_U_delete_log=menu.add_feature(
    lang('删除')..'log',
    'action',
    main_options.id,
    function()
        local aa=_U_show_notice.on
        if aa then
            _U_show_notice.on=false
        end
        io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\notification.log",'w')
        if aa then
            _U_show_notice.on=true
        end
    end
)



_U_lisen=menu.add_feature(
    '监听系统',
    'toggle',
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            if not _U_show_notice.on and notice_file then
                notice_file:close()
                notice_file=nil
            end
        end
    end
)
_U_lisen.hidden=true
_U_lisen.threaded=true
_U_lisen.on=true
_u_set_cloud_hat_opacity=menu.add_feature(
    lang('设置加载界面广告透明度'),
    'action_value_i',
    main_options.id
)
_u_set_cloud_hat_opacity.max,_u_set_cloud_hat_opacity.min,_u_set_cloud_hat_opacity.mod=100,0,1

_U_Lang=menu.add_feature(
    'Language',
    'action_value_str',
    main_options.id,
    function(a)
        file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Lang.cfg",'w')
        if a.value==0 then
            file:write('Chinese')
        elseif a.value==1 then
            file:write('English')
        elseif a.value==2 then
            file:write('TH')
        else
            file:write(a.str_data[a.value+1])
        end
        file:close()
        menu.notify(lang('重新加载以加载语言'),'Universe',3)
    end
)
_U_Lang:set_str_data(
    {
        '中文',
        'English',
        '繁体中文'
    }
)
t=utils.get_all_files_in_directory(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\langs\\",'lua')
for i=1,#t do
    if t[i]~='Universe_Eng.lua' and t[i]~='Universe_TH.lua' then
        ls= _U_Lang:get_str_data()
        ls[#ls+1]=string.gsub(t[i],'.lua','')
        _U_Lang:set_str_data(
            ls
        )
    end
end

_u_set_cloud_hat_opacity_on=menu.add_feature(
    'setting!!!!!!!',
    'toggle',
    main_options.id,
    function(a)
        while a.on do
            system.yield(0)
            gameplay.set_cloud_hat_opacity(_u_set_cloud_hat_opacity.value*0.01)
        end
    end
)
_u_set_cloud_hat_opacity_on.on=true
_u_set_cloud_hat_opacity_on.hidden=true

-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置

--查询方法
local function wt_func_state(__func)
    if tostring(__func.on) =='true' then
        return 'e8e1827821016773f07ea486fb58e9bf33622fddc86fb9c1423c50b85b66403'
    else
        return '824b1daaa8ccf53455885a5be346c2ef4616eb62bcb92320b28ca7081b4015c'
    end
end
local _funcs_name={
    '052b8d517e03ffd212dfebbe896d149a',
    'd1c29773c0795389ee1e8bd8be145153',
    'd1d2bc8875f01915490bc9109e4daaa4',
    'b803c11dfec0c358b83837567d541d3c',
    '5fd68ff04c23f4aab5915b034fbda3ff',
    '1dee4f0ed2f746006a704e97026ade9a',
    '1c6ebda3f38dee5ad0ba64427dfa701d',
    '787e575e18e818d0f0b4f54080c18b5e',
    '2160fc2c32540ec01cde47b3dd75634a',
    '7590425d36c0945487621d28fe1c36dd',
    'ad4899bdcc45ea202882d21ff3310398',
    '829f7453231d993d0ceac3aca870e90a',
    '8b50e1dceef39ba16dea204509b330ed',
    'e48930738f369281006f2252e154200a',
    '96cece01a9f5b0d4048de1090f3e83a9',
    '9c05afdc3fbe3451fad6257c1519b48a',
    'c6ad2c60163e2b04f5b73d551059e79c',
    '913d79f2ac79df92122dfb6c4dbef89c',
    '497af3915361ecb9a4b92b7b39a8bd96',
    'd409c6e83799dd679e014870a5f9d979',
    '41104163467356c96cffd7838e26d8b8',
    '1b7228e2b5063d915e98e679eb48a7f2',
    'd038709948692ddb755dabff8293e88b',
    '6c8fad6c9e640f504394c35db82dc232',
    'cf577583095251eeac9dc79b0e2dc338',
    '935c26c0b1d0b55bac45b2cadab79f10',
    'b4aff15bd569e90c4885418e693bb546',
    'f9cf7d76452f3c1249e120db08ab712f',
    '868633a8e6b3d1bedcbfd2026e554980',
    'c79e8b27fd7db06e29955f4ac9fc80bf',
    '257e5d828a158579bc2a09b2e049e91c',
    '9d653affc45e76b695d3fba21336fcd0',
    'ab84b5b4040c1859e2c1891883553f23',
    '102bb5c962ab7e25f2b69d2d554351f8',
    'f3b53c0c51f9be2b8bfb5d137553154f',
    'cd2585a1ee675514f1ae2479c4aac675',
    '5f77e5b99a97919221026d5a5d88f522',
    'e4f03f95e7db8d7d0f821dbc0c05efcd',
    'b74b0baa67f18055d0342695545db3ff',
    'fcf76fc371f9468d15d02f09d31bba48',
    'ac344b8aceaf1d15544102a828b67f16',
    '3d2e046ad51a4996bb370f36d7584a84',
    '99b883cd54cd942f05739ddb62a7c37f',
    '09781e4ef671e957fc0c2e031382fdd3',
    '5a62035c9b1e57337a96b10affeeffc7',
    'b91dbd364954d64ed708af89da52d71d',
    'ab63d65c5b312a58e5321ff9cc9cf701',
    '1251b82433a3857e52e193d0dc0654ed',
    '37fcbe00ead3c7770578c98a25477c0b',
    '361465fd4a763adc093575b0b00890e1',
    '1ac470ccdc70416da45eeeffaba34fab',
    '4ab71261b068d0103fa4210f44945679',
    'b761d64fb324bcc4369d3fd2380e4775',
    '053f194037e3b522a4515fe9855b3d53',
    'c6cdc13167b4e93d027bbfdade119d39',
    '9ca2b41ef9c66457af90ba97ac8a5709',
    '5b98c882e67c1fc0c267b6e5d1afdf32',
    '50773318ef3e2b399a5b823b1a463292',
    '9073a8c971af3b925b0b930eb33e25a5',
    '4db125b4f576b6b6ff391e2af177e7aa',
    '0d39cf1f80914a354e1ece0a7d7e80aa',
    '4f68cf7bb8a88ff422de6ce70f952a5e',
    '3f1a99c00ffbd55846c68cefbfd4f39c',
    'b2e3cbd0d9eb2e37f07262e1bdbd2383',
    'c4c43b01740513fd258b65b189eba89b',
    'edaf2646e7cb5a0026217a6816262a58',
    '223c1fd90d3d29786f26cf974ab5fe96',
    'e4909d235a890fa726f6c9f8e89d7337',
    'ddba4978def0fdeba60993a14b64b4bb',
    'f006d0d83a0d2ae65ba4d3bd755ca0c5',
    '0346c2b3b715049760cad3c23c6341fd',
    'b8b54431bb60b41fb933d3a2b3582fc2',
    '16f6c13c4b7c81693782a4a9db20caa0',
    '49f7365b0eb035a3d0e81cf1c4f0b07d',
    '35f00b571dd9c4558aab49151cbd9efe',
    'ff30bc572ec33d29b7775f4ecdd2a035',
    '5c133f13baa39d9de610708f8ab87f92',
    'af780e53ec5fa9785420f6b05d594fd0',
    '3d65c53fc19e81886c78c32aea07b822',
    '758776730fa74aed04cddc0a253a7436',
    '65243b5e8a2187515171d43e4a89d374',
    '9ba03bb7d68605c49fca775c5c699703',
    '3f0cd67350b0c16ecce0a077d2b1ff4d',
    '40a74ecd6bf50e9c067314afcac12113',
    '6272ecd7ef16f96fd10c441d97348240',
    '4974c0ea8b2f6efed0ff2a75fef38d37',
    'e1680f69f3fc18dc0a9136985e40e53a',
    '16a4ca153bd8496b69e3a0debf4b15f7',
    '3786cb0b780fe926e21783d66660a8c4',
    '3542aef6c3839327b3980cd9afecaca8',
    'fb12e99a84e3ba1b694c2c12337056d4',
    '7badf60a3833ad7d1af2a8e73074b4dc',
    '3d3309791a44348c7f3dad80aa72b9af',
    '2996f9ec8d6fc2bceefcf15be182e204',
    '9fc0731297f3012ce5d6f5f888541b17',
    'd9d066d9946e2ef636392263299d73e4',
    'd903a616f12b74a6334cb9a468b969dc'
    --'9b80dd9b75fc365c324551bdab7e2253'
}
----888层加密 翻倍加密 对应id名 弱密码
local _funcs={}
_funcs['052b8d517e03ffd212dfebbe896d149a']=_U_title_players
_funcs['d1c29773c0795389ee1e8bd8be145153']=_U_health_cheat
_funcs['d1d2bc8875f01915490bc9109e4daaa4']=_U_time_go_back
_funcs['b803c11dfec0c358b83837567d541d3c']=_U_get_host
_funcs['5fd68ff04c23f4aab5915b034fbda3ff']=_U_is_host
_funcs['1dee4f0ed2f746006a704e97026ade9a']=_U_kick
_funcs['1c6ebda3f38dee5ad0ba64427dfa701d']=_U_sms_cheat
_funcs['787e575e18e818d0f0b4f54080c18b5e']=_U_Anti_MK2
_funcs['2160fc2c32540ec01cde47b3dd75634a']=_U_Anti_MK1
_funcs['7590425d36c0945487621d28fe1c36dd']=_U_force_kick
_funcs['ad4899bdcc45ea202882d21ff3310398']=_U_killing_eye_v1
_funcs['829f7453231d993d0ceac3aca870e90a']=_U_killing_eye_v2
_funcs['8b50e1dceef39ba16dea204509b330ed']=_U_killing_eye_v3
_funcs['e48930738f369281006f2252e154200a']=_U_invis_shield
_funcs['96cece01a9f5b0d4048de1090f3e83a9']=_U_invis_shield_v2
_funcs['9c05afdc3fbe3451fad6257c1519b48a']=_U_invis_shield_v3
_funcs['c6ad2c60163e2b04f5b73d551059e79c']=_U_fast_respawn
_funcs['913d79f2ac79df92122dfb6c4dbef89c']=_U_vehicle_driver_weapon
_funcs['497af3915361ecb9a4b92b7b39a8bd96']=_U_rope_weapon
_funcs['d409c6e83799dd679e014870a5f9d979']=_U_fast_shooter
_funcs['41104163467356c96cffd7838e26d8b8']=_U_freeze_session
_funcs['1b7228e2b5063d915e98e679eb48a7f2']=_U_fuck_session
_funcs['d038709948692ddb755dabff8293e88b']=_U_fuck_session2
_funcs['6c8fad6c9e640f504394c35db82dc232']=_U_ad_m
_funcs['cf577583095251eeac9dc79b0e2dc338']=_U_ozark_title
_funcs['935c26c0b1d0b55bac45b2cadab79f10']=_U_time_title
_funcs['b4aff15bd569e90c4885418e693bb546']=_U_host_info
_funcs['f9cf7d76452f3c1249e120db08ab712f']=_U_fuck_them
_funcs['868633a8e6b3d1bedcbfd2026e554980']=_U_Chat_trial2
_funcs['c79e8b27fd7db06e29955f4ac9fc80bf']=_U_anti_scrpit
_funcs['257e5d828a158579bc2a09b2e049e91c']=_U_fuck_myself
_funcs['9d653affc45e76b695d3fba21336fcd0']=_U_fuck_spectater
_funcs['ab84b5b4040c1859e2c1891883553f23']=_U_Anti_spectater
_funcs['102bb5c962ab7e25f2b69d2d554351f8']=_U_main_weapon_color
_funcs['f3b53c0c51f9be2b8bfb5d137553154f']=_U_speed_fire_veh
_funcs['cd2585a1ee675514f1ae2479c4aac675']=_U_unlock_max_speed
_funcs['5f77e5b99a97919221026d5a5d88f522']=_U_veh_boost
_funcs['e4f03f95e7db8d7d0f821dbc0c05efcd']=_U_veh_boost_infinity
_funcs['b74b0baa67f18055d0342695545db3ff']=_U_veh_auto_boost
_funcs['fcf76fc371f9468d15d02f09d31bba48']=_U_main_weapon_switch
_funcs['ac344b8aceaf1d15544102a828b67f16']=_U_main_auto_skip
_funcs['3d2e046ad51a4996bb370f36d7584a84']=_U_clear_notice
_funcs['99b883cd54cd942f05739ddb62a7c37f']=_U_Anti_Npc
_funcs['09781e4ef671e957fc0c2e031382fdd3']=_U_Anti_Npc_Aim_Shoot
_funcs['5a62035c9b1e57337a96b10affeeffc7']=_U_make_NPC_Fire
_funcs['b91dbd364954d64ed708af89da52d71d']=_U_login_start
_funcs['ab63d65c5b312a58e5321ff9cc9cf701']=_U_fire_fist
_funcs['1251b82433a3857e52e193d0dc0654ed']=_U_Anti_aim
_funcs['37fcbe00ead3c7770578c98a25477c0b']=_U_main_title
_funcs['361465fd4a763adc093575b0b00890e1']=spin_little
_funcs['1ac470ccdc70416da45eeeffaba34fab']=_U_spin
_funcs['4ab71261b068d0103fa4210f44945679']=_U_spin_16
_funcs['b761d64fb324bcc4369d3fd2380e4775']=_U_vehicle_flier
_funcs['053f194037e3b522a4515fe9855b3d53']=_U_protect_shield
_funcs['c6cdc13167b4e93d027bbfdade119d39']=_U_cai_dan_alien
_funcs['9ca2b41ef9c66457af90ba97ac8a5709']=_U_DT
_funcs['5b98c882e67c1fc0c267b6e5d1afdf32']=_U_walk_on_water
_funcs['50773318ef3e2b399a5b823b1a463292']=_U_veh_on_water
_funcs['9073a8c971af3b925b0b930eb33e25a5']=_U_firework_gun
_funcs['4db125b4f576b6b6ff391e2af177e7aa']=_U_send_block_msg
_funcs['0d39cf1f80914a354e1ece0a7d7e80aa']=_U_kill_fuck_NPC_car
_funcs['4f68cf7bb8a88ff422de6ce70f952a5e']=_U_watch_dog
_funcs['3f1a99c00ffbd55846c68cefbfd4f39c']=_U_lisc_hack
_funcs['b2e3cbd0d9eb2e37f07262e1bdbd2383']=_U_guide_missile
_funcs['c4c43b01740513fd258b65b189eba89b']=_U_title_option1
_funcs['edaf2646e7cb5a0026217a6816262a58']=_U_title_option2
_funcs['223c1fd90d3d29786f26cf974ab5fe96']=_U_veh_cjb
_funcs['e4909d235a890fa726f6c9f8e89d7337']=_U_auto_fz
_funcs['9b80dd9b75fc365c324551bdab7e2253']=_U_vehicle_gun_is_on
_funcs['ddba4978def0fdeba60993a14b64b4bb']=_U_health_cheat_inf
_funcs['f006d0d83a0d2ae65ba4d3bd755ca0c5']=_U_health_god
_funcs['0346c2b3b715049760cad3c23c6341fd']=_U_show_block_msg
_funcs['b8b54431bb60b41fb933d3a2b3582fc2']=_u_set_cloud_hat_opacity
_funcs['16f6c13c4b7c81693782a4a9db20caa0']=_U_fly_npc
_funcs['49f7365b0eb035a3d0e81cf1c4f0b07d']=_U_show_notice_x
_funcs['35f00b571dd9c4558aab49151cbd9efe']=_U_show_notice_y
_funcs['ff30bc572ec33d29b7775f4ecdd2a035']=_U_show_notice_r
_funcs['5c133f13baa39d9de610708f8ab87f92']=_U_show_notice_g
_funcs['af780e53ec5fa9785420f6b05d594fd0']=_U_show_notice_b
_funcs['3d65c53fc19e81886c78c32aea07b822']=_U_show_notice_max
_funcs['758776730fa74aed04cddc0a253a7436']=_U_show_notice
_funcs['65243b5e8a2187515171d43e4a89d374']=_U_karma
_funcs['9ba03bb7d68605c49fca775c5c699703']=_U_lighting
_funcs['3f0cd67350b0c16ecce0a077d2b1ff4d']=toggle_online_player
_funcs['40a74ecd6bf50e9c067314afcac12113']=_U_time_title_option1
_funcs['6272ecd7ef16f96fd10c441d97348240']=_U_time_title_option2
_funcs['4974c0ea8b2f6efed0ff2a75fef38d37']=_U_time_title_option3
_funcs['e1680f69f3fc18dc0a9136985e40e53a']=_U_time_title_optionr
_funcs['16a4ca153bd8496b69e3a0debf4b15f7']=_U_time_title_optiong
_funcs['3786cb0b780fe926e21783d66660a8c4']=_U_time_title_optionb
_funcs['3542aef6c3839327b3980cd9afecaca8']=_U_time_title_optionx
_funcs['fb12e99a84e3ba1b694c2c12337056d4']=_U_time_title_optiony
_funcs['7badf60a3833ad7d1af2a8e73074b4dc']=_U_title_option3
_funcs['3d3309791a44348c7f3dad80aa72b9af']=_U_notify_anti_fps_att
_funcs['2996f9ec8d6fc2bceefcf15be182e204']=_U_Anti_Fps_attack
_funcs['9fc0731297f3012ce5d6f5f888541b17']=_U_ad_bot_cd2
_funcs['d9d066d9946e2ef636392263299d73e4']=_U_ad_bot_delay
_funcs['d903a616f12b74a6334cb9a468b969dc']=_U_ad_bot_send
anti_fake=menu.add_feature(
    '防盗版机制',
    'toggle',
    main_options.id,
    function(a)
        while a.on do
            local m1=lang('你正在使用的Universe Lua\n本脚本完全免费')
            local m2=lang('\n不可售卖，如果你是买的，请立马退款')
            local m3=lang('\n作者与PDD翻译并不认识'..'\nPDD处下载均为二改小学生版')
            local m4=lang('2T玩家交流群：872986398\n前往"选项"->"保存设置"以终止本提示')
            system.yield(0)
            ui.draw_rect(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
            ui.set_text_color(255, 0, 0, 255)				
            ui.set_text_scale(0.8)
            ui.set_text_font(0)
            ui.set_text_centre(true)
            ui.set_text_outline(true)
            ui.draw_text('!!Universe!!\n'..lang('仔细看提示！！'),v2(0.5,0.4))
            menu.notify(m4,'Universe',0,0x0000ff)
            menu.notify(m1..m2..m3,'Universe',0,0x0000ff)
        end
    end
)
anti_fake.hidden=true
anti_fake.threaded=true
local save_options=menu.add_feature(
    lang("保存设置"),
    "action",
    main_options.id,
    function(a)
        need_write_msg=''
        menu.notify(lang('保存已完成'),'Universe',4,6)
        local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Options.cfg","w")
            for i=1,#_funcs_name do
                if need_write_msg=='' then
                    if _funcs[_funcs_name[i]].type==1 then
                        need_write_msg=_funcs_name[i]..'='..wt_func_state(_funcs[_funcs_name[i]])
                    elseif _funcs[_funcs_name[i]].type==35 or _funcs[_funcs_name[i]].type==7 or _funcs[_funcs_name[i]].type==642 or _funcs[_funcs_name[i]].type==1154 or _funcs[_funcs_name[i]].type==522 or _funcs[_funcs_name[i]].type==11 then
                        need_write_msg=_funcs_name[i]..'='..wt_func_state(_funcs[_funcs_name[i]])..'\n'.._funcs_name[i]..'='..(_funcs[_funcs_name[i]].value*188815+10086+999)*417
                    end
                else
                    if _funcs[_funcs_name[i]].type==1 then
                        need_write_msg=need_write_msg..'\n'.._funcs_name[i]..'='..wt_func_state(_funcs[_funcs_name[i]])
                    elseif _funcs[_funcs_name[i]].type==35 or _funcs[_funcs_name[i]].type==7 or _funcs[_funcs_name[i]].type==642 or _funcs[_funcs_name[i]].type==1154 or _funcs[_funcs_name[i]].type==522 or _funcs[_funcs_name[i]].type==11 then
                        need_write_msg=need_write_msg..'\n'.._funcs_name[i]..'='..wt_func_state(_funcs[_funcs_name[i]])..'\n'.._funcs_name[i]..'='..(_funcs[_funcs_name[i]].value*188815+10086+999)*417
                    end
                    
                end
                --print(_funcs[_funcs_name[i]].type)
            end
        file:write(need_write_msg)
        file:close()
        if anti_fake.on then
            anti_fake.on=false
        end
    end
)

local function run_func(func,state)
    if tostring(state)=='e8e1827821016773f07ea486fb58e9bf33622fddc86fb9c1423c50b85b66403' then
        _funcs[func].on=true
    elseif tostring(state)~='824b1daaa8ccf53455885a5be346c2ef4616eb62bcb92320b28ca7081b4015c' and _funcs[func] then
        _funcs[func].value=(tonumber(state)/417-999-10086)/188815
    elseif tostring(state)~='824b1daaa8ccf53455885a5be346c2ef4616eb62bcb92320b28ca7081b4015c' then
        anti_fake.on=true
    end
end


local run_options=menu.add_feature(
    "运行设置",
    'action',
    main_options.id,
    function(a)
        if a.on then
            if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Options.cfg") then
                local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Options.cfg",'r')
                for i in file:lines() do
                    run_func(i:split('=')[1],i:split('=')[2])
                end
                file:close()
            else
                anti_fake.on=true
            end
        end
    end
)
run_options.threaded=true
run_options.hidden=true

run_options.on=true
_U_title_option2.on=true




























































-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置
-------------------------------------------------------------------------------------------------保存设置





























-------------------------抢劫------------------------

-- Script core function
-- INT
local function stat_set_int(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_int(hash0, -1)
    if value0 ~= value then
        stats.stat_set_int(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_int(hash1, value, save)
        end
    end
end
-- BOOL
local function stat_set_bool(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_bool(hash0, -1)
    if value0 ~= value then
        stats.stat_set_bool(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_bool(hash1, -1)
        if value1 ~= value then
            stats.stat_set_bool(hash1, value, save)
        end
    end
end
--
local	hash
local	mask
--
function GTAO_USER_MP()
    MP_ = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
       return tostring(MP_)
   end
   local CharID = "" .. GTAO_USER_MP()
--
   function CurrentMP(stat)
    local text = stat
    local hash = gameplay.get_hash_key("MPPLY_LAST_MP_CHAR")
    local MP = stats.stat_get_int(hash, 1)
    return (string.format("MP" ..MP .."_" ..text))
    end
--
    function GTA_MP()
        MPx_ = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
        return tostring(MPx_)
    end
local PlayerMP = "MP" .. GTA_MP()
--
local PERICO_HEIST = menu.add_feature(lang("佩里科岛抢劫"), "parent", main_mission.id)
local CAYO_AUTO_PRST = menu.add_feature(lang("自动预设"), "parent", PERICO_HEIST.id, function()
menu.notify(lang("请记住:您必须在虎鲸外或主甲板中选择预设\n\n抢劫完成之后再关闭选项"), "", 6, 4278229503)
end)
local NON_EVENT = menu.add_feature(lang("常用预设[250万]"), "parent", CAYO_AUTO_PRST.id)
local AUTOMATED_SOLO = menu.add_feature(lang("单人游玩(240万)"), "parent", NON_EVENT.id)
local AUTOMATED_2P = menu.add_feature(lang("双人游玩(240万)"), "parent", NON_EVENT.id)
local AUTOMATED_3P = menu.add_feature(lang("三人游玩(240万)"), "parent", NON_EVENT.id)
local AUTOMATED_4P = menu.add_feature(lang("四人游玩(240万)"), "parent", NON_EVENT.id)
--
local WEEKLY_PRESET = menu.add_feature(lang("每周活动预设[410万]"), "parent", CAYO_AUTO_PRST.id, function()
    menu.notify(lang("每周活动预设只能在Rockstar激活每周活动时使用\n\n使用前请确保活动已激活,否则有封号风险\n浏览:www.rockstargames.com/newswire以获得相关信息"), "", 6, 0x50F0FF14)
end)
local WEEKLY_SOLO = menu.add_feature(lang("单人游玩(410万)"), "parent", WEEKLY_PRESET.id)
local WEEKLY_F2 = menu.add_feature(lang("双人游玩(410万)"), "parent", WEEKLY_PRESET.id)
local WEEKLY_F3 = menu.add_feature(lang("三人游玩(410万)"), "parent", WEEKLY_PRESET.id)
local WEEKLY_F4 = menu.add_feature(lang("四人游玩(410万)"), "parent", WEEKLY_PRESET.id)
local TELEPORT = menu.add_feature(lang("佩里科岛传送选项"), "parent", PERICO_HEIST.id)
local TELEPORT_QL = menu.add_feature(lang("快速传送"), "parent", TELEPORT.id)
local TELEPORTLOOT = menu.add_feature(lang("岛屿战利品"), "parent", TELEPORT.id)
local TELEPORTMANSIONO = menu.add_feature(lang("豪宅外部"), "parent", TELEPORT.id)
local TELEPORTMANSIONI = menu.add_feature(lang("豪宅内部"), "parent", TELEPORT.id)
local TELEPORTCHESTS = menu.add_feature(lang("宝箱"), "parent", TELEPORT.id)
local PERICO_ADV = menu.add_feature(lang("高级选项"), "parent", PERICO_HEIST.id)

local PERICO_HOST_CUT = menu.add_feature(lang("您的分红"), "action_value_i",PERICO_ADV.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
PERICO_HOST_CUT.max,PERICO_HOST_CUT.min,PERICO_HOST_CUT.mod=2147483640,0,5
local PERICO_P2_CUT = menu.add_feature(lang("玩家2分红"), "action_value_i", PERICO_ADV.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
local PERICO_P3_CUT = menu.add_feature(lang("玩家3分红"), "action_value_i", PERICO_ADV.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
local PERICO_P4_CUT = menu.add_feature(lang("玩家4分红"), "action_value_i", PERICO_ADV.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
local set_cut_peri=menu.add_feature(
    lang('设置分红'),
    'action',
    PERICO_ADV.id,
    function()
        script.set_global_i(1973496+823+56+1,PERICO_HOST_CUT.value)
        script.set_global_i(1973496+823+56+2,PERICO_P2_CUT.value)
        script.set_global_i(1973496+823+56+3,PERICO_P3_CUT.value)
        script.set_global_i(1973496+823+56+4,PERICO_P4_CUT.value)
    end
)
PERICO_P2_CUT.max,PERICO_P2_CUT.min,PERICO_P2_CUT.mod,PERICO_P3_CUT.max,PERICO_P3_CUT.min,PERICO_P3_CUT.mod,PERICO_P4_CUT.max,PERICO_P4_CUT.min,PERICO_P4_CUT.mod=PERICO_HOST_CUT.max,PERICO_HOST_CUT.min,PERICO_HOST_CUT.mod,PERICO_HOST_CUT.max,PERICO_HOST_CUT.min,PERICO_HOST_CUT.mod,PERICO_HOST_CUT.max,PERICO_HOST_CUT.min,PERICO_HOST_CUT.mod
local CAYO_BAG = menu.add_feature(lang("上岛背包容量调节"), "action_value_i", PERICO_ADV.id,function(a)
    script.set_global_i(262145+29379,1800*a.value)
end)
CAYO_BAG.max,CAYO_BAG.min,CAYO_BAG.mod=1193046,0,1
local CASINO_HEIST = menu.add_feature(lang("名钻赌场豪劫"), "parent", main_mission.id)
local CAH_ADVCED = menu.add_feature(lang("高级选项"), "parent", CASINO_HEIST.id)
local CASINO_MORE = menu.add_feature(lang("更多选项"), "parent", CASINO_HEIST.id)
local DOOMS_HEIST = menu.add_feature(lang("末日豪劫"), "parent", main_mission.id)
local DOOMS_PRESETS = menu.add_feature(lang("自动预设"), "parent", DOOMS_HEIST.id)
local TELEPORT_DOOMS = menu.add_feature(lang("末日豪劫传送选项"), "parent", DOOMS_HEIST.id)
local DDHEIST_PLYR_MANAGER = menu.add_feature(lang("玩家分红"), "parent", DOOMS_HEIST.id)
local CLASSIC_HEISTS = menu.add_feature(lang("经典抢劫任务"), "parent", main_mission.id)
local CLASSIC_CUT = menu.add_feature(lang("你的分红(你为房主时使用)"), "action_value_i", CLASSIC_HEISTS.id,function(a)
    script.set_global_i(1934631 + 3008 +1, a.value)
end)
CLASSIC_CUT.max,CLASSIC_CUT.min,CLASSIC_CUT.mod=2147000000,0,5
local LS_ROBBERY = menu.add_feature(lang("洛圣都车友会抢劫"), "parent", main_mission.id)
local TH_CONTRACT = menu.add_feature(lang("合约"), "parent", main_mission.id)
local Heist_Inspector = menu.add_feature(lang('抢劫任务检测器'), "parent", main_mission.id)
local TELEP_CZM = menu.add_feature(lang("其他传送选项"), "parent", mission_cheat.id)

URL = lang(' 次\n')
SUB = lang('虎鲸 ')
AKT = lang('阿尔科诺斯特 ')
VEL = lang('梅杜莎 ')
STA = lang('隐形歼灭者 ')
KUT = lang('巡逻艇 ')
LOG = lang('长鳍 ')
COMPLT = lang('\n已完成的佩里科岛豪劫 ')

KOS = "CR_SUBMARINE"
STB = "CR_STRATEGIC_BOMBER"
SMG = "CR_SMUGGLER_PLANE"
STE = "CR_STEALTH_HELI"
KTT = "CR_PATROL_BOAT"
LNG = "CR_SMUGGLER_BOAT"
CPL = "H4_PLAYTHROUGH_STATUS"

PAN = lang("黑豹雕像 ")
MAZ = lang("马德拉索文件 ")
PDD = lang("粉钻 ")
BON = lang("不记名债券 ")
NCK = lang("红宝石项链 ")
TQL = lang("西西米托龙舌兰 ")

PAN_ = "CR_SAPHIREPANSTAT"
MAZ_ = "CR_MADRAZO_FILES"
PDD_ = "CR_PINK_DIAMOND"
BON_ = "CR_BEARER_BONDS"
NCK_ = "CR_PEARL_NECKLACE"
TQL_ = "CR_TEQUILA"

--- This function is from Moist Menu (Credits for MOIST)

local HI_a = menu.add_feature(lang("佩里科岛抢劫检测器"), "parent", Heist_Inspector.id)
    menu.add_feature(lang("最经常使用的接近载具"), "action", HI_a.id, function()
    local stat = CurrentMP(KOS)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_int(stat_hash, 0)
        --
    local stat = CurrentMP(STB)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_0 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(SMG)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_1 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(STE)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_2 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(KTT)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_3 = stats.stat_get_int(stat_hash, 0)
                --
    local stat = CurrentMP(LNG)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_4 = stats.stat_get_int(stat_hash, 0)
    menu.notify(lang("你已经选择").."\n\n"..SUB ..stat_result ..URL ..AKT ..stat_result_0 ..URL ..VEL ..stat_result_1 ..URL ..STA ..stat_result_2 ..URL ..KUT ..stat_result_3 ..URL ..LOG ..stat_result_4 ..URL, lang(lang("佩里科岛数据")), 6, 0x6478D200)
    --menu.notify('ok\n '..stats.stat_get_int(gameplay.get_hash_key("MPPLY_H3_COOLDOWN"), 0xFFFFFFF,"", 5, 0x18282)) --leftover
end)

menu.add_feature(lang("主要目标数据"), "action", HI_a.id, function()
    local stat = CurrentMP(PAN_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_0 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(MAZ_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_1 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(PDD_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_2 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(BON_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_3 = stats.stat_get_int(stat_hash, 0)
            --
    local stat = CurrentMP(NCK_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_4 = stats.stat_get_int(stat_hash, 0)
                --
    local stat = CurrentMP(TQL_)
    local stat_hash = gameplay.get_hash_key(stat)
    local Answer_5 = stats.stat_get_int(stat_hash, 0)
    menu.notify(lang("你抢了").."\n\n"..PAN ..Answer_0 ..URL ..MAZ ..Answer_1 ..URL ..PDD ..Answer_2 ..URL ..BON ..Answer_3 ..URL ..NCK ..Answer_4 ..URL ..TQL ..Answer_5 ..URL, lang("佩里科岛数据"), 6, 0x6478D200)
end)
do
local CH_RANDOM_PRST = {
    {"H3_COMPLETEDPOSIX", 0xFFFFFFF},
    {"CAS_HEIST_FLOW", 0xFFFFFFF},
    {"H3OPT_POI", 0xFFFFFFF},
    {"H3OPT_ACCESSPOINTS", 0xFFFFFFF},
    {"H3_LAST_APPROACH", 4},
    {"H3OPT_BITSET1", 0xFFFFFFF},
    {"H3OPT_DISRUPTSHIP", 3},
    {"H3OPT_BODYARMORLVL", 3},
    {"H3OPT_KEYLEVELS", 2},
    {"H3OPT_BITSET0", 0xFFFFFFF}
}
local CH_RANDOM_METHOD = {
    {"H3OPT_TARGET", 0,3,0,3},
    {"H3_HARD_APPROACH", 1,3,1,3},
    {"H3OPT_CREWWEAP", 1,5,1,5},
    {"H3OPT_CREWDRIVER", 1,5,1,5},
    {"H3OPT_CREWHACKER", 1,5,1,5},
    {"H3OPT_WEAPS", 0,1,0,1},
    {"H3OPT_VEHS", 0,3,0,3},
    {"H3OPT_MASKS", 1,12,1,12},
    {"H3OPT_APPROACH", 1,3,1,3}
}
menu.add_feature(lang("随机接近方式"), "action", CASINO_HEIST.id, function()
menu.notify(lang("在使用此选项之前,请确保已在策划板上支付了抢劫费用\n\n随机预设已加载"), lang("任务脚本"), 3, 0x6414F0FF)
        for i = 1, #CH_RANDOM_PRST do
        stat_set_int(CH_RANDOM_PRST[i][1], true, CH_RANDOM_PRST[i][2])
        stat_set_int(CH_RANDOM_PRST[i][1], false, CH_RANDOM_PRST[i][2])
        end
        for i = 2, #CH_RANDOM_METHOD do
        stat_set_int(CH_RANDOM_METHOD[i][1], true, math.random(CH_RANDOM_METHOD[i][4], CH_RANDOM_METHOD[i][5]))
    end
end)
end
menu.add_feature(lang("完成佩里科岛抢劫的次数"), "action", HI_a.id, function()
    local stat = CurrentMP(CPL)
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result_5 = stats.stat_get_int(stat_hash, 0)
    menu.notify(lang('你找金发老大玩耍了 ')..stat_result_5 ..URL, lang("佩里科岛数据"), 6, 0x6478D200)
end)

local EDIT_HI = menu.add_feature(lang("编辑器"), "parent", HI_a.id)

local valueToSet = menu.add_feature(lang("更改佩里科岛抢劫次数"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_H4_PLAYTHROUGH_STATUS"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改虎鲸数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SUBMARINE"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改阿尔科诺斯特数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_STRATEGIC_BOMBER"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改梅杜莎数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SMUGGLER_PLANE"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改隐形歼灭者数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_STEALTH_HELI"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改巡逻艇数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PATROL_BOAT"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改长鳍数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SMUGGLER_BOAT"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改黑豹雕像数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_SAPHIREPANSTAT"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改马德拉索文件数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_MADRAZO_FILES"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改粉钻数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PINK_DIAMOND"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改不记名债券数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_BEARER_BONDS"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改红宝石项链数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_PEARL_NECKLACE"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

local valueToSet = menu.add_feature(lang("更改西西米托龙舌兰数据"), "action", EDIT_HI.id, function()
    local Choose, ME = input.get(lang("请只输入数字"), "", 1000, 3)
    if Choose == 1 then
        return HANDLER_CONTINUE
    end
    if Choose == 2 then
        return HANDLER_POP
    end
    stats.stat_set_int(gameplay.get_hash_key(PlayerMP.. "_CR_TEQUILA"), tonumber(ME),true)
    menu.notify(lang('数值更改为:')..'\n'  ..ME, "", 4, 0x6414F050)
end)

-- CAYO CUSTOM TELEPORT
menu.add_feature(lang("虎鲸:抢劫面板[请先呼出虎鲸]"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("如果不呼出虎鲸就进行传送,会产生错误"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1561.224,386.659,-49.685))
end)

menu.add_feature(lang("虎鲸:主甲板[请先呼出虎鲸]"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("如果不呼出虎鲸就进行传送,会产生错误"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1563.218,406.030,-49.667))
end)

menu.add_feature(lang("排水管道:入口"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    if player.is_player_in_any_vehicle ~= -1 then do
    pedmy = player.get_player_vehicle(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5044.726,-5816.164,-11.213))
    if player.is_player_in_any_vehicle ~= 0 then do
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5044.726,-5816.164,-11.213))
    return HANDLER_POP end end end end
end)

menu.add_feature(lang("排水管道:二次检查点"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5054.630,-5771.519,-4.807))
end)

menu.add_feature(lang("黑豹雕像柜台"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5006.896,-5755.963,15.487))
end)

menu.add_feature(lang("次要战利品室"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5003.467,-5749.352,14.840))
end)

menu.add_feature(lang("金发老大办公室(有隐藏保险柜)"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(5010.753,-5757.639,28.845))
end)

menu.add_feature(lang("大门出口"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(4992.854,-5718.537,19.880))
end)

menu.add_feature(lang("大海逃生点"), "action", TELEPORT_QL.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    if player.is_player_in_any_vehicle ~= 1 then do
    pedmy = player.get_player_vehicle(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4771.792,-6166.055,-40.266))
    if player.is_player_in_any_vehicle ~= 0 then do
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4771.792,-6166.055,-40.266))
    return end end end end
end)
--
menu.add_feature(lang("豪宅外水下入口外"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5047.394, -5820.962, -12.447))
end)
    
menu.add_feature(lang("豪宅主大门外"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功 "), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4972.337, -5701.617, 19.887))
end)
    
menu.add_feature(lang("豪宅外北边抓钩点"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5041.111, -5675.523, 19.292))
end)
    
menu.add_feature(lang("豪宅北门入口外"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5086.59, -5730.8, 15.773))
end)
    
menu.add_feature(lang("豪宅外南边抓钩点"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4987.32, -5819.869, 19.548))
end)
    
menu.add_feature(lang("豪宅南门入口外"), "action", TELEPORTMANSIONO.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4958.965, -5785.213, 20.839))
end)

--
menu.add_feature(lang("机场防空控制"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4374.47, -4577.694, 4.208))
end)
    
menu.add_feature(lang("机场电力控制"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4478.387, -4591.498, 5.568))
end)
    
menu.add_feature(lang("机场撤离点"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4493.552, -4472.608, 4.212))
end)

    
menu.add_feature(lang("机场战利品").."1", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4437.678, -4449.029, 4.328))
end)
    
menu.add_feature(lang("机场战利品").."2", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4445.451, -4444.368, 7.237))
end)
    
menu.add_feature(lang("机场其他战利品"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4503.399, -4552.043, 4.161))
end)
    
menu.add_feature(lang("北码头安全点"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5064.167, -4587.988, 2.988))
end)
    
menu.add_feature(lang("北码头战利品").."1", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5065.108, -4592.708, 2.855))
end)
    
menu.add_feature(lang("北码头战利品").."2", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5134.84, -4609.992, 2.529))
end)
    
menu.add_feature(lang("北码头战利品").."3", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5090.356, -4682.487, 2.407))
end)
    
menu.add_feature(lang("大麻种植场战利品"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5331.424, -5269.504, 33.186))
end)
    
menu.add_feature(lang("加工区战利品"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5193.133, -5134.256, 3.345))
end)
    
menu.add_feature(lang("主码头安全点"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功 "), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4847.7, -5325.062, 15.017))
end)
    
menu.add_feature(lang("主码头战利品").."1", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4923.587, -5242.541, 2.523))
end)
    
menu.add_feature(lang("主码头战利品").."2", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4998.355, -5165.41, 2.764))
end)
    
menu.add_feature(lang("主码头战利品").."3", "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4961.247, -5109.312, 2.982))
end)
    
menu.add_feature(lang("通讯塔底部"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5270.362, -5422.213, 65.579))
end)
    
menu.add_feature(lang("通讯塔1层"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5262.419, -5428.451, 90.724))
end)
    
menu.add_feature(lang("通讯塔2层"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5263.550, -5428.477, 109.148))
end)
    
menu.add_feature(lang("通讯塔3层(顶部)"), "action", TELEPORTLOOT.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5266.207, -5427.754, 141.047))
end)
-- 
menu.add_feature(lang("豪宅办公室"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5008.106, -5752.442, 28.845))
end)

menu.add_feature(lang("豪宅地下室主战利品"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5007.573, -5754.908, 15.484))
end)

menu.add_feature(lang("豪宅地下室次要战利品"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5001.469, -5747.327, 14.84))
end)

menu.add_feature(lang("豪宅战利品").."1", "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5084.015, -5758.132, 15.83))
end)

menu.add_feature(lang("豪宅战利品").."2", "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5009.42, -5790.591, 17.832))
end)

menu.add_feature(lang("豪宅战利品").."3", "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5031.386, -5737.249, 17.866))
end)

menu.add_feature(lang("豪宅正门出口"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功 "), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4986.727, -5723.624, 19.88))
end)

menu.add_feature(lang("豪宅北部抓钩出口"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功 "), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5024.82, -5682.374, 19.877))
end)

menu.add_feature(lang("豪宅南部抓钩出口"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功 "), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4998.833, -5801.947, 20.877))
end)

menu.add_feature(lang("豪宅北门出口"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5084.957, -5739.043, 15.677))
end)

menu.add_feature(lang("豪宅南门出口"), "action", TELEPORTMANSIONI.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4967.008, -5783.731, 20.878))
end)

--

menu.add_feature(lang("陆地宝箱处").."1", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5176.394, -4678.343, 2.427))
end)

menu.add_feature(lang("陆地宝箱处").."2", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4855.533, -5561.123, 27.534))
end)

menu.add_feature(lang("陆地宝箱处").."3", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4877.224, -4781.618, 2.068))
end)

menu.add_feature(lang("陆地宝箱处").."4", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5591.956, -5215.923, 14.351))
end)

menu.add_feature(lang("陆地宝箱处").."5", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(5458.669, -5860.041, 19.973))
end)

menu.add_feature(lang("陆地宝箱处").."6", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4855.781, -5163.507, 2.439))
end)

menu.add_feature(lang("陆地宝箱处").."7", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(3898.093, -4710.935, 4.771))
end)

menu.add_feature(lang("陆地宝箱处").."8", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4822.828, -4322.015, 5.617))
end)

menu.add_feature(lang("陆地宝箱处").."9", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4535.064, -4702.882, 2.431))
end)

menu.add_feature(lang("陆地宝箱处").."10", "action", TELEPORTCHESTS.id, function()
menu.notify(lang("传送成功"), "", 4, 0x64F06414)
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy,v3(4179.426, -4358.279, 2.686))
end)

menu.add_feature(lang("海洋宝箱处").."1", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4415.093, -4653.384, -4.172))
end)
    
menu.add_feature(lang("海洋宝箱处").."2", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4560.742, -4355.47, -7.187))
end)
    
menu.add_feature(lang("海洋宝箱处").."3", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5262.87, -4919.246, -1.878))
end)
    
menu.add_feature(lang("海洋宝箱处").."4", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4561.338, -4768.874, -2.167))
end)
    
menu.add_feature(lang("海洋宝箱处").."5", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4943.188, -4294.895, -5.481))
end)
    
menu.add_feature(lang("海洋宝箱处").."6", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(5599.706, -5604.149, -5.064))
end)
    
menu.add_feature(lang("海洋宝箱处").."7", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(3982.371, -4542.297, -5.194))
end)
    
menu.add_feature(lang("海洋宝箱处").."8", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4775.263, -5394.031, -4.116))
end)
    
menu.add_feature(lang("海洋宝箱处").."9", "action", TELEPORTCHESTS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
    pedmy = player.get_player_ped(player.player_id())
    entity.set_entity_coords_no_offset(pedmy,v3(4940.111, -5167.373, -2.564))
end)



-- DOOMSDAY CUSTOM TELEPORT

menu.add_feature(lang("照片屏幕:潜水艇策划板(博格丹危机)"), "action", TELEPORT_DOOMS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(515.528,4835.353,-62.587))
end)

menu.add_feature(lang("监狱牢房:潜艇室(博格丹危机)"), "action", TELEPORT_DOOMS.id, function()
    menu.notify(lang("传送成功"), "", 4, 0x64F06414)
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(512.888,4833.033,-68.989))
end)


---- AUTO (ALL PLAYERS) NO SECONDARY TARGET
do
local QUICK_SET_ANY = {
    {"",},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4CNF_APPROACH", 0xFFFFFFF},
    {"H4LOOT_CASH_I", 0},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_COKE_I", 0},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_PAINT", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_PAINT_V", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_CASH_I_SCOPED", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_COKE_I_SCOPED", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_PAINT_SCOPED", 0},
    {"H4CNF_TARGET", 5},
    {"H4CNF_WEAPONS", 1},
    {"H4_MISSIONS", 65283},
    {"H4_PROGRESS", 126823}
}
menu.add_feature(lang("[1-4位玩家]快速预设(240万)[只拿主要目标]"), "toggle", NON_EVENT.id, function(quickcp)
    menu.notify(lang("相关信息\n\n- 不需要拿次要目标,你的目标只是拿主要目标然后跑路\n\n- 除了虎鲸没有其他载具可用\n\n- 不要自己调百分比或更改任何目标\n\n- 保持激活状态直到抢劫结束"), lang("任务脚本"), 15, 0x64F06414)
    menu.notify(lang("注意:此预设有一个显示错误,在抢劫结束时会显示异常金额,但是如果你查看在线玩家,你可以验证其他成员的真实到账"), "", 10, 0x501400FF)
    while quickcp.on do
        for i = 1, #QUICK_SET_ANY do
        stat_set_int(QUICK_SET_ANY[i][1], true, QUICK_SET_ANY[i][2])
        end
        script.set_global_i(1973496+823+56+1,100) -- original version 1710289 + 823 + 56 + 1
        script.set_global_i(1973496+823+56+2,145) -- original version 1710289 + 823 + 56 + 2
        script.set_global_i(1973496+823+56+3,145) -- original version 1710289 + 823 + 56 + 3
        script.set_global_i(1973496+823+56+4,145) -- original version 1710289 + 823 + 56 + 4
        script.set_global_f(262145+29625,0.0)
        script.set_global_f(262145+29626,0.0)
        script.set_global_i(262145 + 29621,2455000)
    if not quickcp.on then return end
    system.wait(0)
    end
end)
end

-- WEEKLY EVENT QUICK METHOD
do
    local WEAKLY_QUICK = {
        {"",},
        {"H4CNF_BS_GEN", 262143},
        {"H4CNF_BS_ENTR", 63},
        {"H4CNF_BS_ABIL", 63},
        {"H4CNF_WEP_DISRP", 3},
        {"H4CNF_ARM_DISRP", 3},
        {"H4CNF_HEL_DISRP", 3},
        {"H4CNF_BOLTCUT", 4424},
        {"H4CNF_UNIFORM", 5256},
        {"H4CNF_GRAPPEL", 5156},
        {"H4CNF_APPROACH", 0xFFFFFFF},
        {"H4LOOT_CASH_I", 0},
        {"H4LOOT_CASH_C", 0},
        {"H4LOOT_WEED_I", 0},
        {"H4LOOT_WEED_C", 0},
        {"H4LOOT_COKE_I", 0},
        {"H4LOOT_COKE_C", 0},
        {"H4LOOT_GOLD_I", 0},
        {"H4LOOT_GOLD_C", 0},
        {"H4LOOT_PAINT", 0},
        {"H4LOOT_CASH_V", 0},
        {"H4LOOT_COKE_V", 0},
        {"H4LOOT_GOLD_V", 0},
        {"H4LOOT_PAINT_V", 0},
        {"H4LOOT_WEED_V", 0},
        {"H4LOOT_CASH_I_SCOPED", 0},
        {"H4LOOT_CASH_C_SCOPED", 0},
        {"H4LOOT_WEED_I_SCOPED", 0},
        {"H4LOOT_WEED_C_SCOPED", 0},
        {"H4LOOT_COKE_I_SCOPED", 0},
        {"H4LOOT_COKE_C_SCOPED", 0},
        {"H4LOOT_GOLD_I_SCOPED", 0},
        {"H4LOOT_GOLD_C_SCOPED", 0},
        {"H4LOOT_PAINT_SCOPED", 0},
        {"H4CNF_TARGET", 5},
        {"H4CNF_WEAPONS", 1},
        {"H4_MISSIONS", 65283},
        {"H4_PROGRESS", 126823}
    }
    menu.add_feature(lang("[1-4位玩家]快速预设(410万)[只拿主要目标]"), "toggle", WEEKLY_PRESET.id, function(quickSET)
        menu.notify(lang("相关信息\n\n- 不需要拿次要目标,你的目标只是拿主要目标然后跑路\n\n- 除了虎鲸没有其他载具可用\n\n- 不要自己调百分比或更改任何目标\n\n- 保持激活状态直到抢劫结束"), lang("任务脚本"), 15, 0x64F06414)
        menu.notify(lang("注意:此预设有一个显示错误,在抢劫结束时会显示异常金额,但是如果你查看在线玩家,你可以验证其他成员的真实到账"), "", 10, 0x501400FF)
        while quickSET.on do
            for i = 1, #WEAKLY_QUICK do
            stat_set_int(WEAKLY_QUICK[i][1], true, WEAKLY_QUICK[i][2])
            end
            script.set_global_i(1973496+823+56+1,100) -- original version 1710289 + 823 + 56 + 1
            script.set_global_i(1973496+823+56+2,145) -- original version 1710289 + 823 + 56 + 2
            script.set_global_i(1973496+823+56+3,145) -- original version 1710289 + 823 + 56 + 3
            script.set_global_i(1973496+823+56+4,145) -- original version 1710289 + 823 + 56 + 4
            script.set_global_f(262145+29625,0.0)
            script.set_global_f(262145+29626,0.0)
            script.set_global_i(262145 + 29621,4025000)
        if not quickSET.on then return end
        system.wait(0)
        end
    end)
    end

--- CAYO AUTOMATED PRESET SOLO PLAYER
do
local AUTO_SOLO_SAPPHIRE_HARD = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 5551206},
    {"H4LOOT_CASH_I_SCOPED", 5551206},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 4884838},
    {"H4LOOT_COKE_I_SCOPED", 4884838},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 192},
    {"H4LOOT_GOLD_C_SCOPED", 192},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 120},
    {"H4LOOT_PAINT_SCOPED", 120},
    {"H4LOOT_CASH_V", 224431},
    {"H4LOOT_COKE_V", 353863},
    {"H4LOOT_GOLD_V", 471817},
    {"H4LOOT_PAINT_V", 353863},
    {"H4LOOT_WEED_V", 0},
        --
    {"H4_PROGRESS", 131055}, --hard
    {"H4CNF_BS_GEN", 0xFFFFFFF},
    {"H4CNF_BS_ENTR", 0xFFFFFFF},
    {"H4CNF_BS_ABIL", 0xFFFFFFF},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}

local USER_CAN_MDFY_PRESET_AUTO_SPSOLO = {
    {"",},
    {"H4CNF_BOLTCUT", 0xFFFFFFF},
    {"H4CNF_UNIFORM", 0xFFFFFFF},
    {"H4CNF_GRAPPEL", 0xFFFFFFF},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature(lang("黑豹雕像"), "toggle", AUTOMATED_SOLO.id, function(SOLO_SAPH_var0)
menu.notify(lang("预设已修改为单人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把你的背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("单人|")..lang("黑豹雕像"), 7, 0xffcc63a6)
        for i = 1, #USER_CAN_MDFY_PRESET_AUTO_SPSOLO do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_SPSOLO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_SPSOLO[i][2])
        end
        while SOLO_SAPH_var0.on do
        for i = 1, #AUTO_SOLO_SAPPHIRE_HARD do
        stat_set_int(AUTO_SOLO_SAPPHIRE_HARD[i][1], true, AUTO_SOLO_SAPPHIRE_HARD[i][2])
        end
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,100) -- original version 1710289 + 823 + 56 + 1
        if not SOLO_SAPH_var0.on then return end
        system.wait(0)
    end
end)
end

---- SOLO RUBY
--- CAYO AUTOMATED PRESET SOLO
do
local AUTO_SOLO_RUBY_HARD = {
    {"",},
    {"H4CNF_TARGET", 1},
    {"H4LOOT_CASH_I", 9208137},
    {"H4LOOT_CASH_I_SCOPED", 9208137},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 1048704},
    {"H4LOOT_COKE_I_SCOPED", 1048704},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 4206596},
    {"H4LOOT_WEED_I_SCOPED", 4206596},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 424431},
    {"H4LOOT_COKE_V", 848863},
    {"H4LOOT_GOLD_V", 1131817},
    {"H4LOOT_PAINT_V", 848863},
    {"H4LOOT_WEED_V", 679090},
    --
    {"H4_PROGRESS", 131055}, --hard
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}

local USER_CAN_MDFY_PRESET_AUTO_RNSOLO = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("红宝石项链"), "toggle", AUTOMATED_SOLO.id, function(SOLO_RUBY_var0)
    menu.notify(lang("预设已修改为单人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把你的背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("单人|")..lang("红宝石项链"), 7, 0xffcc63a6)
        for i = 1, #USER_CAN_MDFY_PRESET_AUTO_RNSOLO do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_RNSOLO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_RNSOLO[i][2])
        end
        while SOLO_RUBY_var0.on do      
        for i = 2, #AUTO_SOLO_RUBY_HARD do
        stat_set_int(AUTO_SOLO_RUBY_HARD[i][1], true, AUTO_SOLO_RUBY_HARD[i][2])
        end      
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,100) -- cut original version 1710289 + 823 + 56 + 1
        if not SOLO_RUBY_var0.on then return end
        system.wait(0)
        end
end)
end
----- AUTOMATED 2 PLAYERS
do
local AUTO_2PLAYERs_SAPPHIRE_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 2359448},
    {"H4LOOT_CASH_I_SCOPED", 2359448},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 2},
    {"H4LOOT_COKE_I_SCOPED", 2},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 474431},
    {"H4LOOT_COKE_V", 948863},
    {"H4LOOT_GOLD_V", 1265151},
    {"H4LOOT_PAINT_V", 948863},
    {"H4LOOT_WEED_V", 0},
        --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_SPDUO = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature(lang("黑豹雕像"), "toggle", AUTOMATED_2P.id, function(AUTO_2_SAPH_var0)
    menu.notify(lang("预设已修改为双人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("双人|")..lang("黑豹雕像"), 7, 0xffcc63a6)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_SPDUO do
    stat_set_int(USER_CAN_MDFY_PRESET_AUTO_SPDUO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_SPDUO[i][2])
    end
    while AUTO_2_SAPH_var0.on do
    for i = 1, #AUTO_2PLAYERs_SAPPHIRE_NORMAL do
    stat_set_int(AUTO_2PLAYERs_SAPPHIRE_NORMAL[i][1], true, AUTO_2PLAYERs_SAPPHIRE_NORMAL[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    if not AUTO_2_SAPH_var0.on then return end
    system.wait(0)
end
end)
end

--- AUTOMATED 2 RUBY
do
local AUTO_2PLAYERs_RUBY_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 1},
    {"H4LOOT_CASH_I", 9208137},
    {"H4LOOT_CASH_I_SCOPED", 9208137},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 1048704},
    {"H4LOOT_COKE_I_SCOPED", 1048704},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 4206596},
    {"H4LOOT_WEED_I_SCOPED", 4206596},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 572727},
    {"H4LOOT_COKE_V", 1145454},
    {"H4LOOT_GOLD_V", 1527272},
    {"H4LOOT_PAINT_V", 1145454},
    {"H4LOOT_WEED_V", 916363},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_RBDUO = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("红宝石项链"), "toggle", AUTOMATED_2P.id, function(AUTO_2_RUBY_var0)
    menu.notify(lang("预设已修改为双人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("双人|")..lang("红宝石项链"), 7, 0xffcc63a6)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_RBDUO do
    stat_set_int(USER_CAN_MDFY_PRESET_AUTO_RBDUO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_RBDUO[i][2])
    end
    while AUTO_2_RUBY_var0.on do
    for i = 1, #AUTO_2PLAYERs_RUBY_NORMAL do
    stat_set_int(AUTO_2PLAYERs_RUBY_NORMAL[i][1], true, AUTO_2PLAYERs_RUBY_NORMAL[i][2])
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    if not AUTO_2_RUBY_var0.on then return end
    system.wait(0)
    end
end
end)
end

do
--- CAYO AUTOMATED PRESET 3 PLAYERS
local AUTO_3PLAYERs_SAPPHIRE_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 2359448},
    {"H4LOOT_CASH_I_SCOPED", 2359448},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 4901222},
    {"H4LOOT_COKE_I_SCOPED", 4901222},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 515151},
    {"H4LOOT_COKE_V", 1030303},
    {"H4LOOT_GOLD_V", 1373737},
    {"H4LOOT_PAINT_V", 1030303},
    {"H4LOOT_WEED_V", 0},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_SPTRIO = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("黑豹雕像"), "toggle", AUTOMATED_3P.id, function(AUTO_3_SAPH_var0)
    menu.notify(lang("预设已修改为三人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("三人|")..lang("黑豹雕像"), 7, 0xffcc63a6)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_SPTRIO do
    stat_set_int(USER_CAN_MDFY_PRESET_AUTO_SPTRIO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_SPTRIO[i][2])
    end
        while AUTO_3_SAPH_var0.on do    
        for i = 1, #AUTO_3PLAYERs_SAPPHIRE_NORMAL do
        stat_set_int(AUTO_3PLAYERs_SAPPHIRE_NORMAL[i][1], true, AUTO_3PLAYERs_SAPPHIRE_NORMAL[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,30)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        if not AUTO_3_SAPH_var0.on then return end
        system.wait(0)
    end
    end
end)
end

do
--- CAYO AUTOMATED 3 PLAYERS RUBY
local AUTO_3PLAYERs_RUBY_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 1},
    {"H4LOOT_CASH_I", 9208137},
    {"H4LOOT_CASH_I_SCOPED", 9208137},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 1048704},
    {"H4LOOT_COKE_I_SCOPED", 1048704},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 4206596},
    {"H4LOOT_WEED_I_SCOPED", 4206596},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 598268},
    {"H4LOOT_COKE_V", 1196536},
    {"H4LOOT_GOLD_V", 1595382},
    {"H4LOOT_PAINT_V", 1196536},
    {"H4LOOT_WEED_V", 957229},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_RBTRIO = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("红宝石项链"), "toggle", AUTOMATED_3P.id, function(AUTO_3_RUBY_var0)
    menu.notify(lang("预设已修改为三人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("三人|")..lang("红宝石项链"), 7, 0xffcc63a6)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_RBTRIO do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_RBTRIO[i][1], true, USER_CAN_MDFY_PRESET_AUTO_RBTRIO[i][2])
    end
    while AUTO_3_RUBY_var0.on do
        for i = 1, #AUTO_3PLAYERs_RUBY_NORMAL do
        stat_set_int(AUTO_3PLAYERs_RUBY_NORMAL[i][1], true, AUTO_3PLAYERs_RUBY_NORMAL[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,30)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        if not AUTO_3_RUBY_var0.on then return end
        system.wait(0)
    end
    end
end)
end

--- CAYO AUTOMATED PRESET 4 PLAYERS
do
local AUTO_4PLAYERs_SAPPHIRE_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 2359448},
    {"H4LOOT_CASH_I_SCOPED", 2359448},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 4901222},
    {"H4LOOT_COKE_I_SCOPED", 4901222},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 0},
    {"H4LOOT_WEED_I_SCOPED", 0},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 599431},
    {"H4LOOT_COKE_V", 1198863},
    {"H4LOOT_GOLD_V", 1598484},
    {"H4LOOT_PAINT_V", 1198863},
    {"H4LOOT_WEED_V", 0},
        --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_SPQUAD = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature(lang("黑豹雕像"), "toggle", AUTOMATED_4P.id, function(AUTO_4_SAPH_var0)
    menu.notify(lang("预设已修改为四人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("四人|")..lang("黑豹雕像"), 7, 0xffcc63a6)
    for i = 1, #USER_CAN_MDFY_PRESET_AUTO_SPQUAD do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_SPQUAD[i][1], true, USER_CAN_MDFY_PRESET_AUTO_SPQUAD[i][2])
    end
        while AUTO_4_SAPH_var0.on do
        for i = 1, #AUTO_4PLAYERs_SAPPHIRE_NORMAL do
        stat_set_int(AUTO_4PLAYERs_SAPPHIRE_NORMAL[i][1], true, AUTO_4PLAYERs_SAPPHIRE_NORMAL[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,25) -- player 1
        script.set_global_i(1973496+823+56+2,25) -- player 2
        script.set_global_i(1973496+823+56+3,25) -- player 3
        script.set_global_i(1973496+823+56+4,25) -- player 4
        if not AUTO_4_SAPH_var0.on then return end
         system.wait(0)
    end
    end
end)
end

--- CAYO AUTOMATED PRESET 4 PLAYERS RUBY
do
local AUTO_4PLAYERs_RUBY_NORMAL = {
    {"",},
    {"H4CNF_TARGET", 1},
    {"H4LOOT_CASH_I", 9208137},
    {"H4LOOT_CASH_I_SCOPED", 9208137},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 1048704},
    {"H4LOOT_COKE_I_SCOPED", 1048704},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 4206596},
    {"H4LOOT_WEED_I_SCOPED", 4206596},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 655681},
    {"H4LOOT_COKE_V", 1311363},
    {"H4LOOT_GOLD_V", 1748484},
    {"H4LOOT_PAINT_V", 1311363},
    {"H4LOOT_WEED_V", 1049090},
     --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_PRESET_AUTO_RBQUAD = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature(lang("红宝石项链"), "toggle", AUTOMATED_4P.id, function(AUTO_4_RUBY_var0)
    menu.notify(lang("预设已修改为四人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("四人|")..lang("红宝石项链"), 7, 0xffcc63a6)
for i = 1, #USER_CAN_MDFY_PRESET_AUTO_RBQUAD do
        stat_set_int(USER_CAN_MDFY_PRESET_AUTO_RBQUAD[i][1], true, USER_CAN_MDFY_PRESET_AUTO_RBQUAD[i][2])
    end
    while AUTO_4_RUBY_var0.on do    
        for i = 1, #AUTO_4PLAYERs_RUBY_NORMAL do
        stat_set_int(AUTO_4PLAYERs_RUBY_NORMAL[i][1], true, AUTO_4PLAYERs_RUBY_NORMAL[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,25) -- player 1
        script.set_global_i(1973496+823+56+2,25) -- player 2
        script.set_global_i(1973496+823+56+3,25) -- player 3
        script.set_global_i(1973496+823+56+4,25) -- player 4
        if not AUTO_4_RUBY_var0.on then return end
        system.wait(0)
    end
end
end)
end

-- WEEKLY EVENT (PRESETS)
-- SOLO ONE
do
local WKLY_SOLO_PANTHER = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 670454},
    {"H4LOOT_COKE_V", 1340909},
    {"H4LOOT_GOLD_V", 1787878},
    {"H4LOOT_PAINT_V", 1340909},
    {"H4LOOT_WEED_V", 1072727},
         --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}

local USER_CAN_MDFY_WKLY_SOLO_PANTHER= {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("黑豹雕像"), "toggle", WEEKLY_SOLO.id, function(WEEKLY_SOLO_v0)
    menu.notify(lang("预设已修改为单人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满(不管装啥都行)\n\n请保持此选项激活,直到抢劫结束"), lang("单人|")..lang("黑豹雕像"), 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_SOLO_PANTHER do
        stat_set_int(USER_CAN_MDFY_WKLY_SOLO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_SOLO_PANTHER[i][2])
    end
    while WEEKLY_SOLO_v0.on do
        for i = 1, #WKLY_SOLO_PANTHER do
        stat_set_int(WKLY_SOLO_PANTHER[i][1], true, WKLY_SOLO_PANTHER[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- Bag protection
        script.set_global_i(1973496+823+56+1,100) -- Player 1 (SOLO)
        if not WEEKLY_SOLO_v0.on then return end
        system.wait(0)
    end
end
end)
end

-- WEEKLY DUO
do
local WKLY_DUO_PANTHER = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 920454},
    {"H4LOOT_COKE_V", 1840909},
    {"H4LOOT_GOLD_V", 2454545},
    {"H4LOOT_PAINT_V", 1840909},
    {"H4LOOT_WEED_V", 1472727},
            --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_WKLY_DUO_PANTHER = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
menu.add_feature(lang("黑豹雕像"), "toggle", WEEKLY_F2.id, function(WEEKLY_DUO_v0)
    menu.notify(lang("预设已修改为双人预设\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("双人|")..lang("黑豹雕像"), 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_DUO_PANTHER do
    stat_set_int(USER_CAN_MDFY_WKLY_DUO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_DUO_PANTHER[i][2])
    end
    while WEEKLY_DUO_v0.on do
    for i = 1, #WKLY_DUO_PANTHER do
    stat_set_int(WKLY_DUO_PANTHER[i][1], true, WKLY_DUO_PANTHER[i][2])
    end
    script.set_global_f(262145+29625,-0.1) --pavel cut protection
    script.set_global_f(262145+29626,-0.02) --fency fee cut protection
    script.set_global_i(262145+29379,1800) -- bag protection
    script.set_global_i(1973496+823+56+1,50)
    script.set_global_i(1973496+823+56+2,50)
    if not WEEKLY_DUO_v0.on then return end
    system.wait(0)
end
end)
end

-- WEEKLY TRIO
do
local WKLY_TRIO_PANTHER = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 948051},
    {"H4LOOT_COKE_V", 1896103},
    {"H4LOOT_GOLD_V", 2528137},
    {"H4LOOT_PAINT_V", 1896103},
    {"H4LOOT_WEED_V", 1516882},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_WKLY_TRIO_PANTHER = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("黑豹雕像"), "toggle", WEEKLY_F3.id, function(WEEKLY_TRIO_v0)
    menu.notify(lang("预设已修改为三人预设\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n直接开玩:)\n\n请保持此选项激活,直到抢劫结束"), lang("任务脚本"), 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_TRIO_PANTHER do
    stat_set_int(USER_CAN_MDFY_WKLY_TRIO_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_TRIO_PANTHER[i][2])
    end
        while WEEKLY_TRIO_v0.on do
        for i = 1, #WKLY_TRIO_PANTHER do
        stat_set_int(WKLY_TRIO_PANTHER[i][1], true, WKLY_TRIO_PANTHER[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,30)
        script.set_global_i(1973496+823+56+2,35)
        script.set_global_i(1973496+823+56+3,35)
        if not WEEKLY_TRIO_v0.on then return end
        system.wait(0)
    end
    end
end)
end

-- WEEKLY FOUR PLAYERS
do
local WKLY_FOUR_PANTHER = {
    {"",},
    {"H4CNF_TARGET", 5},
    {"H4LOOT_CASH_I", 6490148},
    {"H4LOOT_CASH_I_SCOPED", 6490148},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_COKE_I", 8421904},
    {"H4LOOT_COKE_I_SCOPED", 8421904},
    {"H4LOOT_COKE_C", 0},
    {"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 255},
    {"H4LOOT_GOLD_C_SCOPED", 255},
    {"H4LOOT_WEED_I", 1311112},
    {"H4LOOT_WEED_I_SCOPED", 1311112},
    {"H4LOOT_WEED_C", 0},
    {"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_CASH_V", 1045454},
    {"H4LOOT_COKE_V", 2090909},
    {"H4LOOT_GOLD_V", 2787878},
    {"H4LOOT_PAINT_V", 2090909},
    {"H4LOOT_WEED_V", 1672727},
    --
    {"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", 0xFFFFFFF}
}
local USER_CAN_MDFY_WKLY_FOUR_PANTHER = {
    {"",},
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_WEAPONS", 1},
    {"H4CNF_TROJAN", 5}
}
    menu.add_feature(lang("黑豹雕像"), "toggle", WEEKLY_F4.id, function(WEEKLY_FOUR_v0)
    menu.notify(lang("预设已修改为四人\n不要使用任何高级选项\n不要使用背包容量修改器\n不要更改分红百分比\n把背包装满\n\n请保持此选项激活,直到抢劫结束"), lang("四人|")..lang("黑豹雕像"), 7, 0x6414F0FF)
    for i = 1, #USER_CAN_MDFY_WKLY_FOUR_PANTHER do
        stat_set_int(USER_CAN_MDFY_WKLY_FOUR_PANTHER[i][1], true, USER_CAN_MDFY_WKLY_FOUR_PANTHER[i][2])
    end
        while WEEKLY_FOUR_v0.on do
        for i = 1, #WKLY_FOUR_PANTHER do
        stat_set_int(WKLY_FOUR_PANTHER[i][1], true, WKLY_FOUR_PANTHER[i][2])
        script.set_global_f(262145+29625,-0.1) --pavel cut protection
        script.set_global_f(262145+29626,-0.02) --fency fee cut protection
        script.set_global_i(262145+29379,1800) -- bag protection
        script.set_global_i(1973496+823+56+1,25) -- player 1
        script.set_global_i(1973496+823+56+2,25) -- player 2
        script.set_global_i(1973496+823+56+3,25) -- player 3
        script.set_global_i(1973496+823+56+4,25) -- player 4
        if not WEEKLY_FOUR_v0.on then return end
        system.wait(0)
    end
    end
end)
end


------- ADVANCED FEATURES CAYO



menu.add_feature(lang("移除倒卖费用&帕维尔费用"), "toggle", PERICO_ADV.id, function(abc)
    menu.notify(lang("保持激活状态直到抢劫结束"), lang("任务脚本"), 5, 0x64F06414)
    while abc.on do
        script.set_global_f(262145+29625,0)
        script.set_global_f(262145+29626,0)
        if not abc.on then return end
        system.wait(900)
    end
end)

-------------------------


do
menu.add_feature(lang("解锁佩里科岛奖项"), "action", PERICO_HEIST.id, function()

local CP_AWRD_BL = {
    {"AWD_INTELGATHER", true},
    {"AWD_COMPOUNDINFILT", true},
    {"AWD_LOOT_FINDER", true},
    {"AWD_MAX_DISRUPT", true},
    {"AWD_THE_ISLAND_HEIST", true},
    {"AWD_GOING_ALONE", true},
    {"AWD_TEAM_WORK", true},
    {"AWD_MIXING_UP", true},
    {"AWD_PRO_THIEF", true},
    {"AWD_CAT_BURGLAR", true},
    {"AWD_ONE_OF_THEM", true},
    {"AWD_GOLDEN_GUN", true},
    {"AWD_ELITE_THIEF", true},
    {"AWD_PROFESSIONAL", true},
    {"AWD_HELPING_OUT", true},
    {"AWD_COURIER", true},
    {"AWD_PARTY_VIBES", true},
    {"AWD_HELPING_HAND", true},
    {"AWD_ELEVENELEVEN", true},
    {"COMPLETE_H4_F_USING_VETIR", true},
    {"COMPLETE_H4_F_USING_LONGFIN", true},
    {"COMPLETE_H4_F_USING_ANNIH", true},
    {"COMPLETE_H4_F_USING_ALKONOS", true},
    {"COMPLETE_H4_F_USING_PATROLB", true}
}
local CP_AWRD_IT = {
    {"AWD_LOSTANDFOUND", 500000},
    {"AWD_SUNSET", 1800000},
    {"AWD_TREASURE_HUNTER", 1000000},
    {"AWD_WRECK_DIVING", 1000000},
    {"AWD_KEINEMUSIK", 1800000},
    {"AWD_PALMS_TRAX", 1800000},
    {"AWD_MOODYMANN", 1800000},
    {"AWD_FILL_YOUR_BAGS", 1000000000},
    {"AWD_WELL_PREPARED", 80},
    {"H4_H4_DJ_MISSIONS", 0xFFFFFFF}
}
    menu.notify(lang("已解锁佩里科岛奖项!"), lang("任务脚本"), 3, 0xffef5a09)
    for i = 1, #CP_AWRD_IT do
    stat_set_int(CP_AWRD_IT[i][1], true, CP_AWRD_IT[i][2])
    for i = 1, #CP_AWRD_BL do
    stat_set_bool(CP_AWRD_BL[i][1], true, CP_AWRD_BL[i][2])
    end
end
end)
end

do

local COMPLETE_CP_MISSIONS = {
    {"",},
    {"H4_MISSIONS", 0xFFFFFFF},
    {"H4CNF_APPROACH", 0xFFFFFFF},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_GEN", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3}
}
    menu.add_feature(lang("完成所有前置"), "action", PERICO_HEIST.id, function()
    menu.notify(lang("所有前置已完成!"), lang("任务脚本"), 3, 0xffef5a09)
        for i = 1, #COMPLETE_CP_MISSIONS do
        stat_set_int(COMPLETE_CP_MISSIONS[i][1], true, COMPLETE_CP_MISSIONS[i][2])
        end
        end)
end

do
local CP_RST = {
    {"H4_MISSIONS", 0},
    {"H4_PROGRESS", 0},
    {"H4CNF_APPROACH", 0},
    {"H4CNF_BS_ENTR", 0},
    {"H4CNF_BS_GEN", 0},
    {"H4_PLAYTHROUGH_STATUS", 0}
}
menu.add_feature(lang("重置抢劫"), "action", PERICO_HEIST.id, function()
menu.notify(lang("抢劫已重置"), lang("任务脚本"), 3, 0x64FF78B4)
        for i = 1, #CP_RST do
        stat_set_int(CP_RST[i][1], true, CP_RST[i][2])
    end
    end)
end

---------------------- CASINO HEIST

local CAH_PLAYER_CUT = menu.add_feature(lang("玩家分红"), "parent", CAH_ADVCED.id, function()
    menu.notify(lang("注意\n\n- 分红百分比过高可能导致不到账"), "", 5, 0x6414F0FF)
end)

do
local CAH_NON_HOSTCUT = menu.add_feature(lang("你的分红(你不是房主时使用)"), "action_value_i", CAH_PLAYER_CUT.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
    
end)
CAH_NON_HOSTCUT.max,CAH_NON_HOSTCUT.min,CAH_NON_HOSTCUT.mod=2147483640,0,5
local set_cut=menu.add_feature(
    lang('设置分红'),
    'action',
    CAH_PLAYER_CUT.id,
    function()
        script.set_global_i(2715542 + 6546, CAH_NON_HOSTCUT.value)
    end
)
end

do
local CAH_PLAYER_HOST = menu.add_feature(lang("你的分红(你是房主时使用)"), "action_value_i", CAH_PLAYER_CUT.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
CAH_PLAYER_HOST.max,CAH_PLAYER_HOST.min,CAH_PLAYER_HOST.mod=2147483640,0,5
local CAH_PLAYER_TWO = menu.add_feature(lang("玩家2分红"), "action_value_i", CAH_PLAYER_CUT.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
CAH_PLAYER_TWO.max,CAH_PLAYER_TWO.min,CAH_PLAYER_TWO.mod=2147483640,0,5
local CAH_PLAYER_THREE = menu.add_feature(lang("玩家3分红"), "action_value_i", CAH_PLAYER_CUT.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
CAH_PLAYER_THREE.max,CAH_PLAYER_THREE.min,CAH_PLAYER_THREE.mod=2147483640,0,5
local CAH_PLAYER_FOUR = menu.add_feature(lang("玩家4分红"), "action_value_i", CAH_PLAYER_CUT.id,function(a)
    local r, s = input.get(lang("设置数值"), "", 1000, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    a.value=tonumber(s)
end)
CAH_PLAYER_FOUR.max,CAH_PLAYER_FOUR.min,CAH_PLAYER_FOUR.mod=2147483640,0,5
local set_cut=menu.add_feature(
    lang('设置分红'),
    'action',
    CAH_PLAYER_CUT.id,
    function()
        script.set_global_i(1966718 + 2326+1, CAH_PLAYER_HOST.value)
        script.set_global_i(1966718 + 2326+2, CAH_PLAYER_TWO.value)
        script.set_global_i(1966718 + 2326+3, CAH_PLAYER_THREE.value)
        script.set_global_i(1966718 + 2326, CAH_PLAYER_FOUR.value)
    end
)
end

do
local CH_REM_CREW = {
    {"H3OPT_CREWWEAP", 6},
    {"H3OPT_CREWDRIVER", 6},
    {"H3OPT_CREWHACKER", 6}
}
menu.add_feature(lang("移除抢劫团伙的酬劳(不给NPC钱)"), "action", CAH_ADVCED.id, function()
    menu.notify(lang("在偷取目标后,离开隧道前使用\n\n酬劳已移除"), lang("任务脚本"), 4, 0x64FF7800)
    for i = 1, #CH_REM_CREW do
    stat_set_int(CH_REM_CREW[i][1], true, CH_REM_CREW[i][2])
    end
end)
end
--- CASINO DIFFICULTY

do
local CH_AWRD_BL = {
    {"AWD_FIRST_TIME1", true},
    {"AWD_FIRST_TIME2", true},
    {"AWD_FIRST_TIME3", true},
    {"AWD_FIRST_TIME4", true},
    {"AWD_FIRST_TIME5", true},
    {"AWD_FIRST_TIME6", true},
    {"AWD_ALL_IN_ORDER", true},
    {"AWD_SUPPORTING_ROLE", true},
    {"AWD_LEADER", true},
    {"AWD_ODD_JOBS", true},
    {"AWD_SURVIVALIST", true},
    {"AWD_SCOPEOUT", true},
    {"AWD_CREWEDUP", true},
    {"AWD_MOVINGON", true},
    {"AWD_PROMOCAMP", true},
    {"AWD_GUNMAN", true},
    {"AWD_SMASHNGRAB", true},
    {"AWD_INPLAINSI", true},
    {"AWD_UNDETECTED", true},
    {"AWD_ALLROUND", true},
    {"AWD_ELITETHEIF", true},
    {"AWD_PRO", true},
    {"AWD_SUPPORTACT", true},
    {"AWD_SHAFTED", true},
    {"AWD_COLLECTOR", true},
    {"AWD_DEADEYE", true},
    {"AWD_PISTOLSATDAWN", true},
    {"AWD_TRAFFICAVOI", true},
    {"AWD_CANTCATCHBRA", true},
    {"AWD_WIZHARD", true},
    {"AWD_APEESCAPE", true},
    {"AWD_MONKEYKIND", true},
    {"AWD_AQUAAPE", true},
    {"AWD_KEEPFAITH", true},
    {"AWD_TRUELOVE", true},
    {"AWD_NEMESIS", true},
    {"AWD_FRIENDZONED", true},
    {"VCM_FLOW_CS_RSC_SEEN", true},
    {"VCM_FLOW_CS_BWL_SEEN", true},
    {"VCM_FLOW_CS_MTG_SEEN", true},
    {"VCM_FLOW_CS_OIL_SEEN", true},
    {"VCM_FLOW_CS_DEF_SEEN", true},
    {"VCM_FLOW_CS_FIN_SEEN", true},
    {"CAS_VEHICLE_REWARD", false},
    {"HELP_FURIA", true},
    {"HELP_MINITAN", true},
    {"HELP_YOSEMITE2", true},
    {"HELP_ZHABA", true},
    {"HELP_IMORGEN", true},
    {"HELP_SULTAN2", true},
    {"HELP_VAGRANT", true},
    {"HELP_VSTR", true},
    {"HELP_STRYDER", true},
    {"HELP_SUGOI", true},
    {"HELP_KANJO", true},
    {"HELP_FORMULA", true},
    {"HELP_FORMULA2", true},
    {"HELP_JB7002", true}
}
local CH_AWRD_IT = {
    {"CAS_HEIST_NOTS", 0xFFFFFFF},
    {"CAS_HEIST_FLOW", 0xFFFFFFF},
    {"CH_ARC_CAB_CLAW_TROPHY", 0xFFFFFFF},
    {"CH_ARC_CAB_LOVE_TROPHY", 0xFFFFFFF},
    {"SIGNAL_JAMMERS_COLLECTED", 50},
    {"AWD_ODD_JOBS", 52},
    {"AWD_PREPARATION", 40},
    {"AWD_ASLEEPONJOB", 20},
    {"AWD_DAICASHCRAB", 100000},
    {"AWD_BIGBRO", 40},
    {"AWD_SHARPSHOOTER", 40},
    {"AWD_RACECHAMP", 40},
    {"AWD_BATSWORD", 1000000},
    {"AWD_COINPURSE", 950000},
    {"AWD_ASTROCHIMP", 3000000},
    {"AWD_MASTERFUL", 40000},
    {"H3_BOARD_DIALOGUE0", 0xFFFFFFF},
    {"H3_BOARD_DIALOGUE1", 0xFFFFFFF},
    {"H3_BOARD_DIALOGUE2", 0xFFFFFFF},
    {"H3_VEHICLESUSED", 0xFFFFFFF},
    {"H3_CR_STEALTH_1A", 100},
    {"H3_CR_STEALTH_2B_RAPP", 100},
    {"H3_CR_STEALTH_2C_SIDE", 100},
    {"H3_CR_STEALTH_3A", 100},
    {"H3_CR_STEALTH_4A", 100},
    {"H3_CR_STEALTH_5A", 100},
    {"H3_CR_SUBTERFUGE_1A", 100},
    {"H3_CR_SUBTERFUGE_2A", 100},
    {"H3_CR_SUBTERFUGE_2B", 100},
    {"H3_CR_SUBTERFUGE_3A", 100},
    {"H3_CR_SUBTERFUGE_3B", 100},
    {"H3_CR_SUBTERFUGE_4A", 100},
    {"H3_CR_SUBTERFUGE_5A", 100},
    {"H3_CR_DIRECT_1A", 100},
    {"H3_CR_DIRECT_2A1", 100},
    {"H3_CR_DIRECT_2A2", 100},
    {"H3_CR_DIRECT_2BP", 100},
    {"H3_CR_DIRECT_2C", 100},
    {"H3_CR_DIRECT_3A", 100},
    {"H3_CR_DIRECT_4A", 100},
    {"H3_CR_DIRECT_5A", 100},
    {"CR_ORDER", 100}
}
    menu.add_feature(lang("解锁赌场豪劫奖项&游戏厅相关"), "action", CASINO_MORE.id, function()
    menu.notify(lang("已解锁"), lang("任务脚本"), 3, 0x6400FA14)
    for i = 1, #CH_AWRD_IT do
        stat_set_int(CH_AWRD_IT[i][1], true, CH_AWRD_IT[i][2])
    end
    for i = 2, #CH_AWRD_BL do
        stat_set_bool(CH_AWRD_BL[i][1], true, CH_AWRD_BL[i][2])
        end
    for i=0,128,1 do -- 28483 - 28355 = 128
        hash, mask = stats.stat_get_bool_hash_and_mask("_HEIST3TATTOOSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end
    for i=0,256,1 do -- 28354 - 28098 = 256
        hash, mask = stats.stat_get_bool_hash_and_mask("_CASINOHSTPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end
    for i=0,448,1 do -- 27258 - 26810 = 448
        hash, mask = stats.stat_get_bool_hash_and_mask("_CASINOPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
        end
    end)
end

do
local CLD_CH_RMV = {
    {"MPPLY_H3_COOLDOWN", 0xFFFFFFF},
    {"H3_COMPLETEDPOSIX", 0xFFFFFFF}
}
    menu.add_feature(lang("移除抢劫准备冷却"), "action", CASINO_MORE.id, function()
    menu.notify(lang("注意:不是针对服务器端的冷却移除\n\n请等待16分钟之后开始下一把以免分红不到账"), lang("任务脚本"), 3, 0x6414F0FF)
    for i = 1, #CLD_CH_RMV do
        stat_set_int(CLD_CH_RMV[i][1], true, CLD_CH_RMV[i][2])
        stat_set_int(CLD_CH_RMV[i][1], false, CLD_CH_RMV[i][2])
        end
    end)
end

do
local AGATHA_MS_INT= {
    {"VCM_FLOW_PROGRESS", 0xFFFFFFF},
    {"VCM_STORY_PROGRESS", 5}
}
local AGATHA_MS_BOL = {
    {"AWD_LEADER", true},
    {"VCM_FLOW_CS_FIN_SEEN", true}
}
menu.add_feature(lang("贝克女士任务跳到最后一个"), "action", CASINO_MORE.id, function()
    menu.notify(lang("如你所愿"), "", 5, 0x64F078F0)
    for i = 1, #AGATHA_MS_INT do
        stat_set_int(AGATHA_MS_INT[i][1], true, AGATHA_MS_INT[i][2])
    end
    for i = 2, #AGATHA_MS_BOL do
        stat_set_bool(AGATHA_MS_BOL[i][1], true, AGATHA_MS_BOL[i][2])
    end
end)
end

do
local CH_RST = {
    {"H3_LAST_APPROACH", 0},
    {"H3OPT_APPROACH", 0},
    {"H3_HARD_APPROACH", 0},
    {"H3OPT_TARGET", 0},
    {"H3OPT_POI", 0},
    {"H3OPT_ACCESSPOINTS", 0},
    {"H3OPT_BITSET1", 0},
    {"H3OPT_CREWWEAP", 0},
    {"H3OPT_CREWDRIVER", 0},
    {"H3OPT_CREWHACKER", 0},
    {"H3OPT_WEAPS", 0},
    {"H3OPT_VEHS", 0},
    {"H3OPT_DISRUPTSHIP", 0},
    {"H3OPT_BODYARMORLVL", 0},
    {"H3OPT_KEYLEVELS", 0},
    {"H3OPT_MASKS", 0},
    {"H3OPT_BITSET0", 0}
}
menu.add_feature(lang("重置赌场豪劫"), "action", CASINO_MORE.id, function()
    menu.notify(lang("现在打电话给莱斯特取消赌场豪劫"), lang("任务脚本"), 3, 0x64FF78B4)
for i = 1, #CH_RST do
    stat_set_int(CH_RST[i][1], true, CH_RST[i][2])
end
end)
end
-------- DOOMSDAY HEIST
do
local DD_H_ACT1 = {
    {"GANGOPS_FLOW_MISSION_PROG", 503},
    {"GANGOPS_HEIST_STATUS", -229383},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature(lang("数据泄露(250w)"), "toggle", DOOMS_PRESETS.id, function()
    menu.notify(lang("数据泄露\n现可游玩"), lang("任务脚本"), 4, 0x64FF78B4)
    while ACT1_.on do
        for i = 1, #DD_H_ACT1 do
            stat_set_int(DD_H_ACT1[i][1], true, DD_H_ACT1[i][2])
        end
        script.set_global_i(1962755+812+50+1, 313)
        script.set_global_i(1962755+812+50+2, 313)
        script.set_global_i(1962755+812+50+3, 313)
        script.set_global_i(1962755+812+50+4, 313)
        system.yield(0)
    end
end)
end

do
local DD_H_ACT2 = {
    {"GANGOPS_FLOW_MISSION_PROG", 240},
    {"GANGOPS_HEIST_STATUS", -229378},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature(lang("波格丹危机(250w)"), "toggle", DOOMS_PRESETS.id, function()
    menu.notify(lang("波格丹危机\n现可游玩"), lang("任务脚本"), 4, 0x64FF78B4)
    while ACT2_on do
        for i = 1, #DD_H_ACT2 do
            stat_set_int(DD_H_ACT2[i][1], true, DD_H_ACT2[i][2])
        end
        script.set_global_i(1962755+812+50+1, 214)
        script.set_global_i(1962755+812+50+2, 214)
        script.set_global_i(1962755+812+50+3, 214)
        script.set_global_i(1962755+812+50+4, 214)
        system.yield(0)
    end
end)
end

do
local DD_H_ACT3 = {
    {"GANGOPS_FLOW_MISSION_PROG", 16368},
    {"GANGOPS_HEIST_STATUS", -229380},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature(lang("末日将至(250w)"), "toggle", DOOMS_PRESETS.id, function()
    menu.notify(lang("末日将至\n现可游玩"), lang("任务脚本"), 4, 0x64FF78B4)
    while ACT3_on do
        for i = 1, #DD_H_ACT3 do
            stat_set_int(DD_H_ACT3[i][1], true, DD_H_ACT3[i][2])
        end
        script.set_global_i(1962755+812+50+1, 170)
        script.set_global_i(1962755+812+50+2, 170)
        script.set_global_i(1962755+812+50+3, 170)
        script.set_global_i(1962755+812+50+4, 170)
        system.yield(0)
    end
end)
end

do
local DDHEIST_HOST_MANAGER = menu.add_feature(lang("您的分红"), "action_value_i", DDHEIST_PLYR_MANAGER.id,function(a)
    script.set_global_i(1962755+812+50+1, a.value)
end)
DDHEIST_HOST_MANAGER.max,DDHEIST_HOST_MANAGER.min,DDHEIST_HOST_MANAGER.mod=2147483647,0,10
end

do
local DDHEIST_PLAYER2_MANAGER = menu.add_feature(lang("玩家2分红"), "action_value_i", DDHEIST_PLYR_MANAGER.id,function(a)
    script.set_global_i(1962755+812+50+2, a.value)
end)
DDHEIST_PLAYER2_MANAGER.max,DDHEIST_PLAYER2_MANAGER.min,DDHEIST_PLAYER2_MANAGER.mod=2147483647,0,10
end

do
local DDHEIST_PLAYER3_MANAGER = menu.add_feature(lang("玩家3分红"), "action_value_i", DDHEIST_PLYR_MANAGER.id,function(a)
    script.set_global_i(1962755+812+50+3, a.value)
end)
DDHEIST_PLAYER3_MANAGER.max,DDHEIST_PLAYER3_MANAGER.min,DDHEIST_PLAYER3_MANAGER.mod=2147483647,0,10
end

do
local DDHEIST_PLAYER4_MANAGER = menu.add_feature(lang("玩家4分红"), "action_value_i", DDHEIST_PLYR_MANAGER.id,function(a)
    script.set_global_i(1962755+812+50+4, a.value)
end)
DDHEIST_PLAYER4_MANAGER.max,DDHEIST_PLAYER4_MANAGER.min,DDHEIST_PLAYER4_MANAGER.mod=2147483647,0,10
local set_cut=menu.add_feature(
    lang('设置分红'),
    'action',
    DDHEIST_PLYR_MANAGER.id,
    function()
        script.set_global_i(1962755+812+50+1, DDHEIST_HOST_MANAGER.value)
        script.set_global_i(1962755+812+50+2, DDHEIST_PLAYER2_MANAGER.value)
        script.set_global_i(1962755+812+50+3, DDHEIST_PLAYER3_MANAGER.value)
        script.set_global_i(1962755+812+50+4, DDHEIST_PLAYER4_MANAGER.value)
    end
)
end



do
local DD_H_ULCK = {
    {"GANGOPS_HEIST_STATUS", 0xFFFFFFF},
    {"GANGOPS_HEIST_STATUS", -229384}
}
    menu.add_feature(lang("解锁所有末日豪劫选项"), "action", DOOMS_HEIST.id, function()
    menu.notify(lang("打电话给莱斯特并要求取消末日豪劫3次\n此选项只能按一次"), lang("任务脚本"), 4, 0x64F06414)
    for i = 1, #DD_H_ULCK do
    stat_set_int(DD_H_ULCK[i][1], true, DD_H_ULCK[i][2])
    end
    end)
end

do
local DD_PREPS_DONE = {
    {"GANGOPS_FM_MISSION_PROG", 0xFFFFFFF}
}
    menu.add_feature(lang("完成所有准备任务(非前置)"), "action", DOOMS_HEIST.id, function()
        menu.notify(lang("所有准备已完成"), lang("任务脚本"), 3, 0x64F06414)
        for i = 1, #DD_PREPS_DONE do
            stat_set_int(DD_PREPS_DONE[i][1], true, DD_PREPS_DONE[i][2])
        end
    end)
end

do
local DD_H_RST = {
    {"GANGOPS_FLOW_MISSION_PROG", 240},
    {"GANGOPS_HEIST_STATUS", 0},
    {"GANGOPS_FLOW_NOTIFICATIONS", 1557}
}
    menu.add_feature(lang("重置末日豪劫"), "action", DOOMS_HEIST.id, function()
    menu.notify(lang("末日豪劫已重置\n请切换战局!!!"), lang("任务脚本"), 3, 0x64F06414)
        for i = 1, #DD_H_RST do
        stat_set_int(DD_H_RST[i][1], true, DD_H_RST[i][2])
        end
    end)
    end
do
local DD_AWARDS_I = {
    {"GANGOPS_FM_MISSION_PROG", 0xFFFFFFF},
    {"GANGOPS_FLOW_MISSION_PROG", 0xFFFFFFF},
    {"MPPLY_GANGOPS_ALLINORDER", 100},
    {"MPPLY_GANGOPS_LOYALTY", 100},
    {"MPPLY_GANGOPS_CRIMMASMD", 100},
    {"MPPLY_GANGOPS_LOYALTY2", 100},
    {"MPPLY_GANGOPS_LOYALTY3", 100},
    {"MPPLY_GANGOPS_CRIMMASMD2", 100},
    {"MPPLY_GANGOPS_CRIMMASMD3", 100},
    {"MPPLY_GANGOPS_SUPPORT", 0xFFFFFFF},
    {"CR_GANGOP_MORGUE", 10},
    {"CR_GANGOP_DELUXO", 10},
    {"CR_GANGOP_SERVERFARM", 10},
    {"CR_GANGOP_IAABASE_FIN", 10},
    {"CR_GANGOP_STEALOSPREY", 10},
    {"CR_GANGOP_FOUNDRY", 10},
    {"CR_GANGOP_RIOTVAN", 10},
    {"CR_GANGOP_SUBMARINECAR", 10},
    {"CR_GANGOP_SUBMARINE_FIN", 10},
    {"CR_GANGOP_PREDATOR", 10},
    {"CR_GANGOP_BMLAUNCHER", 10},
    {"CR_GANGOP_BCCUSTOM", 10},
    {"CR_GANGOP_STEALTHTANKS", 10},
    {"CR_GANGOP_SPYPLANE", 10},
    {"CR_GANGOP_FINALE", 10},
    {"CR_GANGOP_FINALE_P2", 10},
    {"CR_GANGOP_FINALE_P3", 10},
    {"WAM_FLOW_VEHICLE_BS", -1},
    {"GANGOPS_FLOW_IMPEXP_NUM", -1}
}
local DD_AWARDS_B = {
    {"MPPLY_AWD_GANGOPS_IAA", true},
    {"MPPLY_AWD_GANGOPS_SUBMARINE", true},
    {"MPPLY_AWD_GANGOPS_MISSILE", true},
    {"MPPLY_AWD_GANGOPS_ALLINORDER", true},
    {"MPPLY_AWD_GANGOPS_LOYALTY", true},
    {"MPPLY_AWD_GANGOPS_LOYALTY2", true},
    {"MPPLY_AWD_GANGOPS_LOYALTY3", true},
    {"MPPLY_AWD_GANGOPS_CRIMMASMD", true},
    {"MPPLY_AWD_GANGOPS_CRIMMASMD2", true},
    {"MPPLY_AWD_GANGOPS_CRIMMASMD3", true}
}
    menu.add_feature(lang("解锁末日豪劫奖杯"), "action", DOOMS_HEIST.id, function()
    for i = 1, #DD_AWARDS_I do
        stat_set_int(DD_AWARDS_I[i][1], true, DD_AWARDS_I[i][2])
        stat_set_int(DD_AWARDS_I[i][1], false, DD_AWARDS_I[i][2])
    for i = 1, #DD_AWARDS_B do
        stat_set_bool(DD_AWARDS_B[i][1], true, DD_AWARDS_B[i][2])
        stat_set_bool(DD_AWARDS_B[i][1], false, DD_AWARDS_B[i][2])
    for i=0,64,1 do
        hash, mask = stats.stat_get_bool_hash_and_mask("_GANGOPSPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
        end
        end
    end
    menu.notify(lang("已解锁末日豪劫奖杯"), lang("任务脚本"), 3, 0x6400FA14)
    end)
end

do
local Apartment_AWD_B = {
    {"MPPLY_AWD_COMPLET_HEIST_MEM", true},
    {"MPPLY_AWD_COMPLET_HEIST_1STPER", true},
    {"MPPLY_AWD_FLEECA_FIN", true},
    {"MPPLY_AWD_HST_ORDER", true},
    {"MPPLY_AWD_HST_SAME_TEAM", true},
    {"MPPLY_AWD_HST_ULT_CHAL", true},
    {"MPPLY_AWD_HUMANE_FIN", true},
    {"MPPLY_AWD_PACIFIC_FIN", true},
    {"MPPLY_AWD_PRISON_FIN", true},
    {"MPPLY_AWD_SERIESA_FIN", true},
    {"AWD_FINISH_HEIST_NO_DAMAGE", true},
    {"AWD_SPLIT_HEIST_TAKE_EVENLY", true},
    {"AWD_ALL_ROLES_HEIST", true},
    {"AWD_MATCHING_OUTFIT_HEIST", true},
    {"HEIST_PLANNING_DONE_PRINT", true},
    {"HEIST_PLANNING_DONE_HELP_0", true},
    {"HEIST_PLANNING_DONE_HELP_1", true},
    {"HEIST_PRE_PLAN_DONE_HELP_0", true},
    {"HEIST_CUTS_DONE_FINALE", true},
    {"HEIST_IS_TUTORIAL", false},
    {"HEIST_STRAND_INTRO_DONE", true},
    {"HEIST_CUTS_DONE_ORNATE", true},
    {"HEIST_CUTS_DONE_PRISON", true},
    {"HEIST_CUTS_DONE_BIOLAB", true},
    {"HEIST_CUTS_DONE_NARCOTIC", true},
    {"HEIST_CUTS_DONE_TUTORIAL", true},
    {"HEIST_AWARD_DONE_PREP", true},
    {"HEIST_AWARD_BOUGHT_IN", true}
}
local Apartment_AWD_I = {
    {"AWD_FINISH_HEISTS", 900},
    {"MPPLY_WIN_GOLD_MEDAL_HEISTS", 900},
    {"AWD_DO_HEIST_AS_MEMBER", 900},
    {"AWD_DO_HEIST_AS_THE_LEADER", 900},
    {"AWD_FINISH_HEIST_SETUP_JOB", 900},
    {"AWD_FINISH_HEIST", 900},
    {"HEIST_COMPLETION", 900},
    {"HEISTS_ORGANISED", 900},
    {"AWD_CONTROL_CROWDS", 900},
    {"AWD_WIN_GOLD_MEDAL_HEISTS", 900},
    {"AWD_COMPLETE_HEIST_NOT_DIE", 900},
    {"HEIST_START", 900},
    {"HEIST_END", 900},
    {"CUTSCENE_MID_PRISON", 900},
    {"CUTSCENE_MID_HUMANE", 900},
    {"CUTSCENE_MID_NARC", 900},
    {"CUTSCENE_MID_ORNATE", 900},
    {"CR_FLEECA_PREP_1", 5000},
    {"CR_FLEECA_PREP_2", 5000},
    {"CR_FLEECA_FINALE", 5000},
    {"CR_PRISON_PLANE", 5000},
    {"CR_PRISON_BUS", 5000},
    {"CR_PRISON_STATION", 5000},
    {"CR_PRISON_UNFINISHED_BIZ", 5000},
    {"CR_PRISON_FINALE", 5000},
    {"CR_HUMANE_KEY_CODES", 5000},
    {"CR_HUMANE_ARMORDILLOS", 5000},
    {"CR_HUMANE_EMP", 5000},
    {"CR_HUMANE_VALKYRIE", 5000},
    {"CR_HUMANE_FINALE", 5000},
    {"CR_NARC_COKE", 5000},
    {"CR_NARC_TRASH_TRUCK", 5000},
    {"CR_NARC_BIKERS", 5000},
    {"CR_NARC_WEED", 5000},
    {"CR_NARC_STEAL_METH", 5000},
    {"CR_NARC_FINALE", 5000},
    {"CR_PACIFIC_TRUCKS ", 5000},
    {"CR_PACIFIC_WITSEC", 5000},
    {"CR_PACIFIC_HACK", 5000},
    {"CR_PACIFIC_BIKES", 5000},
    {"CR_PACIFIC_CONVOY", 5000},
    {"CR_PACIFIC_FINALE", 5000},
    {"MPPLY_HEIST_ACH_TRACKER", 0xFFFFFFF}
}
    menu.add_feature(lang("解锁传统抢劫奖项"), "action", CLASSIC_HEISTS.id, function()
    menu.notify(lang("- 所有成就已解锁\n\n- 所有传统抢劫已解锁\n\n切换战局或重启游戏生效"), "", 6, 0x64FF7800)
    for i = 1, #Apartment_AWD_I do
    stat_set_int(Apartment_AWD_I[i][1], true, Apartment_AWD_I[i][2])
    stat_set_int(Apartment_AWD_I[i][1], false, Apartment_AWD_I[i][2])
    for i = 1, #Apartment_AWD_B do
    stat_set_bool(Apartment_AWD_B[i][1], true, Apartment_AWD_B[i][2])
    stat_set_bool(Apartment_AWD_B[i][1], false, Apartment_AWD_B[i][2])
end
end
end)
end

do
local Apartment_SetDone = {
    {"HEIST_PLANNING_STAGE", 0xFFFFFFF}
}
    menu.add_feature(lang("完成所有前置"), "toggle", CLASSIC_HEISTS.id, function(checkin)
    menu.notify(lang("你可能需要选择一个抢劫,然后完成第一次前置\n\n请一直保持此选项激活到那个时候"), "", 7, 0x50FF78B4)
    while checkin.on do
    for i = 1, #Apartment_SetDone do
    stat_set_int(Apartment_SetDone[i][1], true, Apartment_SetDone[i][2])
    if not checkin.on then return end
    system.wait(0)
    end
end
end)
end
menu.add_feature(lang("全福(只对你生效 万)"), "value_i", CLASSIC_HEISTS.id, function(ab)
    menu.notify(lang('如果你修改超过1450万可能导致计算出错，可能导致封号等未知问题'),'Universe',12,0x6414F0FF )
    menu.notify(lang("只在你急需钱的时候使用\n\n一天使用超过5次可能引来R星邮件\n\n请保持此选项开启直到完成抢劫."), "", 12, 0x6414F0FF)
    menu.notify(lang("你必须是开启抢劫的房主\n\n在分红板上使用本选项\n\n请勿尝试更改玩家2的分红,不会对他生效的"), "", 12, 0x6414F0FF)
    ab.max,ab.min,ab.mod=5000,0,50
    while ab.on do
    script.set_global_i(1934631 + 3008 +1,7*ab.value)
    if not ab.on then return end
    system.wait(0)
    end
end)

-- CLASSIC CUT WEEKLY EVENT
menu.add_feature(lang("[双倍收入]全福(只对你生效 万)"), "value_i", CLASSIC_HEISTS.id, function(eg)
    menu.notify(lang('如果你修改超过1450万可能导致计算出错，可能导致封号等未知问题'),'Universe',12,0x6414F0FF )
    menu.notify(lang("只在你急需钱的时候使用\n\n一天使用超过5次可能引来R星邮件\n\n只能在活动激活时使用."), "", 12, 0x6414F0FF)
    menu.notify(lang("你必须是开启抢劫的房主\n\n在分红板上使用本选项\n\n请勿尝试更改玩家2的分红,不会对他生效的"), "", 12, 0x6414F0FF)
    eg.max,eg.min,eg.mod=5000,0,50
    while eg.on do
    script.set_global_i(1934631+3008+1, 3.5*eg.value)
    if not eg.on then return end
    system.wait(0)
    end
end)


------------- LS CONTRACTS
    menu.add_feature(lang("提高合约收益(100万)[只对你生效]"), "toggle", LS_ROBBERY.id, function(rob)
    menu.notify(lang("在开始合约之前务必先使此项保持开启\n\n这个选项有冷却的,如果你想开始下一场合约,需等待15-20分钟"),lang("任务脚本"), 5, 0x6400FA14)
    while rob.on do
        script.set_global_i(262145+30675+0,1000000)
        script.set_global_i(262145+30675+1,1000000)
        script.set_global_i(262145+30675+2,1000000)
        script.set_global_i(262145+30675+3,1000000)
        script.set_global_i(262145+30675+4,1000000)
        script.set_global_i(262145+30675+5,1000000)
        script.set_global_i(262145+30675+6,1000000)
        script.set_global_i(262145+30675+7,1000000)
        --script.set_global_i(292668,1000000)
        script.set_global_i(262145+30674,1000000) -- reward when joining a contract
        script.set_global_i(262145+30671,0) -- IA cut removal
    if not rob.on then return end
    system.wait(0)
    end
end)

menu.add_feature(lang("[双倍声望值和游戏币活动]提高合约收益(100万)"), "toggle", LS_ROBBERY.id, function(rob0)
    menu.notify(lang("在开始合约之前务必先使此项保持开启\n\n这个选项有冷却,如果你想开始下一场合约,需等待15-20分钟\n\n只对你自己生效!"),lang("任务脚本"), 7, 0x6400FA14)
    menu.notify(lang("注意:这个选项应该只在双倍活动事件启用时使用(双倍声望值和游戏币)!\n\n收入可能显示为 50万但实际上你将在钱包中收到100万."), "", 7, 0x6400FA14)
        while rob0.on do
        script.set_global_i(262145+30675+0,500000)
        script.set_global_i(262145+30675+1,500000)
        script.set_global_i(262145+30675+2,500000)
        script.set_global_i(262145+30675+3,500000)
        script.set_global_i(262145+30675+4,500000)
        script.set_global_i(262145+30675+5,500000)
        script.set_global_i(262145+30675+6,500000)
        script.set_global_i(262145+30675+7,500000)
        --script.set_global_i(292668,500000)
        script.set_global_i(262145+30674,500000) -- reward when joining a contract
        script.set_global_i(262145+30671,0) -- IA cut removal
    if not rob0.on then return end
    system.wait(0)
    end
end)

do
local LS_CONTRACT_0_UD = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 0}
}
    menu.add_feature(lang("联合储蓄银行合约"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_0_UD do
            menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("联合储蓄银行合约")..lang("现可游玩"), "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_0_UD[i][1], true, LS_CONTRACT_0_UD[i][2])
    end
    end)
end

do
local LS_CONTRACT_1_SD = {
    {"TUNER_GEN_BS", 4351},
    {"TUNER_CURRENT", 1}
}
    menu.add_feature(lang("大钞交易"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_1_SD do
            menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("大钞交易")..lang("现可游玩"), "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_1_SD[i][1], true, LS_CONTRACT_1_SD[i][2])
    end
    end)
end

do
local LS_CONTRACT_2_BC = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 2}
}
    menu.add_feature(lang("银行合约"), "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_2_BC do
    menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("银行合约")..lang("现可游玩"), "", 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_2_BC[i][1], true, LS_CONTRACT_2_BC[i][2])
    end
    end)
end

do
local LS_CONTRACT_3_ECU = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 3}
}
    menu.add_feature(lang("电控单元合约"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_3_ECU do
        menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("电控单元合约")..lang("现可游玩"), "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_3_ECU[i][1], true, LS_CONTRACT_3_ECU[i][2])
    end
    end)
end

do
local LS_CONTRACT_4_PRSN = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 4}
} 
    menu.add_feature(lang("监狱合约"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_4_PRSN do
        menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("监狱合约")..lang("现可游玩"), "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_4_PRSN[i][1], true, LS_CONTRACT_4_PRSN[i][2])
    end
    end)
end

do
local LS_CONTRACT_5_AGC = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 5}
}
    menu.add_feature(lang("IAA交易"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_5_AGC do
        menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("IAA交易")..lang("现可游玩"), "", 6, 0x64F06414)
        stat_set_int(LS_CONTRACT_5_AGC[i][1], true, LS_CONTRACT_5_AGC[i][2])
    end
    end)
end

do
local LS_CONTRACT_6_LOST = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 6}
}
    menu.add_feature(lang("失落摩托帮合约"), "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_6_LOST do
    menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("失落摩托帮合约")..lang("现可游玩"), "", 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_6_LOST[i][1], true, LS_CONTRACT_6_LOST[i][2])
    end
    end)
end

do
local LS_CONTRACT_7_DATA = {
    {"TUNER_GEN_BS", 12543},
    {"TUNER_CURRENT", 7}
}
    menu.add_feature(lang("数据合约"), "action", LS_ROBBERY.id, function()
        for i = 1, #LS_CONTRACT_7_DATA do
        menu.notify(lang("当你处于你的改装店外时,此选项生效!").."\n\n\n"..lang("数据合约")..lang("现可游玩"), "", 6, 0x64F06414)
        menu.notify(lang("忽略NPC之间的一些对话会使你无法得到报酬,请勿频繁跳过!"), lang("任务脚本"), 6, 0x6414F0FF)
        stat_set_int(LS_CONTRACT_7_DATA[i][1], true, LS_CONTRACT_7_DATA[i][2])
    end
    end)
end

do
local LS_CONTRACT_MSS_ONLY = {
    {"TUNER_GEN_BS", 0xFFFFFFF}
}
    menu.add_feature(lang("完成所有前置"), "action", LS_ROBBERY.id, function()
    for i = 1, #LS_CONTRACT_MSS_ONLY do
    menu.notify(lang("当你处于你的改装店外时,此选项生效\n\n前置已完成"),lang("任务脚本"), 6, 0x64F06414)
    stat_set_int(LS_CONTRACT_MSS_ONLY[i][1], true, LS_CONTRACT_MSS_ONLY[i][2])
    end
    end)
end

do
local LS_TUNERS_DLC_BL = {
    {"AWD_CAR_CLUB", true},
    {"AWD_PRO_CAR_EXPORT", true},
    {"AWD_UNION_DEPOSITORY", true},
    {"AWD_MILITARY_CONVOY", true},
    {"AWD_FLEECA_BANK", true},
    {"AWD_FREIGHT_TRAIN", true},
    {"AWD_BOLINGBROKE_ASS", true},
    {"AWD_IAA_RAID", true},
    {"AWD_METH_JOB", true},
    {"AWD_BUNKER_RAID", true},
    {"AWD_STRAIGHT_TO_VIDEO", true},
    {"AWD_MONKEY_C_MONKEY_DO", true},
    {"AWD_TRAINED_TO_KILL", true},
    {"AWD_DIRECTOR", true}
}
local LS_TUNERS_DLC_IT = {
    {"AWD_CAR_CLUB_MEM", 100},
    {"AWD_SPRINTRACER", 50},
    {"AWD_STREETRACER", 50},
    {"AWD_PURSUITRACER", 50},
    {"AWD_TEST_CAR", 240},
    {"AWD_AUTO_SHOP", 50},
    {"AWD_CAR_EXPORT", 100},
    {"AWD_GROUNDWORK", 40},
    {"AWD_ROBBERY_CONTRACT", 100},
    {"AWD_FACES_OF_DEATH", 100}
}
menu.add_feature(lang("解锁所有车友会奖励"), "action", LS_ROBBERY.id, function()
    for i = 1, #LS_TUNERS_DLC_IT do
        stat_set_int(LS_TUNERS_DLC_IT[i][1], true, LS_TUNERS_DLC_IT[i][2])
    end
    for i = 2, #LS_TUNERS_DLC_BL do
        stat_set_bool(LS_TUNERS_DLC_BL[i][1], true, LS_TUNERS_DLC_BL[i][2])
    end
    for i=0,576,1 do
        hash, mask = stats.stat_get_bool_hash_and_mask("_TUNERPSTAT_BOOL", i, CharID)
        stats.stat_set_masked_bool(hash, true, mask, 1, true)
    end
    script.set_global_i(262145+30817, 1)
    menu.notify(lang("已解锁"), "", 3, 0x50FF78F0)
end)
end

local ROBBERY_RESETER = menu.add_feature(lang("更多选项"), "parent", LS_ROBBERY.id)

do
local LS_CONTRACT_MISSION_RST = {
    {"TUNER_GEN_BS", 12467}
}
menu.add_feature(lang("重置前置任务"), "action", ROBBERY_RESETER.id, function()
    for i = 1, #LS_CONTRACT_MISSION_RST do
        menu.notify(lang("当你处于你的改装店外时,此选项生效\n\n前置任务已重置"),lang("任务脚本"), 3, 0x64F06414)
    stat_set_int(LS_CONTRACT_MISSION_RST[i][1], true, LS_CONTRACT_MISSION_RST[i][2])
    end
    end)
end

do
local LS_CONTRACT_RST = {
    {"TUNER_GEN_BS", 8371},
    {"TUNER_CURRENT", 0xFFFFFFF},
}
menu.add_feature(lang("重置合约"), "action", ROBBERY_RESETER.id, function()
    for i = 1, #LS_CONTRACT_RST do
    menu.notify(lang("当你处于你的改装店外时,此选项生效\n\n合约已重置"),lang("任务脚本"), 3, 0x64F06414)
    stat_set_int(LS_CONTRACT_RST[i][1], true, LS_CONTRACT_RST[i][2])
end
end)
end

do
local RST_COUNT_TNR = {
    {"TUNER_COUNT", 0},
    {"TUNER_EARNINGS", 0}
}
    menu.add_feature(lang("重置总收益&已完成的任务"), "action", ROBBERY_RESETER.id, function()
    for i = 1, #RST_COUNT_TNR do
    menu.notify(lang("仅当你在改车铺外时生效\n\n数据已重置"), "", 4, 0x64FF7878)
    stat_set_int(RST_COUNT_TNR[i][1], true, RST_COUNT_TNR[i][2])
    end
end)
end

-- THE CONTRACT DLC

local CONTRACT_MANAGER = menu.add_feature(lang("合约:德瑞博士"), "parent", TH_CONTRACT.id, function()
    menu.notify(lang("你必须注销才能正确更新数据"))
end)
local CONTRACT_MANAGER_ = menu.add_feature(lang("夜生活泄密"), "parent", CONTRACT_MANAGER.id)
local CONTRACT_MANAGER__ = menu.add_feature(lang("上流社会泄密"), "parent", CONTRACT_MANAGER.id)
local CONTRACT_MANAGER___ = menu.add_feature(lang("南中心区泄密"), "parent", CONTRACT_MANAGER.id)

do 
 local LEAK_NIGHTCLUB = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 3},
    {"FIXER_STORY_COOLDOWN", -1}
}
    
menu.add_feature(lang("夜总会(前置)"), "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_NIGHTCLUB do
        stat_set_int(LEAK_NIGHTCLUB[i][1], true, LEAK_NIGHTCLUB[i][2])
        end
    menu.notify(lang("已选择")..lang("夜总会(前置)"))
    end)
end

do 
local LEAK_MARINA = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 4},
    {"FIXER_STORY_COOLDOWN", -1}
}
       
menu.add_feature(lang("码头(前置)"), "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_MARINA do
        stat_set_int(LEAK_MARINA[i][1], true, LEAK_MARINA[i][2])
        end
    menu.notify(lang("已选择")..lang("码头(前置)"))
    end)
end

do 
local LEAK_NIGHTLIFE = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", 12},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature(lang("夜生活泄密(任务)"), "action", CONTRACT_MANAGER_.id, function()
    for i = 1, #LEAK_NIGHTLIFE do
        stat_set_int(LEAK_NIGHTLIFE[i][1], true, LEAK_NIGHTLIFE[i][2])
        end
        menu.notify(lang("已选择")..lang("夜生活泄密(任务)"))
end)
end

do 
local LEAK_COUNTRYCLUB = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 28},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature(lang("乡村俱乐部(前置)"), "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_COUNTRYCLUB do
        stat_set_int(LEAK_COUNTRYCLUB[i][1], true, LEAK_COUNTRYCLUB[i][2])
        end
        menu.notify(lang("已选择")..lang("乡村俱乐部(前置)"))
end)
end

do 
local LEAK_GUESTLIST = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 60},
    {"FIXER_STORY_COOLDOWN", -1}
}
    
menu.add_feature(lang("宾客名单(前置)"), "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_GUESTLIST do
        stat_set_int(LEAK_GUESTLIST[i][1], true, LEAK_GUESTLIST[i][2])
    end
    menu.notify(lang("已选择")..lang("宾客名单(前置)"))
end)
end

do 
local LEAK_HIGHSOCIETY = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 124},
    {"FIXER_STORY_COOLDOWN", -1}
}
        
menu.add_feature(lang("上流社会泄密(任务)"), "action", CONTRACT_MANAGER__.id, function()
    for i = 1, #LEAK_HIGHSOCIETY do
        stat_set_int(LEAK_HIGHSOCIETY[i][1], true, LEAK_HIGHSOCIETY[i][2])
    end
    menu.notify(lang("已选择")..lang("上流社会泄密(任务)"))
end)
end

do 
local LEAK_DAVIS = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 252},
    {"FIXER_STORY_COOLDOWN", -1}
}
            
menu.add_feature(lang("戴维斯(前置)"), "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_DAVIS do
        stat_set_int(LEAK_DAVIS[i][1], true, LEAK_DAVIS[i][2])
    end
    menu.notify(lang("已选择")..lang("戴维斯(前置)"))
end)
end

do 
local LEAK_BALLAS = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 508},
    {"FIXER_STORY_COOLDOWN", -1}
}
                
menu.add_feature(lang("巴拉斯帮会(前置)"), "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_BALLAS do
        stat_set_int(LEAK_BALLAS[i][1], true, LEAK_BALLAS[i][2])
    end
    menu.notify(lang("已选择")..lang("巴拉斯帮会(前置)"))
end)
end

do 
local LEAK_STUDIO = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 2044},
    {"FIXER_STORY_COOLDOWN", -1}
}
                        
menu.add_feature(lang("代理工作室(任务)"), "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_STUDIO do
        stat_set_int(LEAK_STUDIO[i][1], true, LEAK_STUDIO[i][2])
    end
    menu.notify(lang("已选择")..lang("代理工作室(任务)\n\n请离开公寓或更换战局以生效"))
end)
end

do 
local LEAK_FINAL = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_STRAND", -1},
    {"FIXER_STORY_BS", 4092},
    {"FIXER_STORY_COOLDOWN", -1}
}
                    
menu.add_feature(lang("最终合约 :Don't Fuck with Dre"), "action", CONTRACT_MANAGER___.id, function()
    for i = 1, #LEAK_FINAL do
        stat_set_int(LEAK_FINAL[i][1], true, LEAK_FINAL[i][2])
    end
    menu.notify(lang("已选择")..lang("最终合约\n\n请离开公寓或更换战局以生效"))
end)
end

menu.add_feature(lang("修改最终合约收入(240万|只对你生效)"), "toggle", TH_CONTRACT.id, function(TH_)
    while TH_.on do
        script.set_global_i(262145+31373,2400000)
    if not TH_.on then return end
    system.wait(0)
    end
end)

menu.add_feature(lang("[1.5倍收入事件]修改最终合约收入(240万|只对你生效)"), "toggle", TH_CONTRACT.id, function(TH_0)
    menu.notify(lang("仅在双倍收入活动激活时使用."), "", 4, 0x50F05014)
    while TH_0.on do
        script.set_global_i(262145+31373,1600000)
    if not TH_0.on then return end
    system.wait(0)
    end
end)

menu.add_feature(lang("移除安保任务冷却时间"), "toggle", TH_CONTRACT.id, function(CNT_CL0)
    while CNT_CL0.on do
        script.set_global_i(262145+31329,0)
    if not CNT_CL0.on then return end
    system.wait(0)
    end
end)

menu.add_feature(lang("暂时解锁即将推出的车辆"), "toggle", TH_CONTRACT.id, function(_T)
    menu.notify(lang("购买的车辆将在你的车库中,直到你决定出售它们\n\n请保持此选项开启以在任务中使用未放出的车辆.\n\n如果您停用该选项,车辆将不可见,直到Rockstar正式发布更新.\n\n无封号风险!"))
    menu.notify(lang("车辆可在汽车商店购买."))
    while _T.on do
    script.set_global_i(262145+31481,1)
    script.set_global_i(262145+31480,1)
    script.set_global_i(262145+31479,1)
    script.set_global_i(262145+31478,1)
    script.set_global_i(262145+31477,1)
    script.set_global_i(262145+31476,1)
    script.set_global_i(262145+31475,1)
    script.set_global_i(262145+31474,1)
    if not _T.on then return end
    system.wait(0)
end
end)

do
local CONTRACT_COMPLETE = {
    {"FIXER_GENERAL_BS", -1},
    {"FIXER_COMPLETED_BS", -1},
    {"FIXER_STORY_BS", -1},
    {"FIXER_STORY_COOLDOWN", -1}
}

menu.add_feature(lang("完成所有任务"), "action", TH_CONTRACT.id, function()
    for i = 1, #CONTRACT_COMPLETE do
        stat_set_int(CONTRACT_COMPLETE[i][1], true, CONTRACT_COMPLETE[i][2])
        end
        menu.notify(lang("所有任务已完成"))
end)
end

do
local TH_AWARDS_I = {
    {"AWD_CONTRACTOR", 50},
    {"AWD_COLD_CALLER", 50},
    {"AWD_PRODUCER", 60},
    {"FIXERTELEPHONEHITSCOMPL", 10},
    {"PAYPHONE_BONUS_KILL_METHOD", 10},
    {"FIXER_COUNT", 501},
    {"FIXER_SC_VEH_RECOVERED", 501},
    {"FIXER_SC_VAL_RECOVERED", 501},
    {"FIXER_SC_GANG_TERMINATED", 501},
    {"FIXER_SC_VIP_RESCUED", 501},
    {"FIXER_SC_ASSETS_PROTECTED", 501},
    {"FIXER_SC_EQ_DESTROYED", 501},
    {"FIXER_EARNINGS", 300000}

}
local TH_AWARDS_B = {
    {"AWD_TEEING_OFF", true},
    {"AWD_PARTY_NIGHT", true},
    {"AWD_BILLIONAIRE_GAMES", true},
    {"AWD_HOOD_PASS", true},
    {"AWD_STUDIO_TOUR", true},
    {"AWD_DONT_MESS_DRE", true},
    {"AWD_BACKUP", true},
    {"AWD_SHORTFRANK_1", true},
    {"AWD_SHORTFRANK_2", true},
    {"AWD_SHORTFRANK_3", true},
    {"AWD_CONTR_KILLER", true},
    {"AWD_DOGS_BEST_FRIEND", true},
    {"AWD_MUSIC_STUDIO", true},
    {"AWD_SHORTLAMAR_1", true},
    {"AWD_SHORTLAMAR_2", true},
    {"AWD_SHORTLAMAR_3", true}
}

menu.add_feature(lang("解锁奖励&衣服"), "action", TH_CONTRACT.id, function()
        local BL0 = gameplay.get_hash_key(PlayerMP.."_FIXERPSTAT_BOOL0")
        local BL1 = gameplay.get_hash_key(PlayerMP.."_FIXERPSTAT_BOOL1")
        for i=0,128,1 do
            stats.stat_set_masked_bool(BL0, true, i, 1, true) -- True
            stats.stat_set_masked_bool(BL1, true, i, 1, true) -- True
        end
        for i = 1, #TH_AWARDS_I do
            stat_set_int(TH_AWARDS_I[i][1], true, TH_AWARDS_I[i][2])
            end
        for i = 1, #TH_AWARDS_B do
            stat_set_bool(TH_AWARDS_B[i][1], true, TH_AWARDS_B[i][2])
            end
        menu.notify(lang("Done!"))
    end)
end


-- mission_cheat

-- Vehicle Speed From Zeromenu (Credits for him)

menu.add_feature(lang("在非公开战局中启用任务"), "toggle", mission_cheat.id, function(_mi)
    while _mi.on do
    script.set_global_i(2714627+744, 0) -- NETWORK::NETWORK_SESSION_GET_PRIVATE_SLOTS
    if not _mi.on then return end
    system.wait(0)
    end
    menu.notify(lang("现可在非公开战局游玩任务"))
end)

do
menu.add_feature(lang("离开此战局(会卡住几秒钟)"), "action", mission_cheat.id, function()  
    local time = utils.time_ms() + 8500
    while time > utils.time_ms() do end
    menu.notify(lang("已完成"), lang("任务脚本"), 3, 0x64FF78F0)
end)
end

local HU_JING_TELE = menu.add_feature(lang("虎鲸内传送点"), "parent", TELEP_CZM.id)
menu.add_feature(lang("驾驶位"), "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1560.303, 381.718, -49.685))
end)
menu.add_feature(lang("导弹控制位"), "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1559.726, 388.009, -49.685))
end)
menu.add_feature(lang("麻雀停机坪"), "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1563.830, 409.712, -49.667))
end)
menu.add_feature(lang("床"), "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1558.518, 383.137, -53.284))
end)
menu.add_feature(lang("武器工作室"), "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1561.609, 381.089, -56.088))
end)
menu.add_feature(lang("出口").."1", "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1563.479, 371.470, -49.685))
end)
menu.add_feature(lang("出口").."2", "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1561.433, 391.197, -49.685))
end)
menu.add_feature(lang("出口").."3", "action", HU_JING_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(1564.593, 447.083, -53.129))
end)
local LSC_DLC_TELE = menu.add_feature(lang("洛圣都车友会"), "parent", TELEP_CZM.id)
menu.add_feature(lang("车友会入口"), "action", LSC_DLC_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(782.597, -1867.812, 29.253))
end)
menu.add_feature(lang("车友会内"), "action", LSC_DLC_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(-2148.729, 1137.968, -24.371))
end)
menu.add_feature(lang("测试跑道"), "action", LSC_DLC_TELE.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(-2025.252, 1115.701, -27.761))
end)
local LSC_BANG = menu.add_feature(lang("媒体记忆棒"), "parent", LSC_DLC_TELE.id)
menu.add_feature(lang("赌场楼顶露台"), "action", LSC_BANG.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(955.550, 50.059, 112.553))
end)
menu.add_feature(lang("车友会角落"), "action", LSC_BANG.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(-2172.616, 1159.674, -24.372))
end)
menu.add_feature(lang("夜总会办公室内"), "action", LSC_BANG.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(-1619.068, -3010.602, -75.205))
end)
menu.add_feature(lang("游戏厅吧台"), "action", LSC_BANG.id, function()
	pedmy = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(pedmy,v3(2727.082, -387.540, -48.993))
end)
local UKN_KBBL_TELE = menu.add_feature(lang("Kenny's Backyard Boogie")..lang("专辑所在地"), "parent", TELEP_CZM.id)
menu.add_feature(lang("Kenny's Backyard Boogie-#1"), "action", UKN_KBBL_TELE.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-2163.025, 1083.473, -24.362))
end)
menu.add_feature(lang("Kenny's Backyard Boogie-#2"), "action", UKN_KBBL_TELE.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-2180.532, 1082.276, -24.367))
end)
menu.add_feature(lang("Kenny's Backyard Boogie-#3"), "action", UKN_KBBL_TELE.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-2162.992, 1089.790, -24.363))
end)
menu.add_feature(lang("Kenny's Backyard Boogie-#4"), "action", UKN_KBBL_TELE.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-2162.770, 1115.913, -24.371))
end)
local UKN_HELPSRKL = menu.add_feature(lang("连环杀手"), "parent", TELEP_CZM.id)
menu.add_feature(lang("线索1-血手印"), "action", UKN_HELPSRKL.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-678.9984, 5797.6851, 17.3309))
end)
menu.add_feature(lang("线索2-砍刀"), "action", UKN_HELPSRKL.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1901.4042, 4911.5479, 48.6951))
end)
menu.add_feature(lang("线索3-断手"), "action", UKN_HELPSRKL.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1111.7750, 3142.0457, 38.4241))
end)
menu.add_feature(lang("线索4-信件"), "action", UKN_HELPSRKL.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-136.5509, 1912.8038, 197.2982))
end)

local UKN_HELPSRKLC = menu.add_feature(lang("线索5-多位置"), "parent", UKN_HELPSRKL.id)
menu.add_feature(lang("线索5-黑色面包车").."(1)", "action", UKN_HELPSRKLC.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(2576.0391, 1251.7494, 43.6099))
    menu.notify(lang("洛圣都杀人狂将在晚上7点到凌晨5点出现,杀死他!(50,000美金奖励)"), lang("任务脚本"), 4, 257818)
end)
menu.add_feature(lang("线索5-黑色面包车").."(2)", "action", UKN_HELPSRKLC.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(2903.4150, 3644.0413, 43.8774))
    menu.notify(lang("洛圣都杀人狂将在晚上7点到凌晨5点出现,杀死他!(50,000美金奖励)"), lang("任务脚本"), 4, 257818)
end)
menu.add_feature(lang("线索5-黑色面包车").."(3)", "action", UKN_HELPSRKLC.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(2432.3904, 5846.0757, 58.8891))
    menu.notify(lang("洛圣都杀人狂将在晚上7点到凌晨5点出现,杀死他!(50,000美金奖励)"), lang("任务脚本"), 4, 257818)
end)
menu.add_feature(lang("线索5-黑色面包车").."(4)", "action", UKN_HELPSRKLC.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1567.880, 4424.6104, 7.2154))
    menu.notify(lang("洛圣都杀人狂将在晚上7点到凌晨5点出现,杀死他!(50,000美金奖励)"), lang("任务脚本"), 4, 257818)
end)
menu.add_feature(lang("线索5-黑色面包车").."(5)", "action", UKN_HELPSRKLC.id, function()
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-1715.793, 2618.7686, 2.9409))
    menu.notify(lang("洛圣都杀人狂将在晚上7点到凌晨5点出现,杀死他!(50,000美金奖励)"), lang("任务脚本"), 4, 257818)
end)






----------------------------抢劫-------------------------






