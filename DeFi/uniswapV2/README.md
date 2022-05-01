# Uniswap V2

### Test

```shell
source .example.env

# using infura.io
ganache-cli \
--fork https://mainnet.infura.io/v3/$WEB3_INFURA_PROJECT_ID \
--unlock $DAI_WHALE \
--networkId 999
```

```shell
# test Swap tokens
npx truffle test --network mainnet_fork test/test-uniswap.js
```