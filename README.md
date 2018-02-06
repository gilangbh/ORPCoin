# ORPCoin
ORPCoin is an ERC-20 cryptocurrency for your daily needs

This is the barebone ORPCoin which will then be extended into a few use cases such as arisan, payroll, etc.

## Installation

```
$ npm install -g truffle
$ npm install -g ethereumjs-testrpc
$ mkdir ORPCoin && cd ORPCoin
$ git clone https://github.com/gilangbh/ORPCoin.git
```

## Truffle Configuration

Linux users, run this first before calling truffle:

```
$ cp truffle-config.js truffle.js
```

## Running the Test Ethereum RPC

On a different console window:

```
$ testrpc
```

## Deploying

```
$ truffle compile --all
$ truffle migrate --reset
```

## Running the console

To run the console, use this command.

```
$ truffle console
```

## Interacting with the contracts

Make sure you are inside truffle console. First, you have to set the market's ORPCoin token address.

```
truffle(development)> ORPCoin.deployed().then(function(instance){token=instance})
truffle(development)> ORPCoinMarket.deployed().then(function(instance){market=instance})
truffle(development)> var tokenaddress = token.address;
truffle(development)> market.setToken.sendTransaction(tokenaddress);
```

## Shout out

https://github.com/iam-dev

https://t.me/idblockchainnetwork
