//: [Previous](@previous)
/*:
# Conditional Extension

Protocols may be extended based on type conditions.  To begin let's set up our SimpleMessage protocol as shown in Extending a Protocol, in this case defined in the SimpleMessage files associated to this page.
*/
import Foundation

let sv = StringValue(value: "Strings Only")
let iv = IntValue(iValue: 1701)

print(sv.simple())
print(iv.simple())

print(sv.complex())
print(iv.complex())

let csv:SimpleMessage = sv
let civ:SimpleMessage = iv

print(csv.simple())
print(civ.simple())

print(csv.complex())
print(civ.complex())

//: A quick examination shows that the behavior to this point is identical.

//: Now we're going to define a second protocol to provide additional properties on the implementing type.
protocol StoresValue {
    var storedValue:String { set get }
}

//: By applying the protocol the type becomes, `StringValue: SimpleMessage, StoresValue`.
extension StringValue:StoresValue {
    var storedValue:String {
        get {
            return value + "🖖"
        }
        set {
            value = newValue + "🤘"
        }
    }
}


//: We can now further extend Simple message to only work with elements that confrom to the `StoresValue` protocol
extension SimpleMessage where Self : StoresValue {
    func veryComplex() -> String {
        return "Yowza!  This is a complex one. Here's a value: " + storedValue
    }
}

//: The veryComplex method presents itself correctly, however since neither SimpleMessage nor IntValue satisfy the requirements on the conditional extension, attempts to utilize them will result in errors.
print(sv.veryComplex())
// print(csv.veryComplex()) // COMPILER ERROR
// print(iv.veryComplex()) // COMPILER ERROR
// print(civ.veryComplex()) // COMPILER ERROR

//: [Next](@next)
//:
//: [Introduction](Introduction)
