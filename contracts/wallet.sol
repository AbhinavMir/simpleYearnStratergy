//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IyDAI.sol";

contract Wallet
{
    address admin;
    IERC20 dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    IyDAI yDai = IyDAI(0xC2cB1040220768554cf699b0d863A3cd4324ce32);

    constructor () 
    {
        admin = msg.sender;
    }

    function save(uint _amount) external 
    {
        dai.transferFrom(msg.sender, address(this), _amount);
        _save(_amount);
    }

    function spend(uint amount, address recipient) external{
        require(msg.sender == admin, "Only Admin");
        uint _balanceShares = yDai.balanceOf(address(this));
        yDai.withdraw(_balanceShares);
        dai.transfer(recipient, amount);
        uint _balanceDai = dai.balanceOf(address(this));
        if(_balanceDai>0){
           _save(_balanceDai);
        }
    }

    function _save(uint _amount) internal 
    {
        dai.approve(address(yDai), _amount);
        yDai.deposit(_amount);
    }

    function balance() external view returns (uint)
    {
        uint _price = yDai.getPricePerFullShare();
        uint _balanceShares = yDai.balanceOf(address(this));
        return _balanceShares * _price;
    }
}