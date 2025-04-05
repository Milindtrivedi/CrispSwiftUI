//
//  AssetRow.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct AssetRow: View {
    
    var coinData : coinAssetDetails
    
    var body: some View {
        
        ZStack{
            
            HStack(alignment:.center, spacing: 16.0) {
                ZStack {
                    if coinData.name.localizedCaseInsensitiveContains("Bitcoin") {
                        Image(coinData.logo)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30,height: 30)
                            .rotationEffect(.degrees(10))
                            .padding()
                    } else {
                        Image(coinData.logo)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30,height: 30)
                            .padding()
                    }
                }
                .background(
                    Color(hex: AppConstants.BgClrIcons)
                        .clipShape(Circle())
                )
                
                    
                
                VStack(spacing: 4.0){
                    
                    HStack {
                        Text(coinData.name)
                            .foregroundColor(Color.white)
                            .font(.title2)
                        
                        Spacer()
                        
                        Text(coinData.price)
                            .foregroundColor(Color.white)
                            .font(.title2)
                        
                        
                    }
                    
                    HStack {
                        Text(coinData.perunitPrice)
                            .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                            .font(.callout)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                        
                        Text(coinData.variance)
                            .foregroundColor(Color(hex: AppConstants.TextYellowClr))
                            .font(.callout)
                            .minimumScaleFactor(0.1)
                        
                        
                    }
                }
                
            }.padding()
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
    }
}

struct AssetRow_Previews: PreviewProvider {
    static var previews: some View {
        AssetRow(coinData: coinAssetDetails(name: "Bitcoin", price: "$128,143.2", perunitPrice: "1 BTC $21,359.20", variance: "+222.20 (1,05%)", logo: "btc"))
    }
}


