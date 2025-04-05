//
//  SwapDetailRow.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 05/04/25.
//

import SwiftUI

struct SwapDetailRow: View {
    var title: String
    var value: String
    var valueColor: Color = .white
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                .font(.subheadline)
            Spacer()
            Text(value)
                .foregroundColor(valueColor)
                .font(.subheadline)
        }
    }
}
