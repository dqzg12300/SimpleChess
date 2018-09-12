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
    skynet.call(addr,"lua","start")
    ROOM_MAP[room_id]=addr
    local ret={result=0,room_id=room_id}
    return ret
end

function dispatch.enter_room(room_id,uid)

end

function dispatch.leave_room(room_id,uid)

end
