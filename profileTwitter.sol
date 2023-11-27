// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile {
    struct UserProfile {
        string displayName;
        string bio;
    }
    
    mapping(address => UserProfile) profiles;

    function setProfile(string memory _displayName, string memory _bio) public {
        UserProfile memory newUser = UserProfile({
            displayName: _displayName,
            bio: _bio
        });
        
        profiles[msg.sender] = newUser;
    }

    function getProfile(address _user) public view returns (UserProfile memory) {
        return profiles[_user];
    }
}