//: [Previous](@previous)
/*:
# Defining Protocols

Within Swift it becomes convienient to identify two root concepts: Protocols and Types.
Protocols are a common interface which types are expected to conform to.
Types are actual things which may be instantiated.  Specifically they are Classes, Structs, and Enums.
*/
import Foundation

//: Person is a good analogy for a class as there will only ever be one.
class Person {
    var name:String
    var salary:Int
    init(name:String, salary:Int) {
        self.name = name
        self.salary = salary
    }
}

//: Movie is a good analogy for a struct as once its made many copies may exist.
struct Movie {
    var title:String
    var budget:Int
}

//: Rank is a good analogy for enums as it represents on of a finite set of values.
enum Rank:Int {
    case Redshirt = 0
    case RecurringCharacter
    case MainCast
    case MovieStar
    case SimpsonsVoice
}

//: Each of these items are also reasonably Promotable.
protocol Promotable {
    /// The return of the string is for instructional purposes only.
    /// Mutation is being used as we are modifying a struct.
    mutating func promote() -> String
}

//: Once the protocol is defined the individual types may adopt their own definition of the elements of the protocol.

extension Person: Promotable {
    func promote() -> String {
        salary += 500
        return self.name + "'s salary: \(salary)"
    }
}

extension Movie: Promotable {
    mutating func promote() -> String {
        budget += 25000
        return self.title + "'s budget: \(budget)"
    }
}

extension Rank: Promotable {
    mutating func promote() -> String {

        switch self {
        case .SimpsonsVoice:
            self = .Redshirt
        default:
            self = Rank(rawValue: self.rawValue + 1)!
        }
        
        return String(self)
    }
}

//: In this way each type may be treated as a collection without requiring inheritience.

var star = Person(name: "Patrick Stewart", salary: 1000)
var film = Movie(title: "X-Men", budget: 500000)
var rank = Rank.MainCast

print("\(star.name)'s salaray: \(star.salary)")
print("\(film.title)'s budget: \(film.budget)")
print("Rank: \(rank)")

let promotables:[Promotable] = [star, film, rank]
var results = [String]()
for var promotable in promotables {
    results.append(promotable.promote())
}

//: The resulting string show that each object has been promoted.
print(results)

//: ## `Self` Requirment in Protocols
//: An additional feature of Protocols is the use of `Self` as a type in parameters.  The `Self` type indicates that the function is only permissible on hetrogeneous objects.

protocol Valuation {
    func moreValuableThan(other:Self) -> Bool
}

//: A person is more valuable than another person if they make more (because people are terrible), unless one person is Batman, then it's Batman.
extension Person: Valuation {
    func moreValuableThan(other: Person) -> Bool {
        
        if other.name == "Batman" { return false }
        if self.name == "Batman" { return true }
        return self.salary > other.salary
        
    }

}

let batman = Person(name: "Batman", salary: 0)
batman.promote()

let starIsGreater = star.moreValuableThan(batman)

//: No one is more valuable than Batman.


//: A movie is more valuable than another if it's budget is higher (because movie studios are run by people, see above regarding terribleness).
extension Movie: Valuation {
    func moreValuableThan(other: Movie) -> Bool {
        return self.budget > other.budget
    }
}

let avengers = Movie(title: "Avenger", budget: 100000000)

let avengersIsGreater = avengers.moreValuableThan(film)

//: Well, they spent more on "Avengers", so I guess that's fair.

//: [Next](@next)
//:
//: [Introduction](Introduction)
