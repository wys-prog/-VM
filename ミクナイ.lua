local _p = print
print = function (...)
  _p('ミクナイVM:', ...)
end

print('booting...')

local log = {
  file = 'ミクナイ.log',
  ---@type file*
  handle = nil
}

function log.log(...)
  log.handle:write('ミクナイ.', os.time(), ': ', ...)
end

local system = {
  down = false,
}

while not system.down do
  
end