local proc = require('proc')
local socket = require('socket')
local system = {
  ---@type table<string, proc[]>
  groups = {},
  ---@type proc[]
  processes = {},
  frametime = 0.0008,
}

function system.warn(...)
  print('[system.warning:' .. os.date() .. ']', ...)
end

---calls a function without propagating error. (ts tuff)
---@param f function
---@param ... any?
function system.prun(f, ...)
  xpcall(f, function (...)
    system.warn('error(s) when calling function ' .. tostring(f), ...)
    system.warn(debug.traceback('traceback:\n'))
  end, ...)
end

function system.send(group, notification)
  if not system.groups[group] then
    system.warn('group not found', group)
  else
    for index, value in pairs(system.groups) do
      if value then
        system.prun(value.notify, value, notification)
      else
        system.groups[index] = nil
      end
    end
  end
end

function system.update(delta)
  print(delta)
  for index, value in ipairs(system.processes) do
    if value then
      system.prun(value.update, value)
    else
      table.remove(system.processes, index)
    end
  end
end

local t0 = os.clock()

while true do
  local t1 = os.clock()
  local delta = t1 - t0
  t0 = t1

  local upstart = os.clock()
  system.update(delta)
  local updatetime = os.clock() - upstart

  socket.sleep(math.max(0, system.frametime - updatetime))
end