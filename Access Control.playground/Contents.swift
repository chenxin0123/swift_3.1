//: Playground - noun: a place where people can play

import UIKit

/// Modules and Source Files”
// A module is a single unit of code distribution—a framework or application that is built and shipped as a single unit and that can be imported by another module with Swift’s import keyword.
// Each build target (such as an app bundle or framework) in Xcode is treated as a separate module in Swift.
// A source file is a single Swift source code file within a module
/**
 “Open access and public access enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework. The difference between open and public access is described below.
 Internal access enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure.
 File-private access restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.
 Private access restricts the use of an entity to the enclosing declaration. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.
 
 “Open access applies only to classes and class members, and it differs from public access as follows:
 
 Classes with public access, or any more restrictive access level, can be subclassed only within the module where they’re defined.
 Class members with public access, or any more restrictive access level, can be overridden by subclasses only within the module where they’re defined.
 Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined.
 Open class members can be overridden by subclasses within the module where they’re defined, and within any module that imports the module where they’re defined.”
 
 */

/// Default Access Levels : internal

/// “When you write an app with a unit test target, the code in your app needs to be made available to that module in order to be tested. By default, only entities marked as open or public are accessible to other modules. However, a unit test target can access any internal entity, if you mark the import declaration for a product module with the @testable attribute and compile that product module with testing enabled.”
/**
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
*/
/// “If you want to specify an explicit access level for a custom type, do so at the point that you define the type. ”

/// “The access control level of a type also affects the default access level of that type’s members (its properties, methods, initializers, and subscripts). If you define a type’s access level as private or file private, the default access level of its members will also be private or file private. If you define a type’s access level as internal or public (or use the default access level of internal without specifying an access level explicitly), the default access level of the type’s members will be internal.”

/// “A public type defaults to having internal members, not public members. If you want a type member to be public, you must explicitly mark it as such. This requirement ensures that the public-facing API for a type is something you opt in to publishing, and avoids presenting the internal workings of a type as public API by mistake.”

public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

/// “A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly.”
/// “The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type. You must specify the access level explicitly as part of the function’s definition if the function’s calculated access level does not match the contextual default.”

private func someFunction() -> (SomeInternalClass, SomePrivateClass)? {
    // function implementation goes here
    return nil
}

/// “The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to.”

/// “The types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration’s access level. You cannot use a private type as the raw-value type of an enumeration with an internal access level

/// “Nested types defined within a private type have an automatic access level of private. Nested types defined within a file-private type have an automatic access level of file private. Nested types defined within a public type or an internal type have an automatic access level of internal. If you want a nested type within a public type to be publicly available, you must explicitly declare the nested type as public.

/// “A subclass cannot have a higher access level than its superclass”
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

/// “A constant, variable, or property cannot be more public than its type. It is not valid to write a public property with a private type”

// If a constant, variable, property, or subscript makes use of a private type, the constant, variable, property, or subscript must also be marked as private:

private var privateInstance = SomePrivateClass()

// “Getters and setters for constants, variables, properties, and subscripts automatically receive the same access level as the constant, variable, property, or subscript they belong to.

// You can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript. You assign a lower access level by writing fileprivate(set), private(set), or internal(set) before the var or subscript introducer.”
// “This rule applies to stored properties as well as computed properties. Even though you do not write an explicit getter and setter for a stored property, Swift still synthesizes an implicit getter and setter for you to provide access to the stored property’s backing storage. Use fileprivate(set), private(set), and internal(set) to change the access level of this synthesized setter in exactly the same way as for an explicit setter in a computed property.”

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// Prints "The number of edits is 3

/* public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}
 */
/// “Custom initializers can be assigned an access level less than or equal to the type that they initialize. The only exception is for required initializers (as defined in Required Initializers). A required initializer must have the same access level as the class it belongs to.”

// A default initializer has the same access level as the type it initializes, unless that type is defined as public. For a type that is defined as public
// The default memberwise initializer for a structure type is considered private if any of the structure’s stored properties are private. Likewise, if any of the structure’s stored properties are file private, the initializer is file private. Otherwise, the initializer has an access level of internal.

// “If you define a public protocol, the protocol’s requirements require a public access level for those requirements when they are implemented. This behavior is different from other types, where a public type definition implies an access level of internal for the type’s members.”
// “If you define a new protocol that inherits from an existing protocol, the new protocol can have at most the same access level as the protocol it inherits from. ”

// “If a type is public, but a protocol it conforms to is internal, the type’s conformance to that protocol is also internal.”

// “Any type members added in an extension have the same default access level as type members declared in the original type being extended. ”
// “Alternatively, you can mark an extension with an explicit access-level modifier (for example, private extension) to set a new default access level for all members defined within the extension. This new default can still be overridden within the extension for individual type members.”

//“You cannot provide an explicit access-level modifier for an extension if you are using that extension to add protocol conformance. Instead, the protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension.”

// “The access level for a generic type or generic function is the minimum of the access level of the generic type or function itself and the access level of any type constraints on its type parameters.”

// “A type alias can have an access level less than or equal to the access level of the type it aliases. For example, a private type alias can alias a private, file-private, internal, public, or open type, but a public type alias cannot alias an internal, file-private, or private type.”

