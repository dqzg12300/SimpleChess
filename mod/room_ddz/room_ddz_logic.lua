---
--- 房间逻辑部分
--- Created by admin.
--- DateTime: 2018/9/12 16:01
---
local tablex=require "pl.tablex"

local ROOM={}
local players={}

function ROOM.init()
    --这里初始化数据
end

function ROOM.is_table_full()
    return tablex.size(players)>=3
end

function ROOM.enter(data)
    local uid=data.uid
    players[uid]=data
    log.debug("logic enter_room play size:%d",tablex.size(players))
    return SYSTEM_ERROR.success
end

function ROOM.leave(uid)
    if not uid then
        log.debug("logic leave_room uid is nil")
        return DESK_ERROR.room_not_uid
    end
    players[uid]=nil
    log.debug("logic enter_room play size:%d",tablex.size(players))
    return SYSTEM_ERROR.success
end

return ROOM