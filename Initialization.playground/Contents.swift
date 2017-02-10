//: Playground - noun: a place where people can play

import UIKit

/// When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
struct Fahrenheit {
    var temperature: Double = 1
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit”

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0”

/// “initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.”
struct Color {
    let red, green, blue: Double
    init(_ red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}


let magenta = Color(1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

/// Optional Property Types
/// “You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.”
/// “For class instances, a constant property can be modified during initialization only by the class that introduces it. It cannot be modified by a subclass.”

/// Default Initializers
/// “Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself”
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

/// “Memberwise Initializers for Structure Types”
/// “Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers.”
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

/// If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(_ center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/// Designated Initializers and Convenience Initializers
/** 
Rule 1
A designated initializer must call a designated initializer from its immediate superclass.

Rule 2
A convenience initializer must call another initializer from the same class.

Rule 3
A convenience initializer must ultimately call a designated initializer.
*/

/// Two-Phase Initialization
/**
Safety check 1
A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.

As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.

Safety check 2
A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

Safety check 3
A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

Safety check 4
An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization[…] 
 */
/**
 Phase 1
 “A designated or convenience initializer is called on a class.
 Memory for a new instance of that class is allocated. The memory is not yet initialized.
 A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
 The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 This continues up the class inheritance chain until the top of the chain is reached.
 Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
 
 Phase 2
 Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.”
 */

/// “Initializer Inheritance and Overriding”

/// “You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.”

/// Automatic Initializer Inheritance

/**
 “Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
 
 Rule 1
 If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
 
 Rule 2
 If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
 
 These rules apply even if your subclass adds further convenience initializers.”
 
 */

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 111)
    }
}

let oneMysteryItem = RecipeIngredient()
oneMysteryItem.quantity
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

/// Failable Initializers
/// “You cannot define a failable and a nonfailable initializer with the same parameter types and names.”

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

enum TemperatureUnita {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

/// “You can override a failable initializer with a nonfailable initializer but not the other way around.”
/// “Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

/// “The init! Failable Initializer”
/// “You can delegate from init? to init! and vice versa”
/// “and you can override init? with init! and vice versa. You can also delegate from init to init!, ”

/// “Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:”

class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

/// “Setting a Default Property Value with a Closure or Function”

/**
 “if you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.”
 
class SomeClass {
    let someProperty: SomeType = {
    // create a default value for someProperty inside this closure
    // someValue must be of the same type as SomeType
    return someValue
    }()
} */

class Chessboard {
    var x:Int!
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}