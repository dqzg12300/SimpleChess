local skynet = require "skynet"
local json = require "cjson"
local log = require "log"

local M = {}

function M.pack(cmd, msg)
    msg._cmd = cmd
    local str = json.encode(msg)
    return str
end

function M.unpack(str)
    local isok, t = pcall(json.decode, str)
    if not isok then
        log.error(string.format("unpack error, msg: %s", str))
        return
    end
    return t._cmd, t
end

json.encode_sparse_array(true) 

return M


