# Twitter-Like Platform on Ethereum

This project implements a simplified version of a Twitter-like platform on the Ethereum blockchain using Solidity smart contracts. Users can create tweets, like and unlike tweets, and set up their profiles.

## Project Structure

The project consists of two Solidity smart contracts:

1. **Twitter.sol**: This contract manages tweets, likes, unlikes, and tweet lengths. It interacts with the second contract for user profile management.
   
2. **Profile.sol**: This contract handles user profiles, including setting and retrieving display names and bios.

## Usage
Creating a Tweet: Use the `make_tweet` function in the Twitter contract to create a new tweet.

Liking a Tweet: Call the `likeTweet` function in the Twitter contract to like a tweet.

Unliking a Tweet: Call the `unlikeTweet` function in the Twitter contract to unlike a tweet.

Setting up a Profile: Use the `setProfile` function in the Profile contract to set up your profile with a display name and bio.

Viewing Profiles: Call the `getProfile` function in the Profile contract to retrieve a user's profile information.

## Contributing
Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
