import UIKit

var greeting = "Hello, playground"

let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red","1989","Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

for _ in 1...5 {
    print("Play")
}

var number = 1

while number <= 20 {
        print (number)
    number += 1
}

print("Ready or not")

repeat {
    print(number)
    number += 1
    
} while number <= 20
            
print("Redy or not")
            
var countDown = 10

            while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("Im bored lets go now")
        break
    }
    countDown -= 1
}

print("Blast off")
            
outerLoop: for i in 1...10 {
    for j in 1...10{
        let product = i*j
        print("\(i) * \(j) is \(product)")
        
        if product == 50{
            print("Its a bullseye")
            break outerLoop
        }
            
    }
}

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

var counter = 0
while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}
