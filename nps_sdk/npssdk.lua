local soapclient = require"soapclient"
local services = require"services"
local def_conf = require"configuration"

local npssdk = {
    SANDBOX_ENV = "https://sandbox.nps.com.ar/ws.php",
    STAGING_ENV = "https://implemetacion.nps.com.ar/ws.php",
    PRODUCTION_ENV = "https://service2.nps.com.ar/ws.php",
    configuration = def_conf
}
npssdk.__index = npssdk

function npssdk.pay_online_2p(params)
    return soapclient.call(services.PAY_ONLINE_2P, params)
end

function npssdk.authorize_2p(params)
    return soapclient.call(services.AUTHORIZE_2P, params)
end

function npssdk.query_txs(params)
    return soapclient.call(services.QUERY_TXS, params)
end

function npssdk.simple_query_tx(params)
    return soapclient.call(services.SIMPLE_QUERY_TX, params)
end

function npssdk.refund(params)
    return soapclient.call(services.REFUND, params)
end

function npssdk.capture(params)
    return soapclient.call(services.CAPTURE, params)
end

function npssdk.authorize_3p(params)
    return soapclient.call(services.AUTHORIZE_3P, params)
end

function npssdk.bank_payment_3p(params)
    return soapclient.call(services.BANK_PAYMENT_3P, params)
end

function npssdk.bank_payment_2p(params)
    return soapclient.call(services.BANK_PAYMENT_2P, params)
end

function npssdk.cash_payment_3p(params)
    return soapclient.call(services.CASH_PAYMENT_3P, params)
end

function npssdk.change_secret_key(params)
    return soapclient.call(services.CHANGE_SECRET_KEY, params)
end

function npssdk.fraud_screening(params)
    return soapclient.call(services.FRAUD_SCREENING, params)
end

function npssdk.notify_fraud_screening_review(params)
    return soapclient.call(services.NOTIFY_FRAUD_SCREENING_REVIEW, params)
end

function npssdk.pay_online_3p(params)
    return soapclient.call(services.PAY_ONLINE_3P, params)
end

function npssdk.split_authorize_3p(params)
    return soapclient.call(services.SPLIT_AUTHORIZE_3P, params)
end

function npssdk.split_pay_online_3p(params)
    return soapclient.call(services.SPLIT_PAY_ONLINE_3P, params)
end

function npssdk.query_card_number(params)
    return soapclient.call(services.QUERY_CARD_NUMBER, params)
end

function npssdk.get_iin_details(params)
    return soapclient.call(services.GET_IIN_DETAILS, params)
end

function npssdk.create_payment_method(params)
    return soapclient.call(services.CREATE_PAYMENT_METHOD, params)
end

function npssdk.create_payment_method_from_payment(params)
    return soapclient.call(services.CREATE_PAYMENT_METHOD_FROM_PAYMENT, params)
end

function npssdk.retrieve_payment_method(params)
    return soapclient.call(services.RETRIEVE_PAYMENT_METHOD, params)
end

function npssdk.update_payment_method(params)
    return soapclient.call(services.UPDATE_PAYMENT_METHOD, params)
end

function npssdk.delete_payment_method(params)
    return soapclient.call(services.DELETE_PAYMENT_METHOD, params)
end

function npssdk.create_customer(params)
    return soapclient.call(services.CREATE_CUSTOMER, params)
end

function npssdk.retrieve_customer(params)
    return soapclient.call(services.RETRIEVE_CUSTOMER, params)
end

function npssdk.update_customer(params)
    return soapclient.call(services.UPDATE_CUSTOMER, params)
end

function npssdk.delete_customer(params)
    return soapclient.call(services.DELETE_CUSTOMER, params)
end

function npssdk.recache_payment_method_token(params)
    return soapclient.call(services.RECACHE_PAYMENT_METHOD_TOKEN, params)
end

function npssdk.create_payment_method_token(params)
    return soapclient.call(services.CREATE_PAYMENT_METHOD_TOKEN, params)
end

function npssdk.retrieve_payment_method_token(params)
    return soapclient.call(services.RETRIEVE_PAYMENT_METHOD_TOKEN, params)
end

function npssdk.create_client_session(params)
    return soapclient.call(services.CREATE_CLIENT_SESSION, params)
end

function npssdk.get_installments_options(params)
    return soapclient.call(services.GET_INSTALLMENTS_OPTIONS, params)
end

function npssdk.split_pay_online_2p(params)
    return soapclient.call(services.SPLIT_PAY_ONLINE_2P, params)
end

function npssdk.split_authorize_2p(params)
    return soapclient.call(services.SPLIT_AUTHORIZE_2P, params)
end

function npssdk.query_card_details(params)
    return soapclient.call(services.QUERY_CARD_DETAILS, params)
end

return npssdk