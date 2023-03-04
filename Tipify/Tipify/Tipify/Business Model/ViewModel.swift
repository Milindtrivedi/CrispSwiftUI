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
    
    func performCalculations(){
        
        let totalBillStr = totalValue.replacingOccurrences(of: ".", with: "") + "." + decimalValue.replacingOccurrences(of: ".", with: "")
        
        guard let doubleofTotalBill = Double(totalBillStr) else {
            return
        }
        
        let eachbillInDouble = doubleofTotalBill / (Double(Persons) ?? 1.0)
        let eachBillStr = String(format: "%.2f", eachbillInDouble)
        
        
        let TotalBillcomponents = eachBillStr.split(separator: ".")
        if TotalBillcomponents.count == 2 {
            let integerPart = String(TotalBillcomponents[0])
            let fractionalPart = String(TotalBillcomponents[1])
            self.eachBillLHS = ""
            self.eachBillRHS = ""
            self.eachBillLHS = integerPart
            self.eachBillRHS = fractionalPart
        } else {
            print("Invalid input string")
        }
            
        let tipInDoubleValue = (Double(tip) ?? 20.0) / 100.0
        let totalTip = doubleofTotalBill * tipInDoubleValue
        let TipEach = Double(totalTip) / (Double(Persons) ?? 2.0)
        let TipEachSTR = String(format: "%.2f", TipEach)
        
        let Tipcomponents = TipEachSTR.split(separator: ".")
        if Tipcomponents.count == 2 {
            let integerPart = String(Tipcomponents[0])
            let fractionalPart = String(Tipcomponents[1])
            self.eachTipLHS = ""
            self.eachTipRHS = ""
            self.eachTipLHS = integerPart
            self.eachTipRHS = fractionalPart
        } else {
            print("Invalid input string")
        }
        
        
        let Finaltotalindouble = TipEach + eachbillInDouble
        let FinaltotalSTR = String(format: "%.2f", Finaltotalindouble)
        
        let Finaltotalcomponents = FinaltotalSTR.split(separator: ".")
        if Finaltotalcomponents.count == 2 {
            let integerPart = String(Finaltotalcomponents[0])
            let fractionalPart = String(Finaltotalcomponents[1])
            self.FinalTotalLHS = ""
            self.FinalTotalRHS = ""
            self.FinalTotalLHS = integerPart
            self.FinalTotalRHS = fractionalPart
        } else {
            print("Invalid input string")
        }
        
        
    }
    
}



