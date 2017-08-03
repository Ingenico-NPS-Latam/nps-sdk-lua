local soap = require"soap.client"
local https =  require"ssl.https"
local http = require"socket.http"
local utils = require"utils"
local conf = require"configuration"

local SoapClient = {
    
}
SoapClient.__index = SoapClient

function SoapClient.call(service, params)
    local pre_final_params = {}
    params = utils.add_add_details(params)
    if (conf.sanitize) then
        pre_final_params = utils.check_sanitize(params)
    end
    pre_final_params = utils.build_parameters(params, service)
    local final_params = utils.add_secure_hash(pre_final_params, conf.secret_key)
    
    http.TIMEOUT = conf.timeout
    soap.https = https
    utils.log(final_params, conf.log_level, conf.log_file)
    local ns, meth, ent = soap.call {
         url = conf.environment,
         soapaction = conf.environment .. service,
         method = service,
         namespace = "ns3",
         entries = {final_params}
        }

    utils.log(ent[1], conf.log_level, conf.log_file)
    local wrapped_response = utils.wrap_response(ent)
    return wrapped_response

end

return SoapClient