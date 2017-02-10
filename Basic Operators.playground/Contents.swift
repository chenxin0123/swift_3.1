//: Playground - noun: a place where people can play

import UIKit


let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

/**
 The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
 
 (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
 (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
 (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
 */

var a:Int? = 2
var b = 3
var c = a ?? b // var c = (a != nil ? a! : b)

for index in 1...5 {// [1,5]
    print("\(index) times 5 is \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {//[a,count)
    print("Person \(i + 1) is called \(names[i])")
}
