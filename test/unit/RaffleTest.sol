// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {DeployRaffle} from "script/DeployRaffle.s.sol";
import {Test} from "forge-std/Test.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "script/utils/HelperConfig.s.sol";

contract RaffleTest is Test {
    uint256 private constant INITIAL_BALANCE = 10 ether;
    uint256 private constant ENTRANCE_FEE = 0.01 ether;
    uint256 private constant INTERVAL = 30 seconds;

    address private immutable i_player = makeAddr("player");

    uint256 private entranceFee;
    uint256 private interval;
    bytes32 private keyHash;
    uint256 private subscriptionId;
    uint32 private callbackGasLimit;

    Raffle private raffle;
    HelperConfig private helperConfig;

    event Raffle_EnterRaffle(address indexed player);
    event Raffle_WinnerPicked(address indexed winner);

    function setUp() external {
        DeployRaffle deploy = new DeployRaffle();
        (raffle, helperConfig) = deploy.deployContract();

        HelperConfig.NetworkConfig memory networkConfig = helperConfig
            .getConfig();

        entranceFee = networkConfig.enterenceFee;
        interval = networkConfig.interval;
        keyHash = networkConfig.keyHash;
        subscriptionId = networkConfig.subscriptionId;
        callbackGasLimit = networkConfig.callbackGasLimit;

        vm.deal(i_player, INITIAL_BALANCE);
    }

    function testRaffleInitializationInOpenState() external view {
        Raffle.RaffleState raffleState = raffle.getRaffleState();

        assert(raffleState == Raffle.RaffleState.OPEN);
    }

    /** ENTER RAFLE */
    function testRaffleRevertIfDontPayEnought() external {
        //Arr
        vm.prank(i_player);
        //act / assert
        vm.expectRevert(Raffle.Raffle_SendMoreIntoRaffle.selector);
        raffle.enterRaffle();
    }

    function testRaffleRecordsPlayerWhenTheyEnter() external {
        //arrange
        vm.prank(i_player);
        //act
        raffle.enterRaffle{value: entranceFee}();
        address players = raffle.getPlayers(0);
        //assert
        assert(players == i_player);
    }

    function testEnteringRaffleEmitsEvent() external {
        vm.prank(i_player);
        vm.expectEmit(true, false, false, false, address(raffle));
        emit Raffle_EnterRaffle(i_player);
        raffle.enterRaffle{value: entranceFee}();
    }

    function testDontAllowPlayerToEnterWhenRaffleIsCalculating() external {
        vm.prank(i_player);
        raffle.enterRaffle{value: entranceFee}();
        vm.warp(block.timestamp + interval + 1);
        vm.roll(block.number + 1);
        raffle.pickWinner("");

        vm.expectRevert(Raffle.Raffle_NotOpen.selector);
        vm.prank(i_player);
        raffle.enterRaffle{value: entranceFee}();
    }

    /*** CHECK UPKEEP ***/
    function testUpKeepReturnsFalseIfHasNoBalance() external {
        //arrange
        vm.warp(block.timestamp + interval + 1);
        vm.roll(block.number + 1);
        //act
        (bool upkeepNeeded, ) = raffle.checkUpKeep("");
        //assert
        assert(!upkeepNeeded);
    }

    function testUpKeepReturnFalseIfRaffleIsNotOpen() external {
        //arrange
        vm.prank(i_player);
        raffle.enterRaffle{value: entranceFee}();
        vm.warp(block.timestamp + interval + 1);
        vm.roll(block.number + 1);
        raffle.pickWinner("");
        //act
        (bool upkeepNeeded, ) = raffle.checkUpKeep("");
        //assert
        assert(!upkeepNeeded);
    }

    //CHALLANGES
    // testUpKeepReturnFalseIfEnougTimeHasPassed
    // testUpKeepReturnTrueWhenParametersAreGood

    function testUpKeepReturnFalseIfEnoughTimeHasPassed() external {
        //arrange
        vm.prank(i_player);
        raffle.enterRaffle{value: entranceFee}();
        vm.warp(block.timestamp + 10);
        vm.roll(block.number + 1);
        //act
        (bool upkeepNeeded, ) = raffle.checkUpKeep("");
        //assert
        assert(!upkeepNeeded);
    }

    function testUpKeepReturnTrueWhenParametersAreGood() external {
        vm.prank(i_player);
        raffle.enterRaffle{value: entranceFee}();
        vm.warp(block.timestamp + interval + 1);
        vm.roll(block.number + 1);
        //act
        (bool upkeepNeeded, ) = raffle.checkUpKeep("");

        //assert
        assert(upkeepNeeded);
    }
}
