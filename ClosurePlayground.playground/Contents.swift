import UIKit

var greeting = "Hello, playground"

let driving = {
    print("im driving in my car")
}

driving()

let driving2 = { (place: String) in
    print("im goind go \(place) in my car")
}

driving2("London")


let drivingWithReturn = { (place: String) -> String in
    
    return "Im going to my \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

let driving4 = {
    print("im driving in my car")
}

func travel(action: () -> Void) {
    print("im gettin ready to go")
    action()
    print("i arrived")
    
}

travel(action: driving4)

// closure definition
var findSquare = { (num: Int) -> (Int) in
  var square = num * num
  return square
}

// closure call


print("Square:",findSquare(4))

func travel2(action: () -> Void) {
    print("im gettin ready to go")
    action()
    print("im ready")
}

travel2 {
    print("im driving in my car")
}

func travelling(action: (String) -> Void) {
    print("im getting ready to go")
    action("Zadubravlje")
    print("I arrived")
}

travelling { (place: String) in
    print("Im going to \(place) in my car")
}

func travell(action: (String) -> String) {
    print("im getting ready to go")
    let description = action("London")
    print(description)
    print("i arrived")
}

travell { (place: String) -> String in
    return "im going to \(place) in my fast car"
}

func travell2(action: (String) -> String) {
    print("im getting ready to go")
    let description = action("zagreb")
    print(description)
    print("i arrived")
}

travell2 {
    "im going to \($0) in my fast car"
}

func twoTravel(action: (String,Int) -> String) {
    print("Im getting ready")
    let desc = action("London", 60)
    print(desc)
    print("i ARRIVED")
    
}

twoTravel {
    "im going to \($0) at \($1) miles per hour "
}

func returnTravel() -> (String) -> Void {
    return {
        print("im going to \($0)")
    }
}

let result = returnTravel()
result("London")

func makeRandomGenerator() -> () -> Int {
    let  function = { Int.random(in: 1...10)}
    return function
}

let generator = makeRandomGenerator()
let random1 = generator()
print(random1)

func travels(action: (String,String) -> String) {
  print("I'm getting ready to go.")
  let description = action("London","New York")
  print(description)
  print("I arrived!")
}
travels {
  "I'm going to \($1) in my car"
}

func returnTravel2() -> (String) -> Void {
    var counter = 1
    return {
        print("im going to \($0)")
        counter += 1
    }
}

let result5 = returnTravel2()
result5("London")
result5("London")
result5("London")

func createTravelMethod(distance: Int) -> (String) -> Void {
    if distance < 5 {
        return {
            print("I'm walking to \($0).")
        }
    } else if distance < 20 {
        return {
            print("I'm cycling to \($0).")
        }
    } else {
        return {
            print("I'm driving to \($0).")
        }
    }
}
let travelMethod = createTravelMethod(distance: 4)
travelMethod("London")

func makeAdder() -> (Int) -> Void {
    var sum = 0
    return {
        sum += $0
        print("Sum is now \(sum)")
    }
}
let adder = makeAdder()
adder(5)
adder(3)
adder(6)

func storeTwoValues(value1: String, value2: String) -> (String) -> String {
    var previous = value1
    var current = value2
    return { new in
        let removed = previous
        previous = current
        current = new
        return "Removed \(removed)"
    }
}
let store = storeTwoValues(value1: "Hello", value2: "World")
let removed = store("Value Three")
print(removed)

‘func solution(num: Int) -> Int {
  var result: Int = 0
    
    for number in 0..<num {
      if (number % 3 == 0 || number % 5 == 0)
        {
          result += number
      }
        
    }
    return result
}

solution(num: 10)

