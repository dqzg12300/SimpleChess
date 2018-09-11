---
--- 处理客户端进房逻辑部分
--- Created by Administrator.
--- DateTime: 2018/9/2 20:06
---

local skynet=require "skynet"
local log=require "log"
local env=require "faci.env"

local M=env.dispatch

--创建房间逻辑
function M.create_room(msg)
    log.debug("create_room")
end

--进入房间逻辑
function M.enter_room(msg)
    log.debug("enter_room")
end

--离开房间逻辑
function M.leave_room(msg)
    log.debug("leave_room")
end

--踢出房间逻辑
function M.kick_room(msg)
    log.debug("kick_room")
end
