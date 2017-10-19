//
//  ExtJobTests.swift
//  SimpleDomainModelTests
//
//  Created by Lauren Antilla on 10/19/17.
//

import XCTest

import SimpleDomainModel

class ExtJobTests: XCTestCase {
    let job1 = Job(title: "Bus Driver", type: Job.JobType.Hourly(15.0))
    let job2 = Job(title: "Mechanical Engineer", type: Job.JobType.Salary(2408))
    
    func testConvertibleJob() {
        XCTAssert(job1.description == "Bus DriverHourly(15.0)")
        XCTAssert(job2.description == "Mechanical EngineerSalary(2408)")
    }
}
