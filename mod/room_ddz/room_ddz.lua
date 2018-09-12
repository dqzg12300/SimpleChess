---
--- 斗地主的桌子逻辑处理
--- Created by admin.
--- DateTime: 2018/9/12 15:23
---

local skynet=require "skynet"
local faci=require "faci.module"
local module=faci.get_module("room_ddz")
local dispatch=module.dispatch
local ROOM=require "room_ddz.room_ddz_logic"

function dispatch.start()
    ROOM.init()
end

function dispatch.enter(room_id,uid)
    if ROOM.get_player_count()>ROOM.get_max_count() then
        log.debug("room_enter player count full")
        return false
    end
    return ROOM.enter(room_id,uid)
end

function dispatch.leave(room_id,uid)
    return ROOM.leave(room_id,uid)
end