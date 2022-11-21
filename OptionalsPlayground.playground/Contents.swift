import UIKit

var age: Int? = nil
age = 38

var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missiinng name")
}

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("you didnt provide a name")
        return
    }
    print("Hello, \(unwrapped)")
}

greet(nil)
greet("Miran")

let currentDestination: String? = nil
if let destination = currentDestination {
    print("We're walking to \(destination).")
} else {
    print("We're just wandering.")
}

func username(for id: Int?) -> String? {
    guard let id = id else {
        return nil
    }
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
if let user = username(for: 1989) {
    print("Hello, \(user)!")
}

let str = "5"
let num = Int(str)!

let godine: Int! = nil

func usernam(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
        
    } else {
        return nil
    }
}

let user = usernam(for: 15) ??  "Anonymous"

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()



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
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("result was \(result)")
} else {
    print("d oh")
}

try! checkPassword("secret")
print("OK")

let string = "5"
let numb = Int(str)

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

var person = Person(id: "1234567892")

class Animal {}
class Fish: Animal {}

class Dog: Animal {
    func makeNoise () {
        print("Woof")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

let shoppingList = ["eggs", "tomatoes", "grapes"]
let firstItem = shoppingList.first?.appending(" are on my shopping list")
