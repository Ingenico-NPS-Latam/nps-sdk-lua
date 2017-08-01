local md5 = require"md5"
local soap = require"soap"
sanitize = require"sanitize"
local Utils = {}
Utils.__index = Utils

function Utils.build_parameters(params, service)
    local finalParams = build_inner_parameters(params, service)
    finalParams.tag="Requerimiento"
    return finalParams
end

function build_inner_parameters(params, service)
    local finalParams = {}
    local i = 1
    for k,v in pairs(params) do
        local tempTable = {}
        if ((type(v)) == "string") or ((type(v)) == "number") then
            tempTable.tag = k
            tempTable[1] = v
        else
            tempTable = build_table_parameter(v, service)
            tempTable.tag = k
        end
        finalParams[i] = tempTable
        i = i + 1
    end
    return finalParams
end

function build_table_parameter(params, service)
    if (is_assoc(params)) then
        resp = build_inner_parameters(params)
    else
        resp = build_array_parameter(params, service)
    end
    return resp
end

function build_array_parameter(params, service)
    local inner_array = {}
    for k, v in pairs(params) do
        inner_array[k] = build_inner_parameters(v)
        inner_array[k].tag = "Item"
       
    end
    inner_array.attr = {        
            "ns2:arrayType",
            ["ns2:arrayType"]=""
    }

    return inner_array
end

function is_assoc(tbl)
    local numKeys = 0
    for _, _ in pairs(tbl) do
        numKeys = numKeys+1
    end
    local numIndices = 0
    for _, _ in ipairs(tbl) do
        numIndices = numIndices+1
    end
    return numKeys ~= numIndices
end

function Utils.wrap_response(response)
    if (response[1]) == nil then
        return response
    end
    local wrapped_response = normalize_table(response[1])
    return wrapped_response
end

function normalize_table(response)
    local wrapped_response = {}
    for k, v in ipairs(response) do
        if (type(v[1]) == "table") then
            wrapped_response[v.tag] = normalize_array(v)
        else
            wrapped_response[v.tag] = v[1]
        end
    end
    return wrapped_response
end

function normalize_array(params)
    local resp = ""
    if params.attr["SOAP-ENC:arrayType"] == null then
        resp = normalize_table(params)
    else
        resp = normalize_array_items(params)
    end
    return resp
end

function normalize_array_items(params)
    local inner_array={}
    for k, v in ipairs(params) do
        inner_array[k] = normalize_table(params)
    end
    return inner_array
end

function Utils.add_secure_hash(params, thekey)
    local tempTable = {}
    tempTable.tag = "psp_SecureHash"
    tempTable[1] = build_secure_hash(params, thekey)
    params[#params+1] = tempTable
    return params
end

function build_secure_hash(params, thekey)
    local concatenated_params = concat_params(params, thekey)
    return md5.sumhexa(concatenated_params)
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

function concat_params(params, thekey)
    local concatenated_params = ""
    local tempTable = {}
    for k, v in ipairs(params) do
        if not(type(v[1]) == "table") then
            tempTable[v.tag] = v[1]
        end
    end

    for name, line in pairsByKeys(tempTable) do
      concatenated_params = concatenated_params .. line
    end
    concatenated_params = concatenated_params .. thekey
    return concatenated_params
end

function Utils.log(t, log_level, log_file)
    local xml = soap.serialize(t)
    if (log_level == "INFO") then
        xml = ofuscate(xml)
    end
    if (log_file) then
        file = io.open (file_path, "a")
        io.output(file)
        io.write(xml)
        io.close()
    else
        print(xml)
    end
end

function ofuscate(xml)
    xml = ofuscate_card_number(xml)
    xml = ofuscate_exp_date(xml)
    xml = ofuscate_cvc(xml)
    return xml
end

function ofuscate_card_number(xml)
    xml = string.gsub(xml,"([0-9]*</psp_CardNumber>)", inner_card_number_ofuscate)
    xml = string.gsub(xml,"([0-9]*</Number>)", inner_card_number_ofuscate)
    return xml
end

function inner_card_number_ofuscate(xml)
    xml = string.gsub(xml,"([0-9]*)", wrap_card_number)
    return xml
end

function wrap_card_number(number)
    b = string.sub(number, 0, 6)
    f = string.sub(number, string.len(number)-4, string.len(number))
    number = b .. string.rep("*",string.len(number)-10) .. f
    return number
end

function ofuscate_exp_date(xml)
    xml = string.gsub(xml,"([0-9]*</psp_CardExpDate>)", inner_exp_date_ofuscate)
    xml = string.gsub(xml,"([0-9]*</ExpirationDate>)", inner_exp_date_ofuscate)
    return xml
end

function inner_exp_date_ofuscate(number)
    xml = string.gsub(number,"([0-9]*)", function(xml)return string.rep("*", string.len(xml))end)
    return xml
end


function ofuscate_cvc(xml)
    xml = string.gsub(xml,"([0-9]*</psp_CardSecurityCode>)", inner_cvc_ofuscate)
    xml = string.gsub(xml,"([0-9]*</SecurityCode>)", inner_cvc_ofuscate)
    return xml
end

function inner_cvc_ofuscate(number)
    xml = string.gsub(number,"([0-9]*)", function(xml)return string.rep("*", string.len(xml))end)
    return xml
end

function Utils.check_sanitize(params, is_root, nodo)
    return sanitize_me(params)
end

function sanitize_me(params, is_root, nodo)
    local result_params = {}
    if (is_root == nil) or (is_root == false) then
        result_params = {}
    else
        result_params = params
    end
    for k, v in pairs(params) do
        if (type(v) == "table") then
            if is_assoc(v) then
                result_params[k] = sanitize_me(v, false, k)                
            else
                result_params[k] = check_sanitize_array(v, k)
            end
        else
            result_params[k] = validate_size(v, k, nodo)
        end
    end
    return result_params
end


function check_sanitize_array(params, nodo)
    local resul_params = {}
    for k, v in ipairs(params) do
        resul_params[#resul_params+1] = sanitize_me(v, false, nodo)
    end
    return resul_params
end


function validate_size(value, k, nodo)
    local key_name = ""
    if (nodo) then
        key_name = nodo .. k .. ".max_length"
    else
        key_name = k .. ".max_length"
    end
    local size = sanitize[key_name]
    if (size) then
        value = string.sub( value, 0, size)
    end
    return value
end

function Utils.add_add_details(params)
    local add_details = {}
    if (params["psp_MerchantAdditionalDetails"]) then
        add_details = params["psp_MerchantAdditionalDetails"]
    end
    add_details["SdkInfo"] = "Sdk Lua 1.0.0"
    params["psp_MerchantAdditionalDetails"] = add_details
    return params
end

return Utils