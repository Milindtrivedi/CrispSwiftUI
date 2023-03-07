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
    
    
}

