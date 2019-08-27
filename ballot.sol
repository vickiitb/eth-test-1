// understanding solidity using ballot example with own comments

pragma solidity >=0.4.22 <0.7.0;
//declaring solidity version for use

/// @title Voting with delegation.
contract Ballot {
    
//struct represents data-type like in db schema
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // state of persons vote, if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    // This is data type for single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    
    // declaring state variable that stores `Voter` struct for each possible address; all addresses mapped to Voter struct
    mapping(address => Voter) public voters;

    // array of Proposal structs, dynamically sized, we will push data here. Has to be storage array, can't be memory array
    Proposal[] public proposals;

    /// Create a function for looping through proposalNames to choose one and execute createProposal function
    function Ballox (bytes32[] memory proposalNames) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        // For each of the provided proposal names, create new proposal object
        for (uint i = 0; i < proposalNames.length; i++) {  //looping through proposalNames
            createProposal(proposalNames[i]);
            }
    }        
    
    // createProposal function creates temporary Proposal object and using proposals.push appends it to end of 'proposals' dynamic (storage) array
    function createProposal (bytes32 proposalName) public {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            require(msg.sender == chairperson);
            proposals.push(Proposal({
                name: proposalName,
                voteCount: 0
            }));
    }
}
