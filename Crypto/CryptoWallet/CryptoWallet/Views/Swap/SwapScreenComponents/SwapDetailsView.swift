//
//  SwapDetailsView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 21/09/24.
//

import SwiftUI

struct SwapDetailsView: View {
    
    @ObservedObject var VM = CryptoViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: AppConstants.ViewBackGroundClr)
                .edgesIgnoringSafeArea(.all)
            VStack {
                DetailsHeaderView(backImageName: "arrow.left", rightImageName: "gear", title: "Swap")
                
                ZStack {
                    VStack {
                        ForEach(VM.swapData) { coins in
                            SwapCoinsView(swapCoinData: coins)
                                .padding(.horizontal,10)
                                .padding(.vertical,8)
                            Spacer().frame(height: 10)
                        }
                    }
                    Image(systemName: "arrow.up.arrow.down")
                                    .frame(width: 50, height: 50)
                                    .background(Color(hex: AppConstants.SwapActionClr))
                                    .cornerRadius(25.0)
                                    .shadow(radius: 4)
                                    .offset(y: -5)
                }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    SwapDetailsView()
}
