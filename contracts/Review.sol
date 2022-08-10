// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReviewSystem {
    //maybe for one product there should be only one seller
    struct Product {
        string productName;
        string productDesc;
        uint productPrice;
        string productHash;
        uint avgRating;     //its the sum of all ratings, will 
        uint totalReviewed;
        address seller;
        address[] users;                                              //
    }
    struct UserInput {
                                    //parent comment?
        uint rating;
        string comments;
        uint dateOfReview;                                              //
        
        bool IsProductReviewedByUser;
    }
    
    Product newProduct;
    UserInput newInput;
    uint public TotalProducts;
    
    mapping(uint => Product)   productDetails;
    uint[]    public productIds;
    mapping(uint => mapping (address => UserInput)) userReview;
   
    event addProductEvent( uint pid, string pname );                 //sends an event to notify new review of a product
    event reviewProductEvent( uint pid, uint avgRating );           //sends an event to notify new avr rating of a product
    
    constructor() {
        TotalProducts = 0;
    }
    
    function addProduct(string memory pname, string memory pdesc, uint price, string memory imagehash) public {
        require(keccak256(bytes(pname)) != keccak256(""), "Product Name required !");

         TotalProducts++;
         uint pid = TotalProducts;
        
        newProduct.productName = pname;
        newProduct.productDesc = pdesc;
        newProduct.productPrice = price;
        newProduct.productHash = imagehash;
        newProduct.avgRating = 0;
        newProduct.totalReviewed = 0;
        newProduct.seller = msg.sender;

        productIds.push(pid);
        productDetails[pid] = newProduct;
        
        emit addProductEvent(TotalProducts, pname);
        
    }
    
    
    function getProduct(uint pid) public  view returns (Product memory) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        return productDetails[pid];
    }
     
    
    
    function reviewProduct(uint productId, uint urating, string memory ucomments, uint reviewDate) public {
        require(productId > 0, "Productid required !");
        require(urating > 0 && urating <= 5, "Product rating should be in 1-5 range !");
        require(userReview[productId][msg.sender].IsProductReviewedByUser == false, "Product already reviewed by user !");
        require(keccak256(bytes(productDetails[productId].productName)) != keccak256(""));


        Product storage oldProduct = productDetails[productId];


        oldProduct.avgRating += urating;
        oldProduct.totalReviewed++;
        oldProduct.users.push(msg.sender);

        newInput.rating = urating;
        newInput.comments = ucomments;
        newInput.dateOfReview = reviewDate;
        
        newInput.IsProductReviewedByUser = true;                                    ////
        
        userReview[productId][msg.sender] = newInput;
        
        
        emit reviewProductEvent(productId, urating);
    }
    
    
    function getProductAvgRating(uint pid) public view returns (uint ) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        //you could just sum them above and divide here
        return productDetails[pid].avgRating/productDetails[pid].totalReviewed;
    }
    
    function getCurrentUserComments(uint pid) public view returns (string memory ) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        
        return userReview[pid][msg.sender].comments;
         
    }
    
    function getCurrentUserRating(uint pid) public view returns (uint ) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        
        return userReview[pid][msg.sender].rating;
         
    }
    
    function getUserComments(uint pid, address user) public view returns (string memory ) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        
        return userReview[pid][user].comments;
         
    }
    
    function getUserRating(uint pid, address user) public view returns (uint ) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        
        return userReview[pid][user].rating;
         
    }
    
    function getUserDateOfReview(uint pid, address user) public view returns (uint) {
        require(pid > 0, "Productid required !");
        require(keccak256(bytes(productDetails[pid].productName)) != keccak256(""));
        
        return userReview[pid][user].dateOfReview;
         
    }
    
    function getAllProductPids() public view returns (uint[] memory) {
        return productIds;
    }

    function getAllUsersForProduct(uint pid) public view returns  (address[] memory){
       return productDetails[pid].users;
    }

   
    
    
}