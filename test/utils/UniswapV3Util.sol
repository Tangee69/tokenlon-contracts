// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

uint24 constant FEE_LOW = 500;
uint24 constant FEE_MEDIUM = 3000;
uint24 constant FEE_HIGH = 10000;

interface IQuoter {
    function quoteExactInput(bytes memory path, uint256 amountIn) external returns (uint256 amountOut);

    function quoteExactInputSingle(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint256 amountIn,
        uint160 sqrtPriceLimitX96
    ) external returns (uint256 amountOut);

    function quoteExactOutput(bytes memory path, uint256 amountOut) external returns (uint256 amountIn);

    function quoteExactOutputSingle(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint256 amountOut,
        uint160 sqrtPriceLimitX96
    ) external returns (uint256 amountIn);
}

function encodePath(address[] memory path, uint24[] memory fees) pure returns (bytes memory) {
    bytes memory res;
    for (uint256 i = 0; i < fees.length; i++) {
        res = abi.encodePacked(res, path[i], fees[i]);
    }
    res = abi.encodePacked(res, path[path.length - 1]);
    return res;
}

function quoteUniswapV3ExactInput(
    address uni_v3_quoter,
    bytes memory path,
    uint256 amountIn
) returns (uint256) {
    return IQuoter(uni_v3_quoter).quoteExactInput(path, amountIn);
}
