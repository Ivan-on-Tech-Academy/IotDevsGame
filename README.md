# IotDevsGame

# A game for Solidity developers.

## How does it work?

Main.sol is the main contract. <br>
Mentors can create new contracts (quests) to test player's fundaments,logic, and in general Solidity skills. <br>
Each complete game will reward the student with 1 ERC20 IvanOnToken (IRT). <br>
The player has to burn the tokens to level up and unlock next quets. For each ITR burnt, the player level is increased by 1 (one). <br>
Bank.sol handles the token creation and destuction. <br>
All the token logic is already implemented. <br>


## Examples

There are couple of quest examples in Contracts > Game > Easy.

## How to develop

Let's try to split the contract in 3 different folders based on the difficulty (Easy / Medium / Hard). <br>
Once you create a new contract (quest) make sure to create a function in Main.sol that calls the quest and check the result (win/lose). <br>
If the player wins make sure to _mint () a new ERC20 as per example in Main.sol. <br>


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
