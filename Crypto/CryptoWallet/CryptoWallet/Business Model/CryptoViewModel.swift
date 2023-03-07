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
    
}

