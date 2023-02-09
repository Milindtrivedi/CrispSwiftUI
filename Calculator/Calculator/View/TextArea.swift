//
//  TextArea.swift
//  Calculator
//
//  Created by Milind on 09/02/23.
//

import SwiftUI

enum DisplayAreaEvent {
    case Delete
    case CopyToClipBoard
    case Paste
}


struct TextArea: View {
    
    var eventCallback: ((DisplayAreaEvent) -> Void)?
    
    // bindind display text from calculator
    @Binding var currentDisplay: String
    
    @Binding var isPresentingPopover: Bool
    
    // dynamic font size for different display text length so that it does not exceed the control panel width
    var fontSize: CGFloat {
        get {
            if currentDisplay.count > 11 {
                return 50
            } else if currentDisplay.count > 9 {
                return 55
            } else if currentDisplay.count > 8 {
                return 70
            } else {
                return 80
            }
        }
    }
    
    var body: some View {
        Text(currentDisplay)
            .foregroundColor(Color.white)
            .font(.system(size: fontSize))
            .contextMenu {
                Button(action: {
                    self.eventCallback?(.CopyToClipBoard)
                }) {
                    Text("Copy")
                    Image(systemName: "doc.on.doc")
                }
                Button(action: {
                    self.eventCallback?(.Paste)
                }) {
                    Text("Paste")
                    Image(systemName: "doc.on.clipboard")
                }
            }
            .id(UUID.init())
            .frame(minHeight: 120)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea(currentDisplay: .constant("2"), isPresentingPopover: .constant(false))
    }
}
