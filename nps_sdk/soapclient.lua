local soap = require"soap.client"
local https =  require"ssl.https"
local http = require"socket.http"
local utils = require"npssdk.utils"
local conf = require"npssdk.configuration"
local services = require"npssdk.services"

local SoapClient = {}
SoapClient.__index = SoapClient

function SoapClient.call(service, params)
    local final_params = {}

    if not utils.is_value_in_array(service, services.GET_MERCH_DET_NOT_ADD_SERVICES) then
        params = utils.add_add_details(params)
    end

    if (conf.sanitize) then
        params = utils.check_sanitize(params)
    end

    final_params = utils.build_parameters(params, service)

    if not utils.is_value_in_array(service, services.METHODS_WITHOUT_SECURE_HASH) then
        if not utils.is_value_in_array(service, services.METHODS_WITHOUT_SECURE_HASH) then
            if not utils.is_client_session_in_params(final_params) then
                final_params = utils.add_secure_hash(final_params, conf.secret_key)
            end
        end
    end

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