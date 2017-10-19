//
//  ExtMoneyTests.swift
//  SimpleDomainModelTests
//
//  Created by Lauren Antilla on 10/19/17.
//

import XCTest

import SimpleDomainModel

class ExtMoneyTests: XCTestCase {
    let money1 = Money(amount: 20, currency: "EUR")
    let money2 = Money(amount: 560, currency: "USD")
    let amtU = 230.5.USD
    let amtE = 53.0.EUR
    let amtG = 45.9.GBP
    let amtY = 1234.56.YEN
    
    func testConvertibleMoney() {
        XCTAssert(money1.description == "EUR20.0")
        XCTAssert(money2.description == "USD560.0")
    }

    func testExtension() {
        // using extension Double for USD
        XCTAssert(amtU.amount == Int(230.5))
        XCTAssert(amtU.currency == "USD")
        // using extension Double for EUR
        XCTAssert(amtE.amount == Int(53.0))
        XCTAssert(amtE.currency == "EUR")
        // using extension Double for GBP
        XCTAssert(amtG.amount == Int(45.9))
        XCTAssert(amtG.currency == "GBP")
        // using extension Double for YEN
        XCTAssert(amtY.amount == Int(1234.56))
        XCTAssert(amtY.currency == "YEN")
    }
    
    func testMathematics() {
        let moneyU1 = Money(amount: 500, currency: "USD")
        let moneyU2 = Money(amount: 234, currency: "USD")
        let moneyG = Money(amount: 46, currency: "GBP")
        // add USDs together
        let add1 = moneyU1.add(moneyU2)
        XCTAssert(add1.amount == 734)
        XCTAssert(add1.currency == "USD")
        // subtract USDs
        let subtract1 = moneyU1.subtract(moneyU2)
        XCTAssert(subtract1.amount == 266)
        XCTAssert(subtract1.currency == "USD")
       // add USD and GBP
       let add2 = moneyU1.add(moneyG)
       XCTAssert(add2.amount == 296)
       XCTAssert(add2.currency == "GBP")
        // subtract USD and GBP
        let subtract2 = moneyU1.subtract(moneyG)
        XCTAssert(subtract2.amount == 204)
        XCTAssert(subtract2.currency == "GBP")
    }
    
}

