//: Playground - noun: a place where people can play

import UIKit

/** Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when they are created. In the CompassPoint example above, north, south, east and west do not implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are fully-fledged values in their own right, with an explicitly-defined type of CompassPoint. */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

/** Multiple cases can appear on a single line, separated by commas: */

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins”

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless”
/** You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed.
This can be read as:

Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String. */

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP.”
/** If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single var or let annotation before the case name, for brevity: */

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP.

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
/** Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so. */

enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
/** In the example above, Planet.mercury has an explicit raw value of 1, Planet.venus has an implicit raw value of 2, and so on. */

/** When strings are used for raw values, the implicit value for each case is the text of that case’s name. */
enum CompassPoint2: String {
    case north, south, east, west
}

let earthsOrder = Planet2.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint2.west.rawValue
// sunsetDirection is "west”

/** Not all possible Int values will find a matching planet, however. Because of this, the raw value initializer always returns an optional enumeration case. */
let possiblePlanet = Planet2(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus

let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/** You can also write indirect before the beginning of the enumeration, to enable indirection for all of the enumeration’s cases that need it:”
 */

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
