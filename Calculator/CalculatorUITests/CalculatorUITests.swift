//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Milind on 09/02/23.
//

import XCTest
@testable import Calculator

final class CalculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClipboardFunctionality(){
        
        let app = XCUIApplication()
        app.launch()
        
        let AC = app.staticTexts["AC"]
        XCTAssert(AC.exists)
        
        let imagePlusMinus = app.images["plus.slash.minus"]
        XCTAssert(imagePlusMinus.exists)
        
        let percentage = app.staticTexts["%"]
        XCTAssert(percentage.exists)
        
        let divide = app.images["divide"]
        XCTAssert(divide.exists)
        
        let seven = app.staticTexts["7"]
        XCTAssert(seven.exists)
        
        let eight = app.staticTexts["8"]
        XCTAssert(eight.exists)
        
        let nine = app.staticTexts["9"]
        XCTAssert(nine.exists)
        
        let multiply = app.images["multiply"]
        XCTAssert(multiply.exists)
        
        let four = app.staticTexts["4"]
        XCTAssert(four.exists)
        
        let five = app.staticTexts["5"]
        XCTAssert(five.exists)
        
        let six = app.staticTexts["6"]
        XCTAssert(six.exists)
        
        let minus = app.images["Minus"]
        XCTAssert(minus.exists)
        
        let one = app.staticTexts["1"]
        XCTAssert(one.exists)
        
        let two = app.staticTexts["2"]
        XCTAssert(two.exists)
        
        let three = app.staticTexts["3"]
        XCTAssert(three.exists)
        
        let plus = app.images["Plus"]
        XCTAssert(plus.exists)
        
        let zero = app.staticTexts["0"]
        XCTAssert(zero.exists)
        
        let dot = app.staticTexts["."]
        XCTAssert(dot.exists)
        
        let equal = app.images["equal"]
        XCTAssert(equal.exists)
    }
}
