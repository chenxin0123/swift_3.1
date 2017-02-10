//: Playground - noun: a place where people can play

import UIKit

/// Type Identifier

typealias Point = (Int, Int)
let origin: Point = (0, 0)

/// Function Type

//var operation1: (lhs: Int, rhs: Int) -> Int     // Error
var operation2: (_ lhs: Int, _ rhs: Int) -> Int // OK
var operation3: (Int, Int) -> Int               // OK

var implicitlyUnwrappedString: String!
var explicitlyUnwrappedString: Optional<String>
// the two above are equivalent
var explicitlyUnwrappedString2: String?

// Because implicit unwrapping changes the meaning of the declaration that contains that type, optional types that are nested inside a tuple type or a generic type—such as the element types of a dictionary or array—can’t be marked as implicitly unwrapped.
//let tupleOfImplicitlyUnwrappedElements: (Int!, Int!)  // Error
let tupleOfImplicitlyUnwrappedElements: (Int?, Int?)  // OK
let implicitlyUnwrappedTuple: (Int, Int)!             // OK

//let arrayOfImplicitlyUnwrappedElements: [Int!]        // Error
let implicitlyUnwrappedArray: [Int]!                  // OK

/// Metatype Type

// SomeClass.self returns SomeClass itself, not an instance of SomeClass. And SomeProtocol.self returns SomeProtocol itself, not an instance of a type that conforms to SomeProtocol at runtime. You can use a type(of:) expression with an instance of a type to access that instance’s dynamic, runtime type as a value, as the following example shows

class SomeBaseClassa {
    class func printClassName() {
        print("SomeBaseClass")
    }
}
class SomeSubClassa: SomeBaseClassa {
    override class func printClassName() {
        print("SomeSubClass")
    }
}
let someInstancea: SomeBaseClassa = SomeSubClassa()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass
type(of: someInstancea).printClassName()
// Prints "SomeSubClass
// the metatype of the class type SomeClass is SomeClass.Type and the metatype of the protocol SomeProtocol is SomeProtocol.Protocol.
// Use an initializer expression to construct an instance of a type from that type’s metatype value. For class instances, the initializer that’s called must be marked with the required keyword or the entire class marked with the final keyword.

class AnotherSubClassa: SomeBaseClassa {
    let string: String
    required init(string: String) {
        self.string = string
    }
    override class func printClassName() {
        print("AnotherSubClass")
    }
}
let metatype: AnotherSubClassa.Type = AnotherSubClassa.self
let anotherInstance = metatype.init(string: "some string")

/// Literal Expression
/**
#file
String
The name of the file in which it appears.
#line
Int
The line number on which it appears.
#column
Int
The column number in which it begins.
#function
String
The name of the declaration in which it appears.
*/
func logFunctionName(string: String = #function) {
    print(string)
}
func myFunction() {
    logFunctionName() // Prints "myFunction()".
}

/// Capture Lists
/// “By default, a closure expression captures constants and variables from its surrounding scope with strong references to those values. You can use a capture list to explicitly control how values are captured in a closure.”

var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
}

a = 10
b = 10
closure()
// Prints "0 10”

class SimpleClass {
var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let closure2 = { [x] in
    print(x.value, y.value)
}

x.value = 10
y.value = 10
closure2()
// Prints "10 10”

// If the type of the expression’s value is a class, you can mark the expression in a capture list with weak or unowned to capture a weak or unowned reference to the expression’s value
// myFunction { print(self.title) }                    // strong capture
// myFunction { [weak self] in print(self!.title) }    // weak capture
// myFunction { [unowned self] in print(self.title) }  // unowned capture
// You can also bind an arbitrary expression to a named value in a capture list.
// myFunction { [weak parent = self.parent] in print(parent!.title) }

/// Selector Expression

// The method name and property name must be a reference to a method or a property that is available in the Objective-C runtime.
// #selector(method name)
// #selector(getter: property name)
// #selector(setter: property name)

class SomeClass: NSObject {
    let property: String
    @objc(doSomethingWithInt:)
    func doSomething(_ x: Int) {}
    
    init(property: String) {
        self.property = property
    }
}
let selectorForMethod = #selector(SomeClass.doSomething(_:))

let selectorForPropertyGetter = #selector(getter: SomeClass.property)

/// Key-Path Expression

@objc class SomeClass2: NSObject {
    var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

let c = SomeClass2(someProperty: 12)
let keyPath = #keyPath(SomeClass2.someProperty)

if let value = c.value(forKey: keyPath) {
    print(value)
}

// “When you use a key-path expression within a class, you can refer to a property of that class by writing just the property name, without the class name.

extension SomeClass2 {
    func getSomeKeyPath() -> String {
        return #keyPath(someProperty)
    }
}
print(keyPath == c.getSomeKeyPath())

// “Like a function, an initializer can be used as a value. For example:

// Type annotation is required because String has multiple initializers.
let initializer: (Int) -> String = String.init
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
print(oneTwoThree)
// Prints "123"

/// Initializer Expression

// If you specify a type by name, you can access the type’s initializer without using an initializer expression. In all other cases, you must use an initializer expression.
let s1 = Int.init(3)  // Valid
let s2 = Int(1)       // Also valid

let s3 = type(of: 3).init(7)  // Valid
//let s4 = type(of: 3)(5)       // Error

/// Dynamic Type Expression

class SomeBaseClass {
class func printClassName() {
    print("SomeBaseClass")
}
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}

let someInstance: SomeBaseClass = SomeSubClass()
// someInstance has a static type of SomeBaseClass at compile time, and
// it has a dynamic type of SomeSubClass at runtime
type(of: someInstance).printClassName()
// Prints "SomeSubClass"

/// Defer Statement
func f() {
    defer { print("First") }
    defer { print("Second") }
    defer { print("Third") }
}
f()
// Prints "Third"
// Prints "Second"
// Prints "First”

/// Availability Condition

/**
 if #available(platform name version, ..., *) {
 statements to execute if the APIs are available
 } else {
 fallback statements to execute if the APIs are unavailable
 }
 */

/// Rethrowing Functions and Methods

// A function or method can be declared with the rethrows keyword to indicate that it throws an error only if one of its function parameters throws an error. These functions and methods are known as rethrowing functions and rethrowing methods. Rethrowing functions and methods must have at least one throwing function parameter.

func someFunction(callback: () throws -> Void) rethrows {
    try callback()
}
// A rethrowing function or method can contain a throw statement only inside a catch clause. This lets you call the throwing function inside a do-catch block and handle errors in the catch clause by throwing a different error.
// the catch clause must handle only errors thrown by one of the rethrowing function’s throwing parameters.
// the following is invalid because the catch clause would handle the error thrown by alwaysThrows().
/**
func alwaysThrows() throws {
    throw SomeError.error
}
func someFunction(callback: () throws -> Void) rethrows {
    do {
        try callback()
        try alwaysThrows()  // Invalid, alwaysThrows() isn't a throwing parameter
    } catch {
        throw AnotherError.error
    }
}
 */

/// Enumerations with Cases of Any Type

// Enumeration cases that store associated values can be used as functions that create instances of the enumeration with the specified associated values. And just like functions, you can get a reference to an enumeration case and apply it later in your code.

enum Number {
    case integer(Int)
    case real(Double)
}
let f1 = Number.integer
// f is a function of type (Int) -> Number

// Apply f to create an array of Number instances with integer values
let evenInts: [Number] = [0, 2, 4, 6].map(f1)
