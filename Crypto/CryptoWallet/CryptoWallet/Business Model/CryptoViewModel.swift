//
//  CryptoViewModel.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI


class CryptoViewModel: ObservableObject {
    
    
    let coinData = [Bitcoin(name: "Bitcoin", price: "5.5911", alias: "BTC"),Bitcoin(name: "Ethereum", price: "3.9491", alias: "ETH"),Bitcoin(name: "Binance Coin", price: "7.7201", alias: "BNB")]
    
    let coinBarData = [BitcoinChart(color: Color(hex: AppConstants.BarClrBTC), type: "Bitcoin", count: 9, total: 100),BitcoinChart(color: Color(hex: AppConstants.BarClrETH), type: "Ethereum", count: 74, total: 100),BitcoinChart(color: Color(hex: AppConstants.BarClrBNB), type: "Binance Coin", count: 17, total: 100)]
    
    
    let catalogueData = [coinAssetDetails(name: "Bitcoin", price: "$128,143.2", perunitPrice: "1 BTC $21,359.20", variance: "+222.20 (1,05%)", logo: "btc"),coinAssetDetails(name: "Ethereum", price: "$6,358.4", perunitPrice: "1 ETH $1,589.62", variance: "+23.94 (1.53%)", logo: "eth"),coinAssetDetails(name: "Binance Coin", price: "$2.329.7", perunitPrice: "1 BNB $294,20", variance: "+5.55 (1.72%)", logo: "bnc")]

    
    let swapData = [currentCurrency(walletbalance: "In Wallet: 10.214 AVAX", walletbalanceDollar: "$86.059.88", swapvalue: "884.24", swaptoimage: "eth", swaptoname: "ETH", isSwapIconPresent: true), currentCurrency(walletbalance: "In Wallet: 3,949 ETH", walletbalanceDollar: "$16,953.98", swapvalue: "10.6856", swaptoimage: "avx", swaptoname: "AVAX", isSwapIconPresent: false)]
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

struct coinAssetDetails : Identifiable, Hashable {
    
    var name : String
    var price : String
    var perunitPrice : String
    var variance : String
    var id = UUID()
    var logo : String
    
}
 
struct currentCurrency : Identifiable, Hashable {
    var id = UUID()
    var walletbalance : String
    var walletbalanceDollar : String
    var swapvalue : String
    var swaptoimage : String
    var swaptoname : String
    var isSwapIconPresent : Bool
}


struct Transaction: Identifiable {
    let id = UUID()
    let category: String
    let date: String
    let time: String
    let amount: String
    let eth: String
    let icon: String
}

struct ChartData: Identifiable {
    let id = UUID()
    let percentage: Int
    let color: [Color]
    let data: [Double]
    let transactions: [Transaction]
}
