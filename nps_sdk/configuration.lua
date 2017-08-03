local configuration = {
    environment = "https://sandbox.nps.com.ar/ws.php",
    secret_key = "",
    debug = false,
    timeout = 60,
    log_level = "INFO",
    log_file = nil,
    sanitize = true,
    proxy_url = nil,
    proxy_port = nil,
    proxy_pass = nil,
    proxy_user = nil
}
configuration.__index = configuration

return configuration