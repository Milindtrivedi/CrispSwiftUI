//
//  SwapCoinsView.swift
//  CryptoWallet
//
//  Created by Apple on 14/03/23.
//

import SwiftUI

struct SwapCoinsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 75.0) {
                
                HStack {
                    Text("In Wallet: 10.214 AVAX")
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.callout)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Text("$86.059.88")
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.callout)
                        .minimumScaleFactor(0.5)
                }
                
                HStack {
                    Button {
                       
                        
                    } label: {
                        HStack(spacing: 4.0){
                            Image("eth")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.0,height: 40.0)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                            Text(AppStrings.DashboardCryptoTitle)
                                .foregroundColor(Color.white)
                                .font(.title3)
                                .bold()
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .font(.callout)
                            Image(systemName: "arrowtriangle.down.fill")
                                .padding(.trailing)
                                .foregroundColor(.white)
                        }.padding(8)
                            .padding([.top,.bottom], 0)
                            .background(
                                Color(hex: AppConstants.CapsuleBackGroundClr)
                            )
                            .clipShape(Capsule())
                        
                    }
                    
                    Spacer()
                    Text("$86.059.88")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .bold()
                }
                
                
            }.padding()
                .border(.red)
        }.frame(width: UIScreen.screenWidth)
        .background(
            Color(hex: AppConstants.ViewBackGroundClr)
        )
    }
}

struct SwapCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SwapCoinsView()
    }
}
