// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CryptoAlien.sol";

contract NftTest is Test {
    using stdStorage for StdStorage;

    CryptoAlien private nft;

    function setUp() public {
        nft = new CryptoAlien();
    }

    function testFailNoMintPricePaid() public {
        nft.safeMint(address(1), "ipfs://randomuriwhateverIPFS");
    }

    function testMintPricePaid() public {
        nft.safeMint{value: 0.001 ether }(address(1), "ipfs://randomuriwhateverIPFS");
    }

    function testFailMaxSupplyReached() public {
        uint256 slot = stdstore.target(address(nft)).sig("_tokenIdCounter()").find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(nft), loc, mockedCurrentTokenId);
        nft.safeMint{value: 0.001 ether }(address(1), "ipfs://randomuriwhateverIPFS");
            }

        function testFailMintToZeroAddress() public {
        nft.safeMint{value: 0.001 ether }(address(0), "ipfs://randomuriwhateverIPFS");
    }

    function testMintNewOwnerRegistered() public {
        nft.safeMint{value: 0.001 ether }(address(1), "ipfs://randomuriwhateverIPFS");
        uint256 slot = stdstore.target(address(nft)).sig(nft.ownerOf.selector).with_key(1).find();
        //uint160 can be directly converted to address
        uint160 ownerOfTokenIdOne = uint160(
            uint256(
                (vm.load(address(nft), bytes32(abi.encode(slot))))
            )
        );
        assertEq(address(ownerOfTokenIdOne), address(1));
    }

    function testBalanceIncremented() public {
        nft.safeMint{value: 0.001 ether }(address(1), "ipfs://randomuriwhateverIPFS");
        uint256 slotBalance = stdstore.target(address(nft)).sig(nft.balanceOf.selector).with_key(address(1)).find();
        uint256 balanceFirstMint = uint256(vm.load(address(nft), bytes32(slotBalance)));
        assertEq(balanceFirstMint, 1);

        nft.safeMint{value: 0.001 ether }(address(1), "ipfs://randomuriwhateverIPFS");
        uint256 balanceSecondMint = uint256(vm.load(address(nft), bytes32(slotBalance)));
        assertEq(balanceSecondMint, 2);
    }

    function testWithdrawalWorksAsOwner() public{
        address payee = address(0x1409);
        uint256 priorPayeeBalance = payee.balance;
        nft.safeMint{value: nft.PRICE() }(address(0x1337), "ipfs://randomuriwhateverIPFS");
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, nft.PRICE());

        uint256 nftBalance = address(nft).balance;
        // Withdraw the balance and assert it was transferred
        nft.transferOwnership(payee);
        vm.startPrank(nft.owner());
        nft.withdrawPayments();
        vm.stopPrank();
        assertEq(nft.owner().balance, priorPayeeBalance + nftBalance);
    }
    function testWithdrawalFailsAsNotOwner() public {
        // Mint an NFT, sending eth to the contract
        nft.safeMint{value: nft.PRICE() }(address(0x1337), "ipfs://randomuriwhateverIPFS");
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, nft.PRICE());
        // Confirm that a non-owner cannot withdraw
        vm.expectRevert("Ownable: caller is not the owner");
        vm.startPrank(address(0xd3ad));
        nft.withdrawPayments();
        vm.stopPrank();
    }
}
