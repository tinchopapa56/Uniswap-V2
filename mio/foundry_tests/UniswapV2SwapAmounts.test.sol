//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IWETH} from "../interfaces/interfaces.sol";
import {IUniswapV2Router02} from "../interfaces/interfaces.sol";
import {DAI, WETH, MKR, UNISWAP_V2_ROUTER_02 } from "../../src/Constansts.sol";

contract UniswapV2SwapAmountsTest is Test {
    IWETH private constant weth = IWETH(WETH);
    IERC20 private constant dai = IERC20(DAI);
    IERC20 private constant mkr = IERC20(MKR);

    IUniswapV2Router02 private constant router = IUniswapV2Router02(UNISWAP_V2_ROUTER_02);

    //1 weth => Dais => MKR
    function test_getAmountsOut() public {
        address[] memory path = new address[](3);
        path[0] = WETH;
        path[1] = DAI;
        path[2] = MKR;

        uint256 amountIn = 1e18;


        uint256[] memory amounts = router.getAmountsOut(amountIn, path);

        console2.log("Weth: ", amounts[0]);
        console2.log("Dai: ", amounts[1]);
        console2.log("Mkr: ", amounts[2]);
    }

}
