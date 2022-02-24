//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IyDAI {
    function deposit(uint256 _amount) external;
    function withdraw(uint256 _shares) external;
    function balanceOf(address account) external view returns (uint256);
    function getPricePerFullShare() external view returns (uint);
}