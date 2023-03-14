//
//  SwapScreen.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 07/03/23.
//

import SwiftUI

struct SwapScreen: View {
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                DetailsHeaderView(backImageName: "arrow.left", rightImageName: "gear", title: "Swap")
                    Spacer()
            }
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
    }
}

struct SwapScreen_Previews: PreviewProvider {
    static var previews: some View {
        SwapScreen()
    }
}
