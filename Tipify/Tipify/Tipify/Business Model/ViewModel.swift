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
    var oldtip = ""
    
    @Published var totalValue = "0"
    @Published var decimalValue = "0"
    @Published var tip = "20%"
}
