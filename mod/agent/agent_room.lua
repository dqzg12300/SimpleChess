---
--- 处理客户端进房逻辑部分
--- Created by Administrator.
--- DateTime: 2018/9/2 20:06
---

local skynet=require "skynet"
local log=require "log"
local env=require "faci.env"
local runconfig=require(skynet.getenv("runconfig"))
local games_common=runconfig.games_common

local M=env.dispatch
local libmodules={}
local function init_modules()
    setmetatable(libmodules, {
        __index = function(t, k)
            local mod = games_common[k]
            if not mod then
                return nil
            end
            local v = require(mod)
            t[k] = v
            return v
        end
    })
end
init_modules()

local function cal_lib(game)
    return assert(libmodules[game])
end

local room_id=nil
local lib=nil

--创建房间逻辑
function M.create_room(msg)
    INFO("agent create_room")
    if lib or room_id then
        --踢出房间
    end
    lib=cal_lib(msg.game)
    return lib.create_room()
end

--进入房间逻辑
function M.enter_room(msg)
    INFO("agent enter_room")
    if room_id then
        --踢出房间
    end
    lib=cal_lib(msg.game)
    local uid=env.get_player().uid
    local ret=lib.enter_room(msg.room_id,uid)
    if ret.result then
        room_id=ret.room_id
    end
    return ret
end

--离开房间逻辑
function M.leave_room(msg)
    INFO("agent leave_room")
    if not lib then
        INFO("leave_room not found lib")
        return {result=0}
    end
    if not room_id then
        INFO("leave_room not found room_id")
        return {result=0}
    end
    local uid=env.get_player().uid
    return lib.leave_room(room_id,uid)
end

--踢出房间逻辑
function M.kick_room()
    return M.leave_room()
end
