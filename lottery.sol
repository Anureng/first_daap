pragma solidity >=0.7.0 <0.9.0;

contract Lottery{
address public manager;
address payable[] public participant;
constructor(){
    manager=msg.sender;
}
receive() external payable{
require(msg.value==1 ether);
participant.push(payable(msg.sender));
}
function getbalance() public view returns(uint){
    require(msg.sender==manager);
    return address(this).balance;
}
function random() public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participant.length)));                                                                    
}
function selectwinner() public{
    require(msg.sender==manager);
    require(participant.length>=3);
    uint r=random();
    address payable winner;
    uint index=r%participant.length;
    winner=participant[index];
    winner.transfer(getbalance());
    participant=new address payable[](0);
}
}
