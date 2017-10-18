//
//  main.swift
//  SimpleDomainModel
// Lauren Antilla
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
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
//
public struct Money {
  public var amount : Int
  public var currency : String
  
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
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

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
/*
////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
     if spouse1.spouse != nil && spouse2.spouse != nil {
         spouse1.spouse = spouse2
         spouse2.spouse = spouse1
     }
  }
  
  open func haveChild(_ child: Person) -> Bool {
     if spouse1.age > 21|| spouse2.age > 21 {
 
     }
 
  }
  
  open func householdIncome() -> Int {
 for i in members {
 
  }
}
*/




