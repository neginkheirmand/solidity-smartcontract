function:
    pure: doesn't modify the blockchain in anyway 
    view: like pure but can at least read the variables and not change them

    - transfer function for some address, usually used like this: 
        owner.transfer(msg.value)
        here there will be "msg.value amount" of ether transfered to the owner
    - require function -> this comes from the solidity programming language and what it does is:
        every time this method is called inside a function the function will check the condition passed to it to see whether to let the code of the function run or not 
        this function also gets a string as input and will only use it if the condition is false meaning the function's excecution will stop and this string will be used as a message to notify the user 
        IF WE WANT TO STOP USING THE REQUIRE FUNCTION INSIDE OF THE FUNCTIONS DEPLOYED IN OUR SMART CONTRACT WE CAN ALSO USE MODIFIERS  
    - modifier are the require but in clean version and can be used as the modifier of a function
        


variables:
    uint and uin256 are the same
    address is sort of a username in blockchain corresponds to a user or a contract or a wallet
    payable is a specific modifier that lets some address actually receive ethereum cryptocurrency(THIS  MODIFIER IS ALSO USED FOR FUNCTIONS IN WHICH TRANSFER HAPPENS) -> also remember when trying to assign a value to a variable with this modifier you need to pass a **payable(address)**


we talked about  state variables and local variables and its good to mention that we also have something called **global variables**
like for example msg. These global variable are just exposed by solidity in every single smart contract available on the blockchain.
    msg.sender-> person who will call the smart contract
