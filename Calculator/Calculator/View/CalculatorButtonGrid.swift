//
//  CalculatorButtonGrid.swift
//  Calculator
//
//  Created by Milind on 09/02/23.
//

import SwiftUI

var buttonGapSize: CGFloat = (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ?
(UIScreen.main.bounds.width / 50) :
(UIScreen.main.bounds.height / 50)
var buttonSize: CGFloat = (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ?
((UIScreen.main.bounds.width - 4 * buttonGapSize) / 4):
((UIScreen.main.bounds.height - 4 * buttonGapSize) / 7)

var controlPanelWidth = 4 * buttonSize + 3 * buttonGapSize


struct CalculatorButtonGrid: View {
    
    var clickCallback: ((ButtonType) -> Void)?
    
    // colours
    private let BGGray = Color(hex: 0xa5a5a5)
    private let BGHoverGray = Color(hex: 0xd9d9d9)
    
    private let BGDarkGray = Color(hex: 0x333333)
    private let BGHoverDarkGray = Color(hex: 0x737373)
    
    private let BGOrange = Color(hex: 0xff9f06)
    private let BGHoverOrange = Color(hex: 0xfcc88d)
    
    private let FGWhite = Color(.white)
    private let FGBlack = Color(.black)
    
    // the operator that is selected. nil if not selecting
    @State private var selectedOperator: ButtonType? = nil
    
    // callback function for buttons on click
    private func onButtonClick(_ buttonType: ButtonType) -> Void {
        switch buttonType {
        case .Divide, .Multiply, .Minus, .Plus:
            self.selectedOperator = buttonType
        case .Calculate:
            self.selectedOperator = nil
        default:
            break
        }
        self.clickCallback?(buttonType)
    }
    
    var body: some View {
        
        VStack(spacing: buttonGapSize) {
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "AC", BG: BGGray, FG: FGBlack, BGHover: BGHoverGray, operatorType: ButtonType.AC, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "plus.slash.minus"), BG: BGGray, FG: FGBlack, BGHover: BGHoverGray, operatorType: ButtonType.PlusMinus, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "%", BG: BGGray, FG: FGBlack, BGHover: BGHoverGray, operatorType: ButtonType.Percentage, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "divide"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange, operatorType: ButtonType.Divide, selectedOperator: $selectedOperator, callback: onButtonClick)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "7", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number7, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "8", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number8, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "9", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number9, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "multiply"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange, operatorType: ButtonType.Multiply, selectedOperator: $selectedOperator, callback: onButtonClick)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "4", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number4, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "5", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number5, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "6", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number6, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "minus"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange, operatorType: ButtonType.Minus, selectedOperator: $selectedOperator, callback: onButtonClick)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "1", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number1, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "2", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number2, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: "3", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Number3, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "plus"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange, operatorType: ButtonType.Plus, selectedOperator: $selectedOperator, callback: onButtonClick)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "0", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, horizontalSpan: 2, operatorType: ButtonType.Number0, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(text: ".", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, operatorType: ButtonType.Dot, selectedOperator: $selectedOperator, callback: onButtonClick)
                CalculatorButton(image: Image(systemName: "equal"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange, operatorType: ButtonType.Calculate, selectedOperator: $selectedOperator, callback: onButtonClick)
            }
        }
    }
}

struct CalculatorButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonGrid()
    }
}



extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
