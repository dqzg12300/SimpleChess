---
--- 登陆并创建桌子的例子
--- Created by admin.
--- DateTime: 2018/9/13 12:18
---

local client=require "tcpclient"

local Hander={}

function login_loginResult(msg)
    if msg.result==0 then
        print("account:"..msg.username.." success")
        client.create_room("ddz")
    else
        print("account:"..msg.username..",login err:",msg.result)
    end

end

function create_roomResult(msg)
    print("room_id:"..msg.room_id.." result:"..msg.result)
end

function Hander.CallBack(cmd,check,msg)
    funcname=string.gsub(cmd,"%.","_")
    if _G[funcname] then
        _G[funcname](msg)
    end
end

client.init("127.0.0.1",11200,Hander)
client.login("king","111111")
client.start()


