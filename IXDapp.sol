// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IX {
    struct Post {
        uint256 id;
        address userAccount;
        string img_url;
        string title;
        string content;
        uint256 time;
    }

    mapping(address => Post[]) posts;
    Post[] oneDimensionPosts;

    address[] userAddresses;
    mapping(address => bool) isInUserAddresses;

    modifier checkContentLength(string memory _content) {
        require(bytes(_content).length < 250, "Content length is too long");
        _;
    }

    // set a post
    function setPost(string memory _img_url, string memory _title, string memory _content) public checkContentLength(_content) {
        Post memory newPost = Post(
                posts[msg.sender].length + 1, 
                msg.sender, 
                _img_url, 
                _title,
                _content,
                block.timestamp
            );

        posts[msg.sender].push(newPost);
        oneDimensionPosts.push(newPost);

        if (!isInUserAddresses[msg.sender]) {
            isInUserAddresses[msg.sender] = true;
            userAddresses.push(msg.sender);
        }
    }

    // get
    function getPosts() public view returns (Post[] memory) { 
        return oneDimensionPosts;
    }

    // get particular user posts
    function getUserPosts(address _userAccount) public view returns (Post[] memory) {
        return posts[_userAccount];
    }
}
