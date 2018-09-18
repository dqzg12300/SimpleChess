---
--- 房间逻辑部分
--- Created by admin.
--- DateTime: 2018/9/12 16:01
---
local tablex=require "pl.tablex"
local libcenter=require "libcenter"
local ROOM=require "room_ddz.ddz_logic"

function ROOM:init()
    self._players={}
    self:init_game()
end

function ROOM:is_table_full()
    return tablex.size(players)>=3
end

function ROOM:broadcast(msg,filterUid)
    DEBUG("broadcast")
    for k,v in pairs(players) do
        if not filterUid or filterUid~=k then
            libcenter.send2client(k,msg)
        end
    end
end

local function get_usersdata()
    local data={}
    for k,v in pairs(players) do
        local pd={
            uid=v.uid,
            username=v.account,
        }
        table.insert(data,pd)
    end
    return data
end

function ROOM:enter(data)
    local uid=data.uid
    players[uid]=data
    local data=get_usersdata()
    ROOM.broadcast({_cmd="room.flush_userdataNty",data=data})
    if is_table_full() then
        --启动游戏
        self:start()
    end
    log.debug("logic enter_room play size:%d",tablex.size(players))
    return SYSTEM_ERROR.success
end

function ROOM:leave(uid)
    if not uid then
        log.debug("logic leave_room uid is nil")
        return DESK_ERROR.room_not_uid
    end
    players[uid]=nil
    log.debug("logic enter_room play size:%d",tablex.size(players))
    return SYSTEM_ERROR.success
end

return ROOM