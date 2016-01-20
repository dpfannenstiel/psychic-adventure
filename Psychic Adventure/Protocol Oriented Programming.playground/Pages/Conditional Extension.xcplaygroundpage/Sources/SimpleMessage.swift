import Foundation

public protocol SimpleMessage {
    func simple() -> String
}

public struct StringValue {
    public var value:String
    public init(value:String) {
        self.value = value
    }
}

public struct IntValue {
    public var iValue:Int
    public init(iValue:Int) {
        self.iValue = iValue
    }
}

extension StringValue : SimpleMessage {
    public func simple() -> String {
        return "Simple String:  " + value
    }
}

extension IntValue: SimpleMessage {
    public func simple() -> String {
        return "Simple Int:  " + String(iValue)
    }
}

extension SimpleMessage {
    public func complex() -> String {
        return "Complex! - " + self.simple()
    }
}

extension StringValue {
    public func complex() -> String {
        return "What madness is this!"
    }
}
