// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }
    
    function getProfile(address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable {

    uint16 public MAX_LENGTH = 280; // "constant" means that variable cannot change

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint128 likes;
        uint128 unlikes;
    }

    IProfile profileContract;

    constructor(address _profileContract) Ownable(msg.sender) {
        profileContract = IProfile(_profileContract);
    }

    event TweetCreated(address author, string content, uint256 id, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint128 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint128 newUnlikeCount);


    mapping(address => Tweet[]) user_tweets;

    modifier onlyRegistered() {
        // IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(profileContract.getProfile(msg.sender).displayName).length > 0, "User not registered");
        _;
    }

    function make_tweet(string memory _tweet) external onlyRegistered { // with memory we stored data tweet to tempory memory

        require(bytes(_tweet).length <= MAX_LENGTH, "Tweet is too long!"); // checking length of bytes of tweet

        Tweet memory newTweet = Tweet({
            id: user_tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp, // we took timestamp from mined block where will be our contract
            likes: 0,
            unlikes: 0
        });

        user_tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.author, newTweet.content, newTweet.id, newTweet.timestamp);
    }

    function likeTweet(address author, uint256 id) external onlyRegistered {
        require(user_tweets[author][id].id == id, "Tweet does not exist"); // we put require here to check if putted id is equal to current id of tweet
        user_tweets[author][id].likes++;
        emit TweetLiked(msg.sender, author, id, user_tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external onlyRegistered {
        require(user_tweets[author][id].id == id, "Tweet does not exist"); // we put require here to check if putted id is equal to current id of tweet
        user_tweets[author][id].unlikes++;
        emit TweetUnliked(msg.sender, author, id, user_tweets[author][id].unlikes);
    }

    function get_tweet(uint _index) external view returns(Tweet memory) { // we use 'view' because function doesn't modify anything in blockchain and it allow us be gas efficient
        return user_tweets[msg.sender][_index];
    }

    function get_all_tweets(address _user) external view returns(Tweet[] memory) { // we use 'view' because function doesn't modify anything in blockchain and it allow us be gas efficient
        return user_tweets[_user];
    }

    function changeTweetLength(uint16 new_tweet_length) public onlyOwner {
        MAX_LENGTH = new_tweet_length;
    }
    
    function getTotalReactions(address _user) public view returns(uint256) {
        
        uint256 totalLikes = 0;
        uint256 totalUnlikes = 0;

        for (uint i = 0; i < user_tweets[_user].length; i++) {
            totalLikes += user_tweets[_user][i].likes;
            totalUnlikes += user_tweets[_user][i].unlikes;
        }

        return totalUnlikes;
    }

}
