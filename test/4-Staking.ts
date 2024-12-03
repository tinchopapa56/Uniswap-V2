import { ethers } from "hardhat";
import { expect } from "chai"



describe("Staking", () => {
    let Staking;
    let staking: any;
    let owner;
    let user1: any;
    let user2;
    let NFTCollection: any;
    let RewardsToken;

    beforeEach(async () => {
        [owner, user1, user2] = await ethers.getSigners();

        const rewardsToken = await ethers.getContractFactory("RewardToken");
        RewardsToken = await rewardsToken.deploy();

        const nftCollection = await ethers.getContractFactory("NFTCollection");
        NFTCollection = await nftCollection.deploy();

        Staking = await ethers.getContractFactory("Staking");
        staking = await ethers.deployContract("Staking", [NFTCollection.target, RewardsToken.target], {});

        await staking.waitForDeployment();
        await NFTCollection.mint(user1);
    })

    it("Stake NFTs", async () => {
        const stakeIDs = [10]
        await NFTCollection.connect(user1).approve(staking.target, stakeIDs[0]);
        await staking.connect(user1).stake(stakeIDs);
        
        const staker = await staking.stakers(user1, stakeIDs[0]);
        const res: boolean = await staking.isStaked(user1, stakeIDs[0])

        expect(res).to.equal(true);
    })

    if("should allow withdrawal", async() => {
        const stakeIDs = [10]
        await NFTCollection.connect(user1).approve(staking.target, stakeIDs[0]);
        await staking.connect(user1).stake(stakeIDs);
        await staking.connect(user1).withdraw(stakeIDs);

        const staker = await staking.stakers(user1.address);
        const res = await staking.isStaked(user1, stakeIDs);

        expect(res).to.equal(false);
    })

})
