//
//  ViewModel.swift
//  Tipify
//
//  Created by Milind Trivedi on 03/03/23.
//  Copyright Milind Trivedi © 2023 all rights reserved

import SwiftUI

final class viewModel : ObservableObject {
    
    let topclr = Color(hex: "#7FEE57")
    let midclr = Color(hex: "#5CBD48")
    let btmclr = Color(hex: "#338437")
    
    @Published var totalValue = "0"
    @Published var decimalValue = "0"
    @Published var tip = "20"
    @Published var Persons = "2"
    @Published var eachBillLHS = "00"
    @Published var eachBillRHS = "00"
    @Published var eachTipLHS = "00"
    @Published var eachTipRHS = "00"
    @Published var FinalTotalLHS = "00"
    @Published var FinalTotalRHS = "00"
    
    
    
    func StepperPlusTapped(){
        if tip.toInt() <= 90 {
            tip = String(describing: ((Int(tip) ?? 0) + 10))
            self.performCalculations()
        } else {
            return
        }
    }
    
    func StepperMinusTapped(){
        if tip.toInt() > 10 {
            tip = String(describing: ((Int(tip) ?? 0) - 10))
            self.performCalculations()
        } else {
            return
        }
    }
    
    func StepperSplitPlusTapped(){
        if Persons.toInt() < 99 {
            Persons = String(describing: ((Int(Persons) ?? 0) + 1))
            self.performCalculations()
        } else {
            return
        }
    }
    
    func StepperSplitMinusTapped(){
        if Persons.toInt() > 1 {
            Persons = String(describing: ((Int(Persons) ?? 0) - 1))
            self.performCalculations()
        } else {
            return
        }
    }
    
    func performCalculations() {
        let totalBill = Double(totalValue) ?? 0
        let decimalBill = Double("0." + decimalValue) ?? 0
        let totalBillWithDecimal = totalBill + decimalBill
        
        let tipPercentage = Double(tip) ?? 20
        let tipAmount = totalBillWithDecimal * tipPercentage / 100
        let totalPerPerson = (totalBillWithDecimal) / (Double(Persons) ?? 1)
        
        clearAllFileds()

        (eachBillLHS, eachBillRHS) = separateDecimal(totalPerPerson)
        (eachTipLHS, eachTipRHS) = separateDecimal(tipAmount / (Double(Persons) ?? 0))
        (FinalTotalLHS, FinalTotalRHS) = separateDecimal(totalPerPerson + (tipAmount / (Double(Persons) ?? 0)))
    }

    fileprivate func separateDecimal(_ value: Double) -> (String, String) {
        let (intPart, fracPart) = modf(value)
        
        if intPart <= Double(Int.max) {
            return (String(Int(intPart)), String(Int(abs(fracPart) * 100)))
           } else {
               return ("Err", String(Int(abs(fracPart) * 100)))
           }
        
        
    }
    
    fileprivate func clearAllFileds() {
        eachBillLHS = ""
        eachBillRHS = ""
        eachTipLHS = ""
        eachTipRHS = ""
        FinalTotalLHS = ""
        FinalTotalRHS = ""
    }

    
}



