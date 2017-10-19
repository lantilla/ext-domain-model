//
//  main.swift
//  ext-DomainModel
// Lauren Antilla
//  Created by Lauren Antilla on 10/19/16.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money

public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    var description: String {
        return currency + String(Double(amount))
    }
    
    public func convert(_ to: String) -> Money {
        var mon = Money(amount: self.amount, currency: self.currency)
        switch to {
        case "USD":
            if self.currency == "GBP" {
                mon.amount *= 2
            } else if self.currency == "EUR" {
                mon.amount = self.amount * 2 / 3
            } else if self.currency == "CAN" {
                mon.amount = self.amount * 4 / 5
            } 
            mon.currency = "USD"
        case "GBP":
            if self.currency == "USD" {
                mon.amount = self.amount / 2
            } else if self.currency == "EUR" {
                mon.amount = self.amount / 3
            } else if self.currency == "CAN" {
                mon.amount = self.amount * 2 / 5
            }
            mon.currency = "GBP"
        case "CAN":
            if self.currency == "GBP" {
                mon.amount = self.amount * 5 / 2
            } else if self.currency == "EUR" {
                mon.amount = self.amount * 5 / 6
            } else if self.currency == "USD" {
                mon.amount = self.amount * 5 / 4
            }
            mon.currency = "CAN"
        case "EUR":
            if self.currency == "GBP" {
                mon.amount *= 3
            } else if self.currency == "USD" {
                mon.amount = self.amount * 3 / 2
            } else if self.currency == "CAN" {
                mon.amount = self.amount * 6 / 5
            }
            mon.currency = "EUR"
        default:
            mon.amount = 0
            mon.currency = "nil"
            print("Currency \(to) not found")
        }
        return mon
    }
    
    public func add(_ to: Money) -> Money {
        if to.currency == self.currency {
            return Money(amount: self.amount + to.amount, currency: self.currency)
        } else {
            var mon = self.convert(to.currency)
            mon.amount += to.amount
            return mon
        }
    }
    
    public func subtract(_ from: Money) -> Money {
        if from.currency == self.currency {
            return Money(amount: self.amount - from.amount, currency: self.currency)
        } else {
            var mon = self.convert(from.currency)
            mon.amount = mon.amount - from.amount
            return mon
        }
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    var description: String {
        return title + String(describing: type)
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case JobType.Hourly(let wage):
            let salary = wage * Double(hours)
            return Int(salary)
        case JobType.Salary(let salary):
            return salary
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case JobType.Hourly(let wage):
            self.type = .Hourly(wage + amt)
        case JobType.Salary(let salary):
            self.type = .Salary(salary + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    var description: String {
        var jobStr = ""
        var spouseStr = ""
        if job != nil {
            jobStr = job!.title + String(describing: job!.type)
        }
        if spouse != nil {
            spouseStr = spouse!.firstName + spouse!.lastName + String(spouse!.age)
        }
        return firstName + lastName + String(age) + jobStr + spouseStr
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if age >= 16 {
                _job = value
            }
        }
    }
    
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if age >= 18 {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    open func toString() -> String {
        if self.job != nil && self.spouse != nil {
            return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job!) spouse:\(self.spouse!)]"
        } else {
            return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:nil spouse:nil]"
        }
    }
}

////////////////////////////////////
// Family
//
open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    var description: String {
        var result = ""
        for pers in members {
            var jobStr = ""
            if pers.job != nil {
                jobStr = pers.job!.title + String(describing: pers.job!.type)
            }
            result += pers.firstName + pers.lastName + String(pers.age) + jobStr
        }
        return result
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for person in members {
            if person.age > 21 {
                members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var tot = 0
        for person in members {
            if person.job != nil {
                tot += person.job!.calculateIncome(2000)
            }
        }
        return tot
    }
    
}

protocol CustomStringConvertible {
    var description: String { get }
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ from: Money) -> Money
}

extension Double {
    var amt: Double { return self }
    var USD: Money { return Money(amount: Int(amt), currency: "USD") }
    var EUR: Money { return Money(amount: Int(amt), currency: "EUR") }
    var GBP: Money { return Money(amount: Int(amt), currency: "GBP") }
    var CAN: Money { return Money(amount: Int(amt), currency: "CAN") }
    // YEN in specs, but not what was defined in class so changed to CAN here
}




