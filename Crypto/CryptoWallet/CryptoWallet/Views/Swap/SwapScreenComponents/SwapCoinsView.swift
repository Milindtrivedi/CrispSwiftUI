//
//  SwapCoinsView.swift
//  CryptoWallet
//
//  Created by Apple on 14/03/23.
//

import SwiftUI

struct SwapCoinsView: View {
    
    @ObservedObject var vm = CryptoViewModel()
    
    @State var swapCoinData : currentCurrency
    
    var body: some View {
        ZStack {
            
            Color(hex: AppConstants.ViewBackGroundClr)
            
            VStack {
                
                HStack {
                    Text(swapCoinData.walletbalance)
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.callout)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Text(swapCoinData.walletbalanceDollar)
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.callout)
                        .minimumScaleFactor(0.5)
                }
                
                Spacer()
                
                HStack {
                    Button {
                       
                        
                    } label: {
                        HStack(spacing: 16.0){
                            Image(swapCoinData.swaptoimage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40.0,height: 40.0)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                
                            Text(swapCoinData.swaptoname)
                                .foregroundColor(Color.white)
                                .font(.title3)
                                .bold()
                                .font(.callout)
                            Image(systemName: "triangle.fill")
                                .resizable()
                                .frame(width: 15.0, height: 9.0)
                                .foregroundColor(.white)
                                .rotationEffect(Angle(degrees: 180), anchor: .center)
                                
                                
                        }.padding(8)
                            .padding([.top,.bottom], 0)
                            .background(
                                Color(hex: AppConstants.CapsuleBackGroundClr)
                            )
                            .clipShape(Capsule())
                        
                    }
                    
                    Spacer()
                    Text(swapCoinData.swapvalue)
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .bold()
                }
                
                
            }.padding()
        }.frame(height: 160.0)
            .roundedCornerWithBorder(lineWidth: 1, borderColor: Color(hex: AppConstants.BorderClr), radius: 14, corners: [.allCorners])
    }
}

struct SwapCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SwapCoinsView(swapCoinData: currentCurrency(walletbalance: "In Wallet: 10.214 AVAX", walletbalanceDollar: "$86.059.88", swapvalue: "884.24", swaptoimage: "eth", swaptoname: "ETH", isSwapIconPresent: true))
    }
}
