var ORPCoin = artifacts.require("./ORPCoin.sol");
var ORPCoinMarket = artifacts.require("./ORPCoinMarket.sol");
//var HoldmeTokenSale = artifacts.require('./HoldmeTokenSale');

module.exports = function(deployer) {
    
    const OWNER =  '0x0';
	const INITIAL_SUPPLY = 0;
	const TOKEN_NAME = 'ORPCoin';
	const TOKEN_SYMBOL = 'ORP';
	const DECIMALS = 8;
	const MINIMUMPURCHASE = 1000000;
	const DEVPERCENTAGE = 1;

	deployer.deploy(ORPCoin, OWNER, INITIAL_SUPPLY, TOKEN_NAME, TOKEN_SYMBOL, DECIMALS);
	deployer.deploy(ORPCoinMarket,MINIMUMPURCHASE,DEVPERCENTAGE);
}