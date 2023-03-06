//
//  TipifyTests.swift
//  TipifyTests
//
//  Created by Milind Trivedi on 03/03/23.
//  Copyright Milind Trivedi © 2023 all rights reserved

import XCTest
@testable import Tipify

final class TipifyTests: XCTestCase {

    var Billamount = "1637"
    var BillamountDeci = "35" //1637.35
    var model : viewModel!
    
    override func setUp() {
        super.setUp()
        model = viewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCalculations() {
        model.totalValue = Billamount
        model.decimalValue = BillamountDeci
        model.tip = "30"
        model.Persons = "9"
        model.performCalculations()
        
        XCTAssertEqual(model.eachBillLHS, "181", "Per Persion Bill not calculated properly") // 1637 / 9 = 181 LHS
        XCTAssertEqual(model.eachBillRHS, "92", "Per Persion Bill not calculated properly") // 1637 / 9 = .92 RHS offsetted
        XCTAssertEqual(model.eachTipLHS, "54", "Tip is not calculated properly") //(1632 * 0.30) / 9 = 54 LHS
        XCTAssertEqual(model.eachTipRHS, "57", "Tip isnot calculated properly") //(1632 * 0.30) / 9 = 56667 // ~=57 offsetted
        XCTAssertEqual(model.FinalTotalLHS, "236", "Per Person Total is not calculated properly") // 181 + 55 = 235 + 1 (from RHS) = 236
        XCTAssertEqual(model.FinalTotalRHS, "50", "Per Person Total is not calculated properly") // 0.92 + 057 = 1.49 =~ 50 offsetted and added +1 to LHS
    }

}
