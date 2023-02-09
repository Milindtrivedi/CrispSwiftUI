//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Milind on 09/02/23.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {

    var model : CalculatorViewModel?
    
    override func setUpWithError() throws {
        model = CalculatorViewModel()
    }

    override func tearDownWithError() throws {
        model = nil
    }
    
    func testAdditionCalculation() {
        model?.onTypeNumber(1)
        model?.onSelectOperator(.Plus)
        model?.onTypeNumber(2)
        model?.onCalculate()
        XCTAssertEqual(model?.displayedValue,"3") //cause 1 + 2 =3 thats why in the expression evaluation we get ans compared to 3
    }
    
    func testSubstractionCalculation() {
        model?.onTypeNumber(1)
        model?.onSelectOperator(.Minus)
        model?.onTypeNumber(2)
        model?.onCalculate()
        XCTAssertEqual(model?.displayedValue,"-1") //cause 1 - 2 = -1 thats why in the expression evaluation we get ans - 1
    }
    
    func testMultiplicationCalculation() {
        model?.onTypeNumber(111)
        model?.onSelectOperator(.Multiply)
        model?.onTypeNumber(2222)
        model?.onCalculate()
        XCTAssertEqual(model?.displayedValue,"246,642")
    }
    
    func testDivisionCalculation() {
        model?.onTypeNumber(1000)
        model?.onSelectOperator(.Divide)
        model?.onTypeNumber(50)
        model?.onCalculate()
        XCTAssertEqual(model?.displayedValue,"20")
    }
    
    func testdecimals() {
        model?.onTypeNumber(1)
        model?.onTypeDot()
        model?.onTypeNumber(2)
        model?.onSelectOperator(.Plus)
        
        model?.onTypeNumber(3)
        model?.onTypeDot()
        model?.onTypeNumber(4)
        model?.onCalculate()
        
        XCTAssertEqual(model?.displayedValue,"4.6")
        
    }
    
    func testChangingSigns() {
        model?.onTypeNumber(9)
        model?.onPlusMinus()
        model?.onSelectOperator(.Plus)
        model?.onTypeNumber(2)
        model?.onCalculate()
        XCTAssertEqual(model?.displayedValue,"7")
        
    }
    
    func testPercentageCalculation() {
        model?.onTypeNumber(9)
        model?.onPercentage()
        XCTAssertEqual(model?.displayedValue,"0.09")
        
    }
    
    func testTextClearFieldAC() {
        model?.onTypeNumber(9)
        model?.onTypeNumber(9)
        model?.onTypeNumber(9)
        model?.onTypeNumber(9)
        model?.onTypeNumber(2)
        model?.onAC()
        XCTAssertEqual(model?.displayedValue,"0")
        
    }

}
