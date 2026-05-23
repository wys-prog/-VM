---@class proc
---@field pid string
---@field user string
---@field emod string
---@field begin integer
local proc = {}
proc.__index = proc

local pcid = 0
local mkid = function()
  pcid = pcid + 1
  return tostring(pcid) .. '-' .. os.time()
end

function proc:notify(notification) end
function proc:update()end
---@return integer|nil
function proc:unmount() return 0 end
function proc:mount() return true end

function proc.new(user, emod, ...)
  return setmetatable({
    pid = mkid(),
    user = user,
    emod = emod,
    begin = os.time(),
    ...
  }, proc)
end

return proc