//
//  ContentView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct Dashboard: View {
    
    @ObservedObject var vm = CryptoViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
                .padding()
            BalanceView()
            ScrollView(showsIndicators: false){
                VStack(spacing: 16.0){
                    CoinView(coinData: vm.coinData, stackedBarData: vm.coinBarData)
                    AssetCatalogue(catalogueData: vm.catalogueData)
                    Spacer()
                }
            }
        }.background(Color(hex: "0D0C0F"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
