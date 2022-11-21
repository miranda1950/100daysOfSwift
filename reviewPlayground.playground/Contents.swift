import UIKit

var greeting = "Hello, playground"

var testVar = "two"

switch(testVar) {

case "hello":

    print("hello match number 1")

    fallthrough

case "two":

    print("two in not hello however the above fallthrough automatically always picks the     case following whether there is a match or not! To me this is wrong")

default:

    print("Default")
}



/*func persistence(for num: Int) -> Int {
    
    var number = num
    var array = [Int]()
    array.append(num % 10)
    var result: Int
    var rez = [Int]()
    
    while number >= 10 {
        number = number/10
        array.insert(number%10, at: 0)
        print(array)
    }
    print(array)
    
    
        
    for items in 0..<array.count {
      result =  array[0] * array[1]
        
        print(result)
       return result
        
    }
    print(result)
    
    
   return 0
}
persistence(for: 43) */



