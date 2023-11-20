// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./AccessControlManager.sol";
import "./ClientFactory2.sol";
contract ClientFactory1{
    AccessControlManager private accessControlManager;

    constructor(address _access_control_address)
    {
        accessControlManager = AccessControlManager(_access_control_address);
    }
    modifier checkClient() 
    {
        require(accessControlManager.hasRole(accessControlManager.CLIENT_ROLE(), msg.sender), "NA");
        _;
    }
    function createClientFactory2(bytes32 _client2_name, bytes32 _owner_name, address _parent_address, bytes32 _parent_name, bytes32 _data, bytes memory _signature)
    external 
    checkClient() 
    {
        accessControlManager.addClientContracts(_client2_name, _owner_name, address(new ClientFactory2(address(accessControlManager))), AccessControlManager.ContractType.clientfactory2, _parent_address, _parent_name, _data, _signature);
    }
}