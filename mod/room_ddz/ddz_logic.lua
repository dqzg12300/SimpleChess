---
--- 斗地主逻辑
--- Created by admin.
--- DateTime: 2018/9/17 11:49
---

local DDZ=class("DDZ")
local machine=require "statemachine"
local timer=require "timer"
--状态机
local fsm=nil

function DDZ:init_game()
    --这里初始化数据
    fsm=machine.create({
        initial="none",
        events={},
        callbacks={},
    })
end

function DDZ:init_status()
    fsm:none()
end

function DDZ:start()
    
end

return DDZ