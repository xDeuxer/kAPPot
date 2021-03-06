//
//  kAPPotTests.swift
//  kAPPotTests
//
//  Created by macOS Mojave on 4/10/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import XCTest
import CoreLocation

@testable import kAPPot

class kAPPotTests: XCTestCase {

    func testGetDistanceFromUser(){
        
        let from: CLLocationCoordinate2D = CLLocationCoordinate2DMake(30.0375043, 31.2512934)
        let to: CLLocationCoordinate2D = CLLocationCoordinate2DMake(30.0101215,31.2309481)
        let testDistance = CLLocation.distance(from: from, to: to)
        
        XCTAssertEqual(round(testDistance/1000), 4)
        
    }

}

/*
 override func setUp() {
 // Put setup code here. This method is called before the invocation of each test method in the class.
 }
 
 override func tearDown() {
 // Put teardown code here. This method is called after the invocation of each test method in the class.
 }
 
 func testExample() {
 // This is an example of a functional test case.
 // Use XCTAssert and related functions to verify your tests produce the correct results.
 }
 
 func testPerformanceExample() {
 // This is an example of a performance test case.
 self.measure {
 // Put the code you want to measure the time of here.
 }
 }
 */
