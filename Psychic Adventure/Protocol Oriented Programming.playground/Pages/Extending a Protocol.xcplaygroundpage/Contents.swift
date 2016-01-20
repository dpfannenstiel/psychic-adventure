//: [Previous](@previous)
/*:
# Extending Protocols

Protocols may be extended.
*/
import Foundation

//: Consider a simple protocol that generates a string value.
protocol SimpleMessage {
    func simple() -> String
}

//: We can supply two structs both of which have values.
//: Again very straight forward.
struct StringValue {
    var value:String
}

struct IntValue {
    var iValue:Int
}

//: Now we extend the structs in the same manner as the previous page.  Each of which presents information appropriate to their type and instance variables.
extension StringValue : SimpleMessage {
    func simple() -> String {
        return "Simple String:  " + value
    }
}

extension IntValue: SimpleMessage {
    func simple() -> String {
        return "Simple Int:  " + String(iValue)
    }
}

//: Generate one object of each.
let sv = StringValue(value: "Strings Only")
let iv = IntValue(iValue: 1701)

print(sv.simple())
print(iv.simple())

//: The struct instances output as expected.
//: This is where things get intersting.

//: While a protocol definition does not support method bodies, protocol extensions do.
extension SimpleMessage {
    func complex() -> String {
        return "Complex! - " + self.simple()
    }
}

//: Types conforming to the protocol may adopt the extension of the protocol.
extension StringValue {
    func complex() -> String {
        return "What madness is this!"
    }
}

//: Now the output has changed.
print(sv.complex())
print(iv.complex())
//: Since `StringValue` adopts the `complex()` function, that variant of the function is used.
//: `IntValue` does not so it utilizes the function from the `SimpleMessage` extension.

//: But what happens if the system loses the reference to the implementing types by assigning a value to a protocol instance?
let csv:SimpleMessage = sv
let civ:SimpleMessage = iv

//: Since each type adopts their own implemetation of `simple()`, the type specific method is used.
print(csv.simple())
print(civ.simple())

//: However, since our new `SimpleMessage` instance of the StringValue does not actually know about the StringValue struct, it utilises the `complex()` method from the `SimpleMessage` extension.
print(csv.complex())
print(civ.complex())

//: [Next](@next)
//:
//: [Introduction](Introduction)
