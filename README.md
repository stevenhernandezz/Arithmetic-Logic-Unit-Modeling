# Arithmetic-Logic-Unit-Modeling
 This project focuses on an Arithmetic Logic Unit (ALU) with various flags and operations.
 
## Description 
 The ALU design is intended to support both unsigned and signed operations, providing functionality for arithmetic and boolean operations with associated flags.
 
 Flag Definitions
 - Overflow Flag: Indicates when a signed operation result exceeds the ALU's capacity. It is updated during arithmetic (addition/subtraction) operations based on sign bit discrepancies.
 - Carry Flag: Reflects carry-out conditions during addition/subtraction, following Intel's definition for subtraction borrow.
 - Zero Flag: Set when the ALU output results in all zeros.
 - Negative Flag: Set when the ALU output's Most Significant Bit (MSB) is logic one.
   
Operation Behavior
 - Overflow and Carry flags update based on arithmetic operations (addition/subtraction).
 - Boolean operations update Zero and Negative flags.
 - The ALU has an Output Enable (OE) input to control data output mode (high impedance when disabled).
   
Design Implementation
 - The ALU supports operations with both unsigned and signed numbers, with differences managed using conditional compilation (`ifdef).
   
Implementation Approach:
 - Design the ALU module to handle arithmetic and boolean operations.
 - Implement flag logic to manage Overflow, Carry, Zero, and Negative conditions.
 - Integrate Output Enable (OE) control for data bus tristate functionality.
   
Testing:
 - Verify ALU functionality with test cases covering:
 - Arithmetic operations (addition, subtraction).
 - Boolean operations (AND, OR, XOR).
 - Flag updates based on operation results.
 - High impedance state when OE is disabled.
   
Simulation and Analysis:
 - Simulate the ALU design using Verilog/SystemVerilog testbenches.
 - Analyze simulation results to validate flag behavior, data outputs, and ALU operation under different conditions (unsigned vs. signed).
 


## Dependencies
### Software
* https://mobaxterm.mobatek.net/

### Author
* Steven Hernandez
  - www.linkedin.com/in/steven-hernandez-a55a11300
  - https://github.com/stevenhernandezz
