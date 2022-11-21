import UIKit

var greeting = "Hello, playground"

func printHelp() {
    let message = """
    Welcome to MyApp

Run this app
"""
    
    print(message)
}

printHelp()

func square(number:Int){
    print(number * number)
}
square(number: 8)

func calculateWages(people: Int) {
    let total = people * 30_000
    print("The total is \(total)")
}
calculateWages(people: 50)

func square2(number:Int) -> Int {
    return number * number
}

let result = (rez1:square2(number: 8), rez2: square2(number: 4))

func getUser() -> [String] {
     return ["Taylor", "Swift"]
}
let user = getUser()
print(user[1])

func getUser2() -> [String: String] {
    
    ["first": "Taylor", "last": "Swift"]
}
let user2 = getUser2()
print(user2["first"]!)

func square3(number3: Int) -> Int {
    return number3 * number3
}

let result2 = square3(number3: 8)

func sayHello(brr name: String) {
    print("Hello \(name)!")
}

sayHello(brr: "Miran")

func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")

func greet2(_ person: String, nicely: Bool = true){
    if nicely == true {
        print("Hello, \(person)!")
        
    } else {
        print("Oh no, its \(person) again ...")
    }
}

func square4(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square4(numbers: 1, 2, 3, 4)

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You cant use that password")
}

var myNum = 10

func doubleInPlace(number: inout Int){
    number *= 2
}


doubleInPlace(number: &myNum)

print(myNum)
