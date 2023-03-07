//
//  CoinView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI
import Charts

struct CoinView: View {
    
    var coinData : [Bitcoin]
    var stackedBarData: [BitcoinChart]
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 0.0){
                    ForEach(coinData) { datum in
                        VStack(alignment: .leading, spacing: 16.0){
                            
                            Text(datum.name)
                                .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                                .font(.title3)
                            
                            HStack(spacing: 8.0) {
                                
                                Text(datum.price)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                
                                Text(datum.alias)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                
                            }
                            
                        }.padding()
                    }
                }
                
                Chart {
                    ForEach(stackedBarData) { shape in
                        BarMark(
                            x: .value("Type", shape.type),
                            y: .value("Count", shape.count)
                        )
                        .foregroundStyle(shape.color)
                    }
                   
                }.chartLegend(.hidden)
                    .frame(height: 400.0)
            }
            
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
        
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(coinData: [Bitcoin(name: "Bitcoin", price: "5.5911", alias: "BTC"),Bitcoin(name: "Ethereum", price: "3.9491", alias: "ETH"),Bitcoin(name: "Binance Coin", price: "7.7201", alias: "BNB")], stackedBarData: [BitcoinChart(color: Color(hex: AppConstants.BarClrBTC), type: "Bitcoin", count: 9, total: 100),BitcoinChart(color: Color(hex: AppConstants.BarClrETH), type: "Ethereum", count: 74, total: 100),BitcoinChart(color: Color(hex: AppConstants.BarClrBNB), type: "Binance Coin", count: 17, total: 100)])
    }
}


struct Bitcoin : Identifiable, Hashable {
    
    let id = UUID()
    var name : String
    var price : String
    var alias : String
    
}


struct BitcoinChart: Identifiable, Hashable {
    var color: Color
    var type: String
    var count: Double
    var total: Double
    var id = UUID()
}


