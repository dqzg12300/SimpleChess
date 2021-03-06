---
--- 斗地主逻辑,在handler中写游戏的逻辑部分.用fsm状态机关联起来。然后切换状态就好了
--- Created by admin.
--- DateTime: 2018/9/17 11:49
---

local M = {}
local machine=require "statemachine"
local timer=require "timer"
--状态机
local fsm=nil
local handler={}
local t=nil
local tidx=nil

function M.init_game()
    t=timer:new()
    t:init()
    --这里初始化状态机
    fsm=machine.create({
        initial="none",
        events={
            {name="start",from="none",to="init_data"},
        },
        callbacks={
            onstart=handler.onstart,
        },
    })
end

--游戏开始初始化数据
function handler.onstart()
    INFO("game start")
end

function M.init_status()
    fsm:none()
end

function M.start()
    INFO("game full,pre start")
    tidx=t:register(3,function()
        fsm:start()
    end)
end

return M