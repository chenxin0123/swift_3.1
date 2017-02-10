//: Playground - noun: a place where people can play

import UIKit

/// “In Swift, errors are represented by values of types that conform to the Error protocol.”

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
/// func canThrowErrors() throws -> String {}
/// func cannotThrowErrors() -> String {}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
/// “You write a pattern after catch to indicate what errors that clause can handle. If a catch clause doesn’t have a pattern, the clause matches any error and binds the error to a local constant named error. ”
/// “The catch clauses don’t have to handle every possible error that the code in its do clause can throw. If none of the catch clauses handle the error, the error propagates to the surrounding scope. However, the error must be handled by some surrounding scope—either by an enclosing do-catch clause that handles the error or by being inside a throwing function.”

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// Prints "Insufficient funds. Please insert an additional 2 coins.”
func someThrowingFunction() throws -> Int {
    // ...
    return 0
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

/**
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
 
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

 /// “You use a defer statement to execute a set of statements just before code execution leaves the current block of code. ”
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
 */

