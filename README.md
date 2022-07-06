# Road to Web3. Week 1. Create and deploy an NFT

## Intro
This project is part of the Road to Web3 by the [Alchemy](https://www.alchemy.com/) team.

During week 1, you get an intro on NFTs, build one using [Openzeppelin´s wizard](https://docs.openzeppelin.com/contracts/4.x/wizard), deploy them on Rinkeby using [Remix](https://remix.ethereum.org/) and uploading the metadata to [Filebase](https://filebase.com/)

To see the course you can either head over to [Alchemy´s Youtube Channel](https://www.youtube.com/watch?v=veBu03A6ptw&list=PLMj8NvODurfEYLsuiClgikZBGDfhwdcXF) or see the [Blog version](https://docs.alchemy.com/alchemy/road-to-web3/weekly-learning-challenges/1.-how-to-develop-an-nft-smart-contract-erc721-with-alchemy)

Deployment address (Rinkeby) = 0xf91c1bfb2dbacbfbd39a171ef0cd3e3b47893099

Deployment Address (Goerli) = 0x106eee8ba91043946c183cf87409f895e5083450

## This project
This project follows the course original code (directly taken from OZ´s Wizard) but within a Foundry project. Basically just using this as an excuse to learn how to use Foundry. 

You will find some tests and deployment scripts.

## Instructions.

1. 
```bash
git clone https://github.com/IpastorSan/RoadToWeb3-week1-nft.git
cd RoadToWeb3-week1-nft
forge install
```
2. Compile the project
```bash
forge build
``` 
3. Run test suite
```bash
forge test
```

See the [Book of Foundry](https://book.getfoundry.sh/projects/working-on-an-existing-project.html) to learn more

**Run Locally**

Open Anvil local node
```bash
anvil
```
Load .env variables 
in .env file->NO spaces between variable name and value, value with quotes. PRIVATE_KEY="blablabla"
```bash
source .env
```
Run on local node
```bash
forge script script/nftDeploy.s.sol:NftDeploy --fork-url http://localhost:8545  --private-key $PRIVATE_KEY0 --broadcast 
```

**Deploy to Goerli**
Loads .env variables 
in .env file->NO spaces between variable name and value, value with quotes. PRIVATE_KEY="blablabla"
```bash
source .env
```
Deploy to Goerli and verify
```bash
forge script script/nftDeploy.s.sol:NftDeploy --rpc-url $GOERLI_RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
```



