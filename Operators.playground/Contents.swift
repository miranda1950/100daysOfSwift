import UIKit

var greeting = "Hello, playground"

let firstScore = 12
let secondScore = 4
let thirdScore = 2.5
let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore
let reminder = 13 % secondScore

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gone"
let action = fakers + " fake"

let firstHalf = ["John","PPaul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

var score = 95
score -= 5

var quote = " My name is Miran"
quote += "\tMendelski"

let firstscore = 6
let secondscore = 4

firstscore == secondscore
firstscore != secondscore

"Tylorss" <= "Swift"

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack")
} else {
    print("Regular cards")
}

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print ("One of them is over 18")
}

let firstcard = 11
let secondcard = 10

print(firstcard == secondcard ? "Cards are the same" : "Cards are different")

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wear up warm")
case "sunny":
    print("Wear sunglasses")
default:
    print("Enjoy your day")
}

let Score = 85

switch score {
case 0..<50:
    print("You failed")
case 50..<85:
    print("You did OK")
default:
    print("You did great")

}
