import UIKit

var greeting = "Hello, playground"
greeting = "Goodbye"
var age = 38
var population = 8_000_000

var str11 = """
This goes
over multiple
lines
"""

var str2 = """
This goes \
over multiple \
lines
"""

var pi = 3.141

var awesoome=true

var score = 85
var result = "Your score was \(score)"
var results = "The test results are here: \(result)"

let taylot = "swift"
/*taylot = "brr"*/

let str = "Hello, playground"
let album: String = "Reputation"
let height: Int = 1989
let taylorRocks: Bool = true

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john,paul,george,ringo]
beatles[1]

let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red","green", "blue","red","green"])


var name=(first:"Taylor",last:"Swift")
name.0
name.first
name.first = "Miran"
name

let address = (house: 555, street:"Taylor Swift Avenue", city: "Nashville")

let set = Set(["aardwark","astronaut","azalea"])

/* Kako dobiti varijablu prvu drugu trecu u setu*/

let pythons = ["Eric","Graham","Miran","Eric"]

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

heights["Taylor Swift"]

var albums: [String] = ["Red", "Fearless"]
var users: [String:String] = ["id":"Twostraws"]
var books : Set<String> = Set([
"The bluest Eye",
"Foundation",
"Girl, Woman, Other"

])
/*Moramo li koristiti annottiation i je li bolje*/

let favouriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla",
    
]


favouriteIceCream["Paul"]
favouriteIceCream["Paul",default: "Unknown"]

var teams = [String: String]()
teams["Paul"] = "Red"

var rez = [Int]()
var words = Set<String>()
var numbers = Set<Int>()

var score2 = Dictionary<String,Int>()
var result2 = Array<Int>()

let result3 = "failure"
let result4 = "fail"
let result5 = "failed"

enum Result {
    case success
    case failure
}
let result6 = Result.failure

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)
let planetOrder = Planet.mars
    .rawValue


