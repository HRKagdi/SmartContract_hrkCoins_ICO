// HRK Coins ICO (Initial Coin Offering)

// Version of compiler
//pragma solidity ^0.4.1

contract hrkcoin_ICO {
    
    // Introducing the maximum number of HRKCoins available for sale
    uint public max_hrkcoins = 1000000;
    
    // Introducing Conversion rate from USD to HRKCoins
    uint public usd_to_hrkcoins = 1000;
    
    // Introducing the total number of HRKCoins that have been bought by investors
    uint public total_hrkcoins_bought = 0;
    
    //Mapping from the investor address to it aquity in HRKcoins and USD
    mapping(address => uint) equity_hrkcoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy HRKcoins
    modifier can_buy_hrkcoins(uint usdInvested){
        require(usdInvested * usd_to_hrkcoins <= max_hrkcoins - total_hrkcoins_bought);
        _;
    }
    
    // Getting the equity in HRKcoins of an investor
    function equity_in_hrkcoin(address investor) external returns (uint) {
        return equity_hrkcoins[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external returns (uint) {
        return equity_usd[investor];
    }    
    
    // Buying HRKcoins
    function buy_hrkcoins(address investor, uint usdInvested) external 
    can_buy_hrkcoins(usdInvested) {
        uint hrkcoins_bought = usdInvested * usd_to_hrkcoins;
        equity_hrkcoins[investor] += hrkcoins_bought;
        equity_usd[investor] = equity_hrkcoins[investor] / 1000;
        total_hrkcoins_bought += hrkcoins_bought;
    }
    
    // Selling HRKcoins
    function sell_hrkcoins(address investor, uint hrkcoins_sold) external {
        equity_hrkcoins[investor] -= hrkcoins_sold;
        equity_usd[investor] = equity_hrkcoins[investor] / 1000;
        total_hrkcoins_bought -= hrkcoins_sold;
    }
}
