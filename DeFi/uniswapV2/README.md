# Uniswap V2

### Test

```shell
source .example.env

# using infura.io
npx ganache-cli \
--fork https://mainnet.infura.io/v3/$WEB3_INFURA_PROJECT_ID \
--unlock $WETH_WHALE \
--unlock $DAI_WHALE \
--unlock $USDC_WHALE \
--unlock $USDT_WHALE \
--unlock $WBTC_WHALE \
--networkId 999
```

```shell
# test Swap tokens
npx truffle test --network mainnet_fork test/test-uniswap.js
# test Liquidity
npx truffle test --network mainnet_fork test/test-uniswap-liquidity.js
```