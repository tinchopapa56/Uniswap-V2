// Importación de la interfaz estándar de ERC20

// Importación de la interfaz del contrato WETH
interface IWETH {
    function deposit() external payable;
    function withdraw(uint amount) external;
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address to, uint256 value) external returns (bool);
    function balanceOf(address owner) external view returns (uint256);
}

// Importación de la interfaz de UniswapV2Router02
interface IUniswapV2Router02 {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
}
