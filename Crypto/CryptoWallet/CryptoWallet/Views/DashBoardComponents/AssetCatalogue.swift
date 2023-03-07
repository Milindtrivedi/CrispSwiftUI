//
//  AssetCatalogue.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 07/03/23.
//

import SwiftUI

struct AssetCatalogue: View {
    
    var catalogueData : [coinAssetDetails]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Text(AppStrings.AssetCatalogueTitle)
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.title3)
                    Spacer()
                }.padding()
                ForEach(catalogueData) { datum in
                    AssetRow(coinData: datum)
                }
            }
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
    }
}

struct AssetCatalogue_Previews: PreviewProvider {
    static var previews: some View {
        AssetCatalogue(catalogueData: [coinAssetDetails(name: "Bitcoin", price: "$128,143.2", perunitPrice: "1 BTC $21,359.20", variance: "+222.20 (1,05%)", logo: "btc"),coinAssetDetails(name: "Ethereum", price: "$6,358.4", perunitPrice: "1 ETH $1,589.62", variance: "+23.94 (1.53%)", logo: "eth"),coinAssetDetails(name: "Binance Coin", price: "$2.329.7", perunitPrice: "1 BNB $294,20", variance: "+5.55 (1.72%)", logo: "bnc")])
    }
}
