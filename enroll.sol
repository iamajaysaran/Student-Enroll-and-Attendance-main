// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract StudentRegister is ERC20{

constructor(uint256 initialSupply) ERC20("SUBJECT", "SUB") {
        _mint(msg.sender, initialSupply);
        owner=msg.sender;
    }
    

    //owner is a state variable

    address public owner;
  
  
    //mapping address as key to struct student with mapping name students

    mapping (address=>student)students;
  
    
    // a modifier onlyOwner is created to limit the access to function register to contract deployer
    
    modifier onlyOwner {
        require(msg.sender==owner);
        _;
    }

    
    // a struct student is defined
     
    struct student{
        
        address studentId;
        string  name;
        string course;
        bool isExist;
        bool attendance; 
    }

    function register(address studentId,string memory name,string memory course) public onlyOwner {
            
            // require statment to block multiple entry
             
            require(students[studentId].isExist==false,"ha.. ha... Fraud Not Possible,student details already registered and cannot be altered");
            
            // assigning the student details to a key (studentId)
             
            students[studentId]=student(studentId,name,course,true,true);
    }
    
    
    // function to get the details of a student when studentId is given
            
    function getStudentDetails(address studentId) public view returns (address,string memory,string memory){
        
        // returning studentId,name,course of student to corresponding key
          
        return(students[studentId].studentId,students[studentId].name,students[studentId].course);
    }

     function Attendancecheck(address to) view public returns (bool) {
        if(balanceOf(to) == 0){
            revert("you are not registerd to the class!!");
        }else{
            revert("you have joined the class!!");
        }
    }
}
