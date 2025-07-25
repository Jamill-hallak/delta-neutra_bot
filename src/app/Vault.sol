// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {console} from "forge-std/Test.sol";
import {IERC20} from "../interfaces/IERC20.sol";
import {Math} from "../lib/Math.sol";
import {IStrategy} from "../lib/app/IStrategy.sol";
import {IVault} from "../lib/app/IVault.sol";
import {Auth} from "../lib/app/Auth.sol";
import "../Constants.sol";

contract Vault is Auth {
    uint256 private constant DECIMAL_OFFSET = 6;

    IERC20 public constant weth = IERC20(WETH);
    IStrategy public strategy;
    address public withdrawCallback;

    bool private locked;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(bytes32 => IVault.WithdrawOrder) public withdrawOrders;

    modifier guard() {
        require(!locked, "locked");
        locked = true;
        _;
        locked = false;
    }

    function setStrategy(address _strategy) external auth {
        strategy = IStrategy(_strategy);
    }

    function setWithdrawCallback(address _withdrawCallback) external auth {
        withdrawCallback = _withdrawCallback;
    }

    // Task 1: Calculate the total value managed by this contract
    function totalValueInToken() public view returns (uint256) {
        uint256 val = weth.balanceOf(address(this));
        if (address(strategy) != address(0)) {
            val += strategy.totalValueInToken();
        }
        return val;
    }

    function getWithdrawOrder(bytes32 key)
        external
        view
        returns (IVault.WithdrawOrder memory)
    {
        return withdrawOrders[key];
    }

    // Task 2: Deposit WETH and mint shares
    function deposit(uint256 wethAmount)
        external
        guard
        returns (uint256 shares)
    {
       strategy.claim() ;
       
       shares = _convertToShares(totalSupply, totalValueInToken(),wethAmount) ;
       //transfer() not work , cause it  send from caller(this contract ) not msg.sender 
        weth.transferFrom(msg.sender, address(this), wethAmount);
        _mint(msg.sender, shares);
    }

    // NOTE: Withdrawal delay or gradual profit distribution should be implemented
    // to prevent users from depositing before profit is claimed by the strategy and then
    // immediately withdrawing after.

    // Task 3: Burn shares and withdraw WETH
    function withdraw(uint256 shares)
        external
        payable
        guard
        returns (uint256 wethSent, bytes32 withdrawOrderKey)
    {
         if (address(strategy) != address(0)) {
            strategy.claim();
        }
        uint256 valutbalance = weth.balanceOf(address(this));
        uint256 strategybalance = weth.balanceOf(address(strategy));
        
        uint256 amountWithdraw = _convertToWeth(totalSupply,totalValueInToken(), shares)  ;
       
         require(amountWithdraw > 0, "weth amount = 0");
        if(valutbalance+strategybalance > amountWithdraw){
            
             if(valutbalance<amountWithdraw){
        strategy.transfer(address(this), amountWithdraw - valutbalance);
             }
        weth.transfer(msg.sender, amountWithdraw);
        
        _burn(msg.sender,shares);
         if (msg.value > 0) {
                (bool ok,) = msg.sender.call{value: msg.value}("");
                require(ok, "Send ETH failed");
            }
            
            wethSent = amountWithdraw ;
        }
        else{
            
        uint256 reaming= amountWithdraw - valutbalance - strategybalance ;
        uint256 sharesend = _convertToShares(totalSupply,totalValueInToken(), valutbalance + strategybalance)  ;
        
        strategy.transfer(  msg.sender, strategybalance);
        weth.transfer(msg.sender, valutbalance);
        _burn(msg.sender, sharesend);
        
        uint256 sharedlock =  shares -sharesend ;
        _lock(msg.sender,  sharedlock) ;
       
        require(withdrawCallback.code.length>0,"invalid contract");
        withdrawOrderKey = strategy.decrease{value:msg.value}(reaming, withdrawCallback);
        withdrawOrders[withdrawOrderKey]=IVault.WithdrawOrder({
           account :msg.sender ,
         shares : sharedlock ,
         weth :reaming
       }) ;
       wethSent= valutbalance + strategybalance  ;
        
        }
    }

    // Task 4: Cancel withdraw order
    function cancelWithdrawOrder(bytes32 key) external guard {
        IVault.WithdrawOrder memory order =  withdrawOrders[key] ;
        require(order.account==msg.sender,"invalid key");
        require(withdrawCallback.code.length>0,"not contract");
        strategy.cancel(key);

    }

    // Task 5: Delete withdraw order. This function is called from WithdrawCallback
    function removeWithdrawOrder(bytes32 key, bool ok) external auth {
         IVault.WithdrawOrder memory withdrawOrder = withdrawOrders[key];

        _unlock(withdrawOrder.account, withdrawOrder.shares);
        if (ok) {
            _burn(withdrawOrder.account, withdrawOrder.shares);
        }

        delete withdrawOrders[key];
    }

    // OpenZeppelin vault inflation protection
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/1873ecb38e0833fa3552f58e639eeeb134b82135/contracts/token/ERC20/extensions/ERC4626.sol#L225-L234
    function _convertToShares(
        uint256 totalShares,
        uint256 totalWethInPool,
        uint256 wethAmount
    ) internal pure returns (uint256) {
        if (totalShares == 0 || totalWethInPool == 0) {
            return wethAmount;
        }

        return
            (totalShares + 10 ** DECIMAL_OFFSET) * wethAmount / totalWethInPool;
    }

    function _convertToWeth(
        uint256 totalShares,
        uint256 totalWethInPool,
        uint256 shares
    ) internal pure returns (uint256) {
        return totalWethInPool * shares / (totalShares + 10 ** DECIMAL_OFFSET);
    }

    function _mint(address dst, uint256 shares) internal {
        totalSupply += shares;
        balanceOf[dst] += shares;
    }

    function _burn(address src, uint256 shares) internal {
        totalSupply -= shares;
        balanceOf[src] -= shares;
    }

    function _lock(address src, uint256 shares) internal {
        balanceOf[src] -= shares;
        balanceOf[address(this)] += shares;
    }

    function _unlock(address dst, uint256 shares) internal {
        balanceOf[dst] += shares;
        balanceOf[address(this)] -= shares;
    }

    function transfer(address dst, uint256 amount) external auth {
        weth.transfer(dst, amount);
    }
}
