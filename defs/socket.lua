---@meta

--========================================================
-- LuaSocket EmmyLua / LuaLS Definitions
--========================================================

---@class socket
socket = {}

--========================================================
-- Constants
--========================================================

---@type integer
socket._DATAGRAMSIZE = 8192

---@type boolean
socket._DEBUG = false

---@type integer
socket._SETSIZE = 1024

---@type integer
socket._SOCKETINVALID = -1

---@type string
socket._VERSION = "LuaSocket x.x.x"

--========================================================
-- DNS
--========================================================

---@class socket.dns
socket.dns = {}

---@class socket.addrinfo
---@field family '"inet"'|'"inet6"'
---@field addr string
---@field port integer
---@field socktype string
---@field protocol string
---@field canonname? string

---Resolves host/service to address info.
---@param host string
---@param service? string|integer
---@return socket.addrinfo[]|nil info
---@return string? err
function socket.dns.getaddrinfo(host, service) end

---Returns local hostname.
---@return string hostname
function socket.dns.gethostname() end

---Resolves hostname to IP address.
---@param hostname string
---@return string ip
function socket.dns.toip(hostname) end

---Resolves IP address to hostname.
---@param address string
---@return string hostname
function socket.dns.tohostname(address) end

--========================================================
-- Utility Functions
--========================================================

---Returns current Unix timestamp with millisecond precision.
---@return number time
function socket.gettime() end

---Sleeps for a number of seconds.
---@param seconds number
function socket.sleep(seconds) end

---Waits for sockets to become ready.
---@param recvt socket.tcp[]|socket.udp[]
---@param sendt socket.tcp[]|socket.udp[]
---@param timeout? number
---@return table readable
---@return table writable
---@return string? err
function socket.select(recvt, sendt, timeout) end

---Skips return values.
---@param count integer
---@vararg any
---@return ...
function socket.skip(count, ...) end

---Protected call helper.
---@generic T
---@param func fun(...):T
---@return fun(...):T
function socket.protect(func) end

---Error handling helper.
---@param finalizer fun():nil
---@return fun(cond:any, err?:string):any
function socket.newtry(finalizer) end

---Raises error if condition fails.
---@param cond any
---@param err? string
---@return any
function socket.try(cond, err) end

--========================================================
-- TCP
--========================================================

---@class socket.tcp
local TCPBase = {}

---Closes the socket.
---@return boolean|nil success
---@return string? err
function TCPBase:close() end

---Returns whether there is unread buffered data.
---@return boolean
function TCPBase:dirty() end

---Returns underlying file descriptor.
---@return integer fd
function TCPBase:getfd() end

---Gets local socket name.
---@return string ip
---@return integer port
---@return '"inet"'|'"inet6"' family
function TCPBase:getsockname() end

---Returns transfer statistics.
---@return integer received
---@return integer sent
---@return number age
function TCPBase:getstats() end

---Gets timeout configuration.
---@return number|nil block
---@return number|nil total
function TCPBase:gettimeout() end

---Sets underlying descriptor.
---@param fd integer
function TCPBase:setfd(fd) end

---Sets transfer statistics.
---@param received integer
---@param sent integer
---@param age number
---@return boolean|nil success
function TCPBase:setstats(received, sent, age) end

---Sets timeout values.
---@param value number|nil
---@param mode? '"b"'|'"t"'
---@return boolean|nil success
---@return string? err
function TCPBase:settimeout(value, mode) end

---@class socket.tcp.master : socket.tcp
local TCPMaster = {}

---Binds socket.
---@param address string
---@param port integer
---@return boolean|nil success
---@return string? err
function TCPMaster:bind(address, port) end

---Connects socket.
---@param address string
---@param port integer
---@return boolean|nil success
---@return string? err
function TCPMaster:connect(address, port) end

---Starts listening.
---@param backlog? integer
---@return boolean|nil success
---@return string? err
function TCPMaster:listen(backlog) end

---@class socket.tcp.server : socket.tcp
local TCPServer = {}

---Accepts incoming connection.
---@return socket.tcp.client|nil client
---@return string? err
function TCPServer:accept() end

---Gets socket option.
---@param option string
---@return any value
---@return string? err
function TCPServer:getoption(option) end

---Sets socket option.
---@param option string
---@param value? any
---@return boolean|nil success
---@return string? err
function TCPServer:setoption(option, value) end

---@class socket.tcp.client : socket.tcp
local TCPClient = {}

---Receives data.
---@param pattern? '"*a"'|'"*l"'|integer
---@param prefix? string
---@return string|nil data
---@return string? err
---@return string? partial
function TCPClient:receive(pattern, prefix) end

---Sends data.
---@param data string
---@param i? integer
---@param j? integer
---@return integer|nil sent
---@return string? err
---@return integer? last
function TCPClient:send(data, i, j) end

---Returns remote peer info.
---@return string ip
---@return integer port
---@return '"inet"'|'"inet6"' family
function TCPClient:getpeername() end

---Gets socket option.
---@param option string
---@return any value
---@return string? err
function TCPClient:getoption(option) end

---Sets socket option.
---@param option string
---@param value? any
---@return boolean|nil success
---@return string? err
function TCPClient:setoption(option, value) end

---Shuts down communication.
---@param mode? '"both"'|'"send"'|'"receive"'
---@return boolean success
function TCPClient:shutdown(mode) end

---Creates TCP socket.
---@return socket.tcp.master|nil sock
---@return string? err
function socket.tcp() end

---Creates IPv4 TCP socket.
---@return socket.tcp.master|nil sock
---@return string? err
function socket.tcp4() end

---Creates IPv6 TCP socket.
---@return socket.tcp.master|nil sock
---@return string? err
function socket.tcp6() end

---Binds and listens.
---@param address string
---@param port integer
---@param backlog? integer
---@return socket.tcp.server|nil server
---@return string? err
function socket.bind(address, port, backlog) end

---Creates and connects TCP socket.
---@param address string
---@param port integer
---@return socket.tcp.client|nil client
---@return string? err
function socket.connect(address, port) end

---Creates and connects IPv4 TCP socket.
---@param address string
---@param port integer
---@param locaddr? string
---@param locport? integer
---@return socket.tcp.client|nil client
---@return string? err
function socket.connect4(address, port, locaddr, locport) end

---Creates and connects IPv6 TCP socket.
---@param address string
---@param port integer
---@param locaddr? string
---@param locport? integer
---@return socket.tcp.client|nil client
---@return string? err
function socket.connect6(address, port, locaddr, locport) end

--========================================================
-- UDP
--========================================================

---@class socket.udp
local UDP = {}

---Closes socket.
---@return boolean|nil success
---@return string? err
function UDP:close() end

---Gets peer name.
---@return string ip
---@return integer port
function UDP:getpeername() end

---Gets local socket name.
---@return string ip
---@return integer port
function UDP:getsockname() end

---Gets timeout.
---@return number|nil timeout
function UDP:gettimeout() end

---Gets socket option.
---@param option string
---@return any value
---@return string? err
function UDP:getoption(option) end

---Receives datagram.
---@param size? integer
---@return string|nil data
---@return string? err
function UDP:receive(size) end

---Receives datagram with sender info.
---@param size? integer
---@return string|nil data
---@return string? ip
---@return integer? port
function UDP:receivefrom(size) end

---Sends datagram.
---@param data string
---@return integer|nil bytes
---@return string? err
function UDP:send(data) end

---Sends datagram to address.
---@param data string
---@param ip string
---@param port integer
---@return integer|nil bytes
---@return string? err
function UDP:sendto(data, ip, port) end

---Sets peer name.
---@param address string
---@param port integer
---@return boolean|nil success
---@return string? err
function UDP:setpeername(address, port) end

---Sets local socket name.
---@param address string
---@param port integer
---@return boolean|nil success
---@return string? err
function UDP:setsockname(address, port) end

---Sets socket option.
---@param option string
---@param value any
---@return boolean|nil success
---@return string? err
function UDP:setoption(option, value) end

---Sets timeout.
---@param value number|nil
---@param mode? '"b"'|'"t"'
---@return boolean|nil success
---@return string? err
function UDP:settimeout(value, mode) end

---Creates UDP socket.
---@return socket.udp|nil udp
---@return string? err
function socket.udp() end

---Creates IPv4 UDP socket.
---@return socket.udp|nil udp
---@return string? err
function socket.udp4() end

---Creates IPv6 UDP socket.
---@return socket.udp|nil udp
---@return string? err
function socket.udp6() end

--========================================================
-- FTP
--========================================================

---@class socket.ftp
ftp = {}

---@class socket.ftp.request
---@field url string
---@field user? string
---@field password? string
---@field command? '"get"'|'"put"'
---@field type? '"a"'|'"i"'
---@field sink? any
---@field source? any

---FTP GET helper.
---@param request string|socket.ftp.request
---@return 1|nil success
---@return string? err
function ftp.get(request) end

---FTP PUT helper.
---@param request string|socket.ftp.request
---@return 1|nil success
---@return string? err
function ftp.put(request) end

--========================================================
-- HTTP
--========================================================

---@class socket.http
http = {}

---@class socket.http.response
---@field status integer
---@field headers table<string,string>
---@field body string

---Performs HTTP request.
---@param url string|table
---@param body? string
---@return string|nil body
---@return integer|nil code
---@return table? headers
---@return string? status
function http.request(url, body) end

--========================================================
-- SMTP
--========================================================

---@class socket.smtp
smtp = {}

---@class socket.smtp.message
---@field headers table<string,string>
---@field body string

---Builds SMTP message source.
---@param msg socket.smtp.message
---@return function source
function smtp.message(msg) end

---@class socket.smtp.send_request
---@field from string
---@field rcpt string|string[]
---@field source function
---@field server? string
---@field port? integer
---@field user? string
---@field password? string

---Sends SMTP email.
---@param request socket.smtp.send_request
---@return 1|nil success
---@return string? err
function smtp.send(request) end

--========================================================
-- MIME
--========================================================

---@class mime
mime = {}

---Base64 encode.
---@param s string
---@return string
function mime.b64(s) end

---Base64 decode.
---@param s string
---@return string
function mime.unb64(s) end

---Quoted-printable encode.
---@param s string
---@return string
function mime.qp(s) end

---Quoted-printable decode.
---@param s string
---@return string
function mime.unqp(s) end

---MIME normalize.
---@param marker? string
---@return function
function mime.normalize(marker) end

---MIME wrap.
---@param mode? integer
---@return function
function mime.wrap(mode) end

---MIME stuff.
---@return function
function mime.stuff() end

---MIME encode filter.
---@param name string
---@return function
function mime.encode(name) end

---MIME decode filter.
---@param name string
---@return function
function mime.decode(name) end

--========================================================
-- URL
--========================================================

---@class socket.url
url = {}

---@class socket.url.parsed
---@field scheme? string
---@field authority? string
---@field user? string
---@field password? string
---@field host? string
---@field port? integer
---@field path? string
---@field params? string
---@field query? string
---@field fragment? string

---Parses URL.
---@param u string
---@return socket.url.parsed
function url.parse(u) end

---Builds URL.
---@param parts socket.url.parsed
---@return string
function url.build(parts) end

---Creates absolute URL.
---@param base string
---@param relative string
---@return string
function url.absolute(base, relative) end

---Escapes URL component.
---@param s string
---@return string
function url.escape(s) end

---Unescapes URL component.
---@param s string
---@return string
function url.unescape(s) end

---Builds URL path.
---@param parts string[]
---@param unsafe? boolean
---@return string
function url.build_path(parts, unsafe) end

---Parses URL path.
---@param path string
---@return string[] parts
---@return boolean is_absolute
function url.parse_path(path) end

--========================================================
-- LTN12
--========================================================

---@class ltn12
ltn12 = {}

ltn12.filter = {}
ltn12.pump = {}
ltn12.source = {}
ltn12.sink = {}

---Chains filters.
---@vararg function
---@return function
function ltn12.filter.chain(...) end

---Cycles filter.
---@param low function
---@param ctx any
---@param extra? any
---@return function
function ltn12.filter.cycle(low, ctx, extra) end

---Pumps all data.
---@param src function
---@param snk function
---@param step? function
---@return 1|nil success
---@return string? err
function ltn12.pump.all(src, snk, step) end

---Pump one chunk.
---@param src function
---@param snk function
---@return 1|nil success
---@return string? err
function ltn12.pump.step(src, snk) end

---Creates string source.
---@param s string
---@return function
function ltn12.source.string(s) end

---Creates table source.
---@param t string[]
---@return function
function ltn12.source.table(t) end

---Creates empty source.
---@return function
function ltn12.source.empty() end

---Creates file source.
---@param handle file*
---@return function
function ltn12.source.file(handle) end

---Creates string sink.
---@param t? string[]
---@return function
---@return string[]
function ltn12.sink.table(t) end

---Creates file sink.
---@param handle file*
---@return function
function ltn12.sink.file(handle) end

---Creates null sink.
---@return function
function ltn12.sink.null() end