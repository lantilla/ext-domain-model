//
//  ExtPersonTests.swift
//  SimpleDomainModelTests
//
//  Created by Lauren Antilla on 10/19/17.
//

import XCTest

class ExtPersonTests: XCTestCase {
    func testConvertiblePerson() {
        // Person with job
        let maria = Person(firstName: "Maria", lastName: "Smith", age: 27)
        maria.job = Job(title: "Chef", type: Job.JobType.Salary(1010))
        XCTAssert(maria.description == "MariaSmith27ChefSalary(1010)")
        // Person without job
        let sam = Person(firstName: "Sam", lastName: "Jones", age: 52)
        XCTAssert(sam.description == "SamJones52")
        // Person with job and spouse
        maria.spouse = Person(firstName: "Tom", lastName: "Smith", age: 29)
        XCTAssert(maria.description == "MariaSmith27ChefSalary(1010)TomSmith29")
        // Person with spouse
        sam.spouse = Person(firstName: "Martha", lastName: "Jones", age: 53)
        XCTAssert(sam.description == "SamJones52MarthaJones53")
    }
    
    func testConvertibleFamily() {
        // spouse 1 with job, spouse 2
        let taylor = Person(firstName: "Taylor", lastName: "Smith", age: 25)
        taylor.job = Job(title: "Artist", type: Job.JobType.Hourly(25.00))
        let nathan = Person(firstName: "Nathan", lastName: "Smith", age: 25)
        let family = Family(spouse1: taylor, spouse2: nathan)
        XCTAssert(family.description == "TaylorSmith25ArtistHourly(25.0)NathanSmith25")
        // spouse 1 and spouse 2 with job
        nathan.job = Job(title: "Writer", type: Job.JobType.Salary(1000))
        XCTAssert(family.description == "TaylorSmith25ArtistHourly(25.0)NathanSmith25WriterSalary(1000)")
        // with one child
        let tyler = Person(firstName: "Tyler", lastName: "Smith", age: 2)
        let _ = family.haveChild(tyler)
        XCTAssert(family.description == "TaylorSmith25ArtistHourly(25.0)NathanSmith25WriterSalary(1000)TylerSmith2")
    }
}

