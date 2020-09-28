# IotDevsGame

# A game for Solidity developers.

## How does it work?

Once a new player sign in, it gets a NFT token which represents her/him in the game. <br>
For each level completed, the NFT will level up <br>
Main.sol is the main contract which contains the functions necessary to create a new instance of the level, and check if the level has been successfully completed. <br>
Mentors can create new contracts (levels) to test player's fundaments,logic, and in general Solidity skills. <br>
A new level can be added to the game by the contract owner. <br>
In order to have the level added to the game it needs two smart contract : <br>
- The game instance; <br>
- The game deployer; <br>

## Instance && Deployer

Once created the game, the developer needs also to provide a Deployer contract which must contain: <br>
```function newInstance ()``` && ```function check (address _instance, address _player)``` <br>

The ```function newInstance ()``` will deploy a new instance of the game; <br>
The ```function check (address _instance, address _player)``` will verify if the level has been completed and will return true if positive. <br>


A test.js file needs to be provided with the two smart contracts. <br>

## Examples

Contracts > Game > Levels.

## Starter kit

### Register on Infura

https://infura.io/register

### Deploy on Ropsten

Go to truffle-config.js and add your Infura api and your mnemonic

```
const infuraApi = "** Your Infura apy key **";
```

```
const mnemonic = "** Your mnemonic **";
```


### migrate the main contract to Ropsten

```
truffle migrate --reset --network ropsten
```

Once the migration has been done

```
truffle console --network ropsten
```
