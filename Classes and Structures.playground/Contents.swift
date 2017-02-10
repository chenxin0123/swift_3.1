//: Playground - noun: a place where people can play

import UIKit

/**
 An instance of a class is traditionally known as an object. However, Swift classes and structures are much closer in functionality than in other languages, and much of this chapter describes functionality that can apply to instances of either a class or a structure type. Because of this, the more general term instance is used.*/
/**
Classes and structures in Swift have many things in common. Both can:

Define properties to store values
Define methods to provide functionality
Define subscripts to provide access to their values using subscript syntax
Define initializers to set up their initial state
Conform to protocols to provide standard functionality of a certain kind

Classes have additional capabilities that structures do not:

Inheritance enables one class to inherit the characteristics of another.”
Type casting enables you to check and interpret the type of a class instance at runtime.
Deinitializers enable an instance of a class to free up any resources it has assigned.
Reference counting allows more than one reference to a class instance.
 
Structures are always copied when they are passed around in your code, and do not use reference counting.

*/

/// Definition Syntax
class SomeClass {
    // class definition goes here
}
struct SomeStructure {
    // structure definition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
/** Unlike Objective-C, Swift enables you to set sub-properties of a structure property directly. */
someVideoMode.resolution.width = 1280

/** Unlike structures, class instances do not receive a default memberwise initializer. */
let vga = Resolution(width: 640, height: 480)

/// Structures and Enumerations Are Value Types | Classes Are Reference Types

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide”

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide”
enum CompassPoint {
    case north, south, east, west
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east
if rememberedDirection == .west {
    print("The remembered direction is still .west")
}
// Prints "The remembered direction is still .west


let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0”

/// Identity Operators
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance.

/** In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. This means that data such as strings, arrays, and “dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.This behavior is different from Foundation: NSString, NSArray, and NSDictionary are implemented as classes, not structures. Strings, arrays, and dictionaries in Foundation are always assigned and passed around as a reference to an existing instance, rather than as a copy */

/** As a general guideline, consider creating a structure when one or more of these conditions apply:

The structure’s primary purpose is to encapsulate a few relatively simple data values.
It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
The structure does not need to inherit properties or behavior from another existing type.
Examples of good candidates for structures include:

The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.
In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.”

*/