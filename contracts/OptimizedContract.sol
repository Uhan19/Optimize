// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract OptimizedContract {
    
    uint256 public totalHeadCount;
    uint256 public totalBudget;

    struct Department {
        uint256 headCount;
        uint256 budget;
    }

    uint256 constant NUM_DEPTS = 20;
        
    Department[NUM_DEPTS + 1] departments;

    function setHeadCount(uint256 deptNum, uint256 newCount) external {
        require(deptNum > 0 && deptNum <= NUM_DEPTS, "invalid deptNum");
        Department storage department = departments[deptNum];
        totalHeadCount -= department.headCount;
        department.headCount = newCount;
        totalHeadCount += department.headCount;
    }

    function setBudget(uint256 deptNum, uint256 newBudget) external {
        require(deptNum > 0 && deptNum <= NUM_DEPTS, "invalid deptNum");
        Department storage department = departments[deptNum];
        totalBudget -= department.budget;
        department.budget = newBudget;
        totalBudget += department.budget;
    }

    function budgetPerHeadExceedsDept(uint256 deptNum, uint256 budgetPerHead) public view returns (bool)
    {
        require(deptNum > 0 && deptNum <= NUM_DEPTS, "invalid deptNum");
        Department storage department = departments[deptNum];
        return department.headCount > 0 && budgetPerHead > ( department.budget / department.headCount );
    }
    
    function budgetPerHeadExceedsOverall(uint256 budgetPerHead) public view returns (bool)
    {
        return totalHeadCount > 0 && budgetPerHead > ( totalBudget / totalHeadCount );
    }
    
    function budgetPerHeadExceedsDeptOrOverall(uint256 deptNum, uint256 budgetPerHead) external view returns (bool) {
        require(deptNum > 0 && deptNum <= NUM_DEPTS, "invalid deptNum");
        return budgetPerHeadExceedsOverall(budgetPerHead) || budgetPerHeadExceedsDept(deptNum, budgetPerHead);
    }

}
