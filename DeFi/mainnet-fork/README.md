# Testing truffle Contracts with Ganache Mainnet Fork

### Setup

- infura API
- `npm install truffle ganache-cli`
- edit truffle config

### Test examples

- query mainnet DAI balance
- unlock account and transfer DAI

DAI=0x6B175474E89094C44Da98b954EedeAC495271d0F
DAI_WHALE=0x28c6c06298d514db089934071355e5743bf21d60

INFURA_API_KEY=e43ccc622b8c4b4aa4342d672cdcd7dc

```bash
INFURA_API_KEY=e43ccc622b8c4b4aa4342d672cdcd7dc
DAI_WHALE=0x28c6c06298d514db089934071355e5743bf21d60
ganache-cli --fork https://mainnet.infura.io/v3/$INFURA_API_KEY \
--unlock $DAI_WHALE \
--networkId 999
```
