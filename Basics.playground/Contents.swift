//: Playground - noun: a place where people can play

import UIKit

let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0, y = 0.0, z:Int = 0
var welcomeMsg: String
welcomeMsg = "WELCOME"

var r, b, g: Double //rbg都是double


/**
 “Constant and variable names cannot contain whitespace characters, mathematical symbols, arrows, private-use (or invalid) Unicode code points, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name.”
 */
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
var `Int8` = 100 // 使用关键字作为变量名 极其不推荐

print(welcomeMsg)
print("welcomMsg = \(welcomeMsg)")

/**
“Unlike multiline comments in C, multiline comments in Swift can be nested inside other multiline comments. You write nested comments by starting a multiline comment block and then starting a second multiline comment within the first block. The second block is then closed, followed by the first block:
*/
/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. 
 */

let minValue = UInt8.min

let age = 20 // Int
let pi = 3.1415026 // Double
//let another = age + pi // 类型不匹配 报错啦
let another1 = Double(age) + pi
let another2 = age + Int(pi)
let another = 20 + 3.1415926


let decimal = 17
let binary = 0b10001
let octal = 0o21
let hexadecimal = 0x11

let f = 1.245e2
let hf = 0xfp3 // 15 x 2的3次方

// 方便阅读
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

let orangesAreOrange = true
let turnipsAreDelicious = false
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// Prints "Eww, turnips are horrible.”

/*
let i = 1
if i {
    // this example will not compile, and will report an error
}
*/
let i = 1
if i == 1 {
    // this example will compile successfully
}


let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error // 给statusCode, statusMessage赋值
let (justStatusCode, _) = http404Error

let sc = http404Error.0
let sm = http404Error.1

//“You can name the individual elements in a tuple when the tuple is defined:”
let http200 = (code:200, msg:"ok")
print(http200.msg)

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int” 因为possibleNumber不一定可以转为数字


// “You set an optional variable to a valueless state by assigning it the special value nil”
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value

var surveyAnswer : String? // 默认值为nil

/**
“If an optional has a value, it is considered to be “not equal to” nil:
 “Trying to use ! to access a nonexistent optional value triggers a runtime error. Always make sure that an optional contains a non-nil value before using ! to force-unwrap its value.”
 */
if convertedNumber != nil {
    // “ forced unwrapping of the optional’s value:”
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

/// Optional Binding
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

/// 可以同时引用多个可选绑定
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

/// implicitly unwrapped optional
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark”

//“You can still treat an implicitly unwrapped optional like a normal optional, to check if it contains a value:”
if assumedString != nil {
    print(assumedString)
}

/// error handling
func canThrowAnError() throws {
    // this function may or may not throw an error
}
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

/// Assertions
/// Assertions are disabled when your code is compiled with optimizations, such as when building with an app target’s default Release configuration in Xcode.
let a = 3
assert(a >= 0, "A person's age cannot be less than zero")
assert(a >= 0)