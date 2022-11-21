import UIKit
import Foundation

var greeting = "Hello, playground"

struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic spoort"
        }
    }
}

var tennis = Sport(name: "Tennis", isOlympicSport: true)
print(tennis.name)

tennis.name = "Lawn tennis"

let chessBoxing = Sport(name: "chess", isOlympicSport: false)
print(chessBoxing.olympicStatus)

struct Progress {
    var task: String
    var amount: Int {
        didSet
        {
            print("\(task) is now \(amount)% cmoplete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 60

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}


var city = City(population: 9000)
city.collectTaxes()

struct Person {
    var name: String
    
    /* ukoliko zelimo promijeniti prperty moramo koristiti mutating */
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

let string = "do or do not, there is no try"

print(string.count)
print(string.hasPrefix("do"))
print(string.uppercased())
print(string.sorted())

var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)


struct User {
    var name = "Anonymous"
    var age: Int
}
let twostraws = User( age: 38)

struct Dog {
    var breed: String
    var cuteness: Int
    var rating: String {
        if cuteness < 3 {
            return "That's a cute dog!"
        } else if cuteness < 7 {
            return "That's a really cute dog!"
        } else {
            return "That a super cute dog!"
        }
    }
}
let luna = Dog(breed: "Samoyed", cuteness: 2)
luna.rating

struct User2 {
    var username: String
    
    init() {
        username = "Anonymus"
        print("Creating a new user")
    }
}

var user = User2()
user.username = "twostraws"


struct User3 {
    var name: String
    var yearsActive = 0
}

extension User3 {
    
    init() {
        self.name = "Anonymus"
        print("Creatin anonymus")
    }
}

let roslin = User3(name: "Laura Roslin")
let anonymus = User3()

/*self.name -> property, name -> parametar*/

struct Person2 {
    var name: String
    
    init(name: String) {
      print("\(name) was born")
        
        self.name = name
    }
}

var person2 = Person2(name: "Miran")
var person3 = Person2(name: "Vedran")

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person4 {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String){
        self.name = name
    }
    
}

var ed = Person4(name: "Ed")
ed.familyTree

struct Starship {
    var name: String
    var maxWarp: Double = 0
    init(starshipName: String) {
        name = starshipName
        
    }
}
var voyager = Starship(starshipName: "nasns")
voyager.maxWarp = 5


struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
    
}

let edo = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)

struct Pers {
   private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ebd = Pers(id: "12234")

ebd.identify()

struct RebelBase {
    private var location: String
    private var peopleCount: Int
    init(location: String, people: Int) {
        self.location = location
        self.peopleCount = people
    }
}
let base = RebelBase(location: "Yavin", people: 1000)
 
