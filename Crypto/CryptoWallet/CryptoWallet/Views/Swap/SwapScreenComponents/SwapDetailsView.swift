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
                                    .foregroundStyle(.white)
                                    .cornerRadius(25.0)
                                    .shadow(radius: 4)
                                    .offset(y: -5)
                }
                
                VStack(spacing: 20) {
                           
                           // Conversion Rate
                           Text("1 AVAX = 0.01132916 ETH (1.51%)")
                               .foregroundColor(Color.white)
                               .font(.title3)
                           
                           VStack(spacing: 15) {
                               SwapDetailRow(title: "Expected Output", value: "10.715690 ETH")
                               Divider()
                                   .frame(height: 1)
                                   .background(Color(hex: AppConstants.BorderClr).opacity(0.5))
                               SwapDetailRow(title: "Price Impact", value: "0.00191%", valueColor: Color(hex: AppConstants.TextYellowClr))
                               Divider()
                                   .frame(height: 1)
                                   .background(Color(hex: AppConstants.BorderClr).opacity(0.5))
                               SwapDetailRow(title: "Network Fee", value: "0.00409 ETH")
                               Divider()
                                   .frame(height: 1)
                                   .background(Color(hex: AppConstants.BorderClr).opacity(0.5))
                               SwapDetailRow(title: "Exchange Fee", value: "Free", valueColor: Color(hex: AppConstants.TextYellowClr))
                           }
                           .padding(.vertical)
                    
                           
                           Button(action: {
                               print("Swap Tokens tapped")
                           }) {
                               Text("Swap Tokens")
                                   .foregroundColor(.white)
                                   .fontWeight(.medium)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                                   .background(Color(hex: AppConstants.SwapActionClr))
                                   .cornerRadius(12)
                           }
                       }
                       .padding()
                
            }
        }
    }
}

#Preview {
    SwapDetailsView()
}
