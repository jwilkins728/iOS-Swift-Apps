//
//  Retro_CalculatorTests.swift
//  Retro-CalculatorTests
//
//  Created by Ralph Cachero on 4/1/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import XCTest

class Retro_CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAudioService() {
        
        XCTAssertNotNil(AudioService.instance)
        XCTAssertNotNil(AudioService.instance.pathForResource("btn", fileType: "wav"))
        XCTAssertNotNil(AudioService.instance.btnUrl)
        XCTAssertNil(AudioService.instance.createPlayerWithUrl(NSURL(string: "")!))
        XCTAssertNotNil(AudioService.instance.createPlayerWithUrl(AudioService.instance.btnUrl!))
        
        XCTAssertFalse(AudioService.instance.playCurrentSoundFX())
        
        XCTAssertNil(AudioService.instance.soundFXPlayer)
        AudioService.instance.soundFXPlayer = AudioService.instance.createPlayerWithUrl(AudioService.instance.btnUrl!)
        XCTAssertNotNil(AudioService.instance.soundFXPlayer)
        XCTAssertTrue(AudioService.instance.playCurrentSoundFX())
    }
    
    func testCalcService() {
        
        XCTAssertNotNil(CalcService.instance)
        
        XCTAssertEqual(CalcService.Operation.Add.rawValue, "+", "Incorrect operator")
        XCTAssertEqual(CalcService.Operation.Divide.rawValue, "/", "Incorrect operator")
        XCTAssertEqual(CalcService.Operation.Empty.rawValue, "Empty")
        XCTAssertEqual(CalcService.Operation.Multiply.rawValue, "*", "Incorrect operator")
        XCTAssertEqual(CalcService.Operation.Subtract.rawValue, "-", "Incorrect operator")
        
        XCTAssertNil(CalcService.instance.multiply("jkl", numStrB: "jkl"))
        XCTAssertNotNil(CalcService.instance.multiply("10", numStrB: "15"))
        XCTAssertEqual(CalcService.instance.multiply("5", numStrB: "5"), "25.0")
        
        XCTAssertNil(CalcService.instance.divide("adsf", numStrB: "adsf"))
        XCTAssertNotNil(CalcService.instance.divide("55.0", numStrB: "5.0"))
        XCTAssertEqual(CalcService.instance.divide("10.0", numStrB: "5"), "2.0")
        
        XCTAssertNil(CalcService.instance.subtract("asdf", numStrB: "adf"))
        XCTAssertNotNil(CalcService.instance.subtract("20", numStrB: "10"))
        XCTAssertEqual(CalcService.instance.subtract("25", numStrB: "10"), "15.0")
        
        XCTAssertNil(CalcService.instance.add("asdf", numStrB: "asdf"))
        XCTAssertNotNil(CalcService.instance.add("20.0", numStrB: "5.0"))
        XCTAssertEqual(CalcService.instance.add("30.0", numStrB: "10.0"), "40.0")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
