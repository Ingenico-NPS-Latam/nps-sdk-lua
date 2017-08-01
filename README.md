#  Lua SDK
 

## Availability
Supports Lua 5.1, 5.2 and 5.3


## How to install

```
luarocks install npssdk
```

## Configuration

It's a basic configuration of the SDK

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
```

Here is an simple example request:

```lua
local nps = require("npssdk")

local p2p = {}

p2p.psp_Version="2.2"
p2p.psp_MerchantId="psp_test"
p2p.psp_SecureHash="3347988f4fd623170bfdcad1afc5eec9"
p2p.psp_TxSource="WEB"
p2p.psp_MerchTxRef=uuid()
p2p.psp_MerchOrderId=uuid()
p2p.psp_Amount="1000"
p2p.psp_NumPayments="1"
p2p.psp_Currency="032"
p2p.psp_Product="14"
p2p.psp_Country="ARG"
p2p.psp_CardNumber="4242424242420010"
p2p.psp_CardExpDate="1909"
p2p.psp_CardSecurityCode="123"
p2p.psp_CardHolderName="Gustavo Diaz"
p2p.psp_PosDateTime="2017-01-12 13:05:00"

resp = nps.payonline_2p(p2p)

```

## Environments

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.environ = nps.STAGING_ENV
nps.configuration.environ = nps.PRODUCTION_ENV
```

## Advanced configurations

Nps SDK allows you to log what’s happening with you request inside of our SDK, it logs by default to stout.

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
nps.configuration.debug = true
```


If you have the debug option enabled, the sdk can write the output generated from the logger to the file you provided.

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
nps.configuration.debug = true
nps.configuration.log_file = "path/to/your/file.log"

```

The logging.INFO level will write concise information of the request and will mask sensitive data of the request. 
The logging.DEBUG level will write information about the request to let developers debug it in a more detailed way.

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
nps.configuration.debug = true
nps.configuration.log_level = "DEBUG"
```

Sanitize allows the SDK to truncate to a fixed size some fields that could make request fail, like extremely long name.

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
nps.configuration.sanitize = true
```

you can change the timeout of the request.

```lua
local nps = require("npssdk")
nps.configuration.environ = nps.SANDBOX_ENV
nps.configuration.secret_key = "_YOUR_SECRET_KEY_"
nps.configuration.timeout = 60
```
