---
--- 斗地主的场景逻辑
--- Created by admin.
--- DateTime: 2018/9/12 11:56
---
local skynet=require "skynet"
local faci=require "faci.module"
local libdbproxy=require "libdbproxy"
local module=faci.get_module("scene_ddz")
local dispatch=module.dispatch

--key id,value addr
local ROOM_MAP={}

function dispatch.create_room()
    local room_id=libdbproxy.inc_room()
    local addr=skynet.newservice("room_ddz","room_ddz",room_id)
    ROOM_MAP[room_id]=addr
    skynet.call(addr,"lua","room_ddz.start")
    INFO("scene_ddz create_room room_id:"..room_id)
    return room_id
end

function dispatch.enter_room(room_id,data)
    INFO("scene_ddz enter_room")
    local addr=ROOM_MAP[room_id]
    if not addr then
        log.debug("enter_room not found room_id:%d",room_id)
        return DESK_ERROR.room_not_found
    end
    return skynet.call(addr,"lua","room_ddz.enter",data)
end

function dispatch.leave_room(room_id,uid)
    INFO("scene_ddz leave_room")
    local addr=ROOM_MAP[room_id]
    if not addr then
        log.debug("enter_room not found room_id:%d",room_id)
        return DESK_ERROR.room_not_found
    end
    return skynet.call(addr,"lua","room_ddz.leave",uid)
end
