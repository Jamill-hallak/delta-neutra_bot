// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {console} from "forge-std/Test.sol";
import {IDataStore} from "../../src/interfaces/IDataStore.sol";
import {IReader} from "../../src/interfaces/IReader.sol";
import {IGlvReader} from "../../src/interfaces/IGlvReader.sol";
import {Keys} from "../../src/lib/Keys.sol";
import "../../src/Constants.sol";

contract MarketHelper {
    IReader constant reader = IReader(READER);
    IGlvReader constant glvReader = IGlvReader(GLV_READER);
    IDataStore constant dataStore = IDataStore(DATA_STORE);

    struct Info {
        string name;
        address oracle;
        // Token decimals
        uint256 decimals;
    }

    // market, index, short and long token to chainlink
    mapping(address => Info) public info;
    address[] public tokens;

    function set(string memory name, address token, uint256 decimals)
        internal
    {
        if (info[token].oracle == address(0)) {
            tokens.push(token);
        }
        address oracle = getPriceFeed(token);
        info[token] = Info(name, oracle, decimals);
    }

    function getPriceFeed(address token) internal view returns (address) {
        return dataStore.getAddress(Keys.priceFeedKey(token));
    }

    constructor() {
        // Short and long
        set("WETH", WETH, 18);
        set("WBTC", WBTC, 8);
        set("USDC", USDC, 6);
        set("DAI", DAI, 18);
        set("AAVE", AAVE, 18);
        set("UNI", UNI, 18);

        // Index
        set("GMX_RENDER_WETH_USDC_INDEX", GMX_RENDER_WETH_USDC_INDEX, 0);
        set("GMX_SUI_WETH_USDC_INDEX", GMX_SUI_WETH_USDC_INDEX, 0);
        set("GMX_APT_WETH_USDC_INDEX", GMX_APT_WETH_USDC_INDEX, 0);
        set("GMX_WLD_WETH_USDC_INDEX", GMX_WLD_WETH_USDC_INDEX, 0);
        set("GMX_FET_WETH_USDC_INDEX", GMX_FET_WETH_USDC_INDEX, 0);
        set("GMX_TRX_WETH_USDC_INDEX", GMX_TRX_WETH_USDC_INDEX, 0);
        set("GMX_TON_WETH_USDC_INDEX", GMX_TON_WETH_USDC_INDEX, 0);
        set("GMX_ONDO_WETH_USDC_INDEX", GMX_ONDO_WETH_USDC_INDEX, 0);
        set("GMX_EIGEN_WETH_USDC_INDEX", GMX_EIGEN_WETH_USDC_INDEX, 0);
        set("GMX_KBONK_WETH_USDC_INDEX", GMX_KBONK_WETH_USDC_INDEX, 0);
        set("GMX_FARTCOIN_WBTC_USDC_INDEX", GMX_FARTCOIN_WBTC_USDC_INDEX, 0);
        set("GMX_PENGU_WBTC_USDC_INDEX", GMX_PENGU_WBTC_USDC_INDEX, 0);
        set("GMX_VIRTUAL_WBTC_USDC_INDEX", GMX_VIRTUAL_WBTC_USDC_INDEX, 0);
        set("GMX_BCH_WBTC_USDC_INDEX", GMX_BCH_WBTC_USDC_INDEX, 0);
        set("GMX_KFLOKI_WBTC_USDC_INDEX", GMX_KFLOKI_WBTC_USDC_INDEX, 0);
        set("GMX_INJ_WBTC_USDC_INDEX", GMX_INJ_WBTC_USDC_INDEX, 0);
        set("GMX_FIL_WBTC_USDC_INDEX", GMX_FIL_WBTC_USDC_INDEX, 0);
        set("GMX_ICP_WBTC_USDC_INDEX", GMX_ICP_WBTC_USDC_INDEX, 0);
        set("GMX_BOME_WBTC_USDC_INDEX", GMX_BOME_WBTC_USDC_INDEX, 0);
        set("GMX_XLM_WBTC_USDC_INDEX", GMX_XLM_WBTC_USDC_INDEX, 0);
        set("GMX_AI16Z_WBTC_USDC_INDEX", GMX_AI16Z_WBTC_USDC_INDEX, 0);
        set("GMX_MSATS_WBTC_USDC_INDEX", GMX_MSATS_WBTC_USDC_INDEX, 0);
        set("GMX_MEME_WBTC_USDC_INDEX", GMX_MEME_WBTC_USDC_INDEX, 0);
        set("GMX_MEW_WBTC_USDC_INDEX", GMX_MEW_WBTC_USDC_INDEX, 0);
        set("GMX_DYDX_WBTC_USDC_INDEX", GMX_DYDX_WBTC_USDC_INDEX, 0);
        set("GMX_LTC_WETH_USDC_INDEX", GMX_LTC_WETH_USDC_INDEX, 0);
        set("GMX_BERA_WETH_USDC_INDEX", GMX_BERA_WETH_USDC_INDEX, 0);
        set("GMX_XRP_WETH_USDC_INDEX", GMX_XRP_WETH_USDC_INDEX, 0);
        set("GMX_KSHIB_WETH_USDC_INDEX", GMX_KSHIB_WETH_USDC_INDEX, 0);
        set("GMX_POL_WETH_USDC_INDEX", GMX_POL_WETH_USDC_INDEX, 0);
        set("GMX_SEI_WETH_USDC_INDEX", GMX_SEI_WETH_USDC_INDEX, 0);
        set("GMX_ORDI_WBTC_USDC_INDEX", GMX_ORDI_WBTC_USDC_INDEX, 0);
        set("GMX_STX_WBTC_USDC_INDEX", GMX_STX_WBTC_USDC_INDEX, 0);
        /*
        market: 0xD8471b9Ea126272E6d32B5e4782Ed76DB7E554a4
        index: 0xFa7F8980b0f1E64A2062791cc3b0871572f1F7f0
        long: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1
        short: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831
        index = EOA? false
        GMX price feed 0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720
        */
        set(
            "GMX_UNI_WETH_USDC_INDEX",
            0xFa7F8980b0f1E64A2062791cc3b0871572f1F7f0,
            18
        );

        set("GMX_BTC_WBTC_USDC_INDEX", GMX_BTC_WBTC_USDC_INDEX, 8);
        set("GMX_ETH_WETH_USDC_INDEX", GMX_ETH_WETH_USDC_INDEX, 18);
        set("GMX_TRUMP_WETH_USDC_INDEX", GMX_TRUMP_WETH_USDC_INDEX, 6);
        set("GMX_DOGE_WETH_USDC_INDEX", GMX_DOGE_WETH_USDC_INDEX, 8);
        set("GMX_NEAR_WETH_USDC_INDEX", GMX_NEAR_WETH_USDC_INDEX, 24);
        set("GMX_ENA_WETH_USDC_INDEX", GMX_ENA_WETH_USDC_INDEX, 18);
        set("GMX_MELANIA_WETH_USDC_INDEX", GMX_MELANIA_WETH_USDC_INDEX, 6);
        set("GMX_LDO_WETH_USDC_INDEX", GMX_LDO_WETH_USDC_INDEX, 18);
        set("GMX_TAO_WBTC_USDC_INDEX", GMX_TAO_WBTC_USDC_INDEX, 9);
        set("GMX_ATOM_WETH_USDC_INDEX", GMX_ATOM_WETH_USDC_INDEX, 6);
        set("GMX_DOT_WBTC_USDC_INDEX", GMX_DOT_WBTC_USDC_INDEX, 10);
        set("GMX_TIA_WETH_USDC_INDEX", GMX_TIA_WETH_USDC_INDEX, 6);
        set("GMX_ADA_WBTC_USDC_INDEX", GMX_ADA_WBTC_USDC_INDEX, 6);
    }

    function get(address token) external view returns (Info memory) {
        return info[token];
    }

    function getTokens() external view returns (address[] memory) {
        return tokens;
    }
}
