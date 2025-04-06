//
//  StatsView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 05/04/25.
//

import SwiftUI

struct StatsView: View {
    
    @State private var selectedChartIndex = 0
    
    @State var charts: [ChartData] = [
        ChartData(percentage: 80, color: [Color(hex: AppConstants.BarClrBTC),Color(hex: AppConstants.BarClrETH),Color(hex: AppConstants.BarClrBNB),Color(hex: AppConstants.BarClrOther)], data: [40, 25, 15, 20], transactions: [
            Transaction(category: "Health", date: "27 Jan", time: "4:40 PM", amount: "-$16,46.00", eth: "0.05 ETH", icon: "heart.fill"),
            Transaction(category: "Shopping", date: "27 Jan", time: "2:13 PM", amount: "-$413.40", eth: "1.05 ETH", icon: "cart.fill"),
            Transaction(category: "Clothes", date: "26 Jan", time: "1:01 PM", amount: "-$20,19.00", eth: "0.07 ETH", icon: "tshirt.fill"),
            Transaction(category: "Shopping", date: "25 Jan", time: "8:29 PM", amount: "-$90,99.00", eth: "0.79 ETH", icon: "cart.fill")
        ],month: "January"),
        ChartData(percentage: 60, color: [Color(hex: AppConstants.BarClrBTC),Color(hex: AppConstants.BarClrETH),Color(hex: AppConstants.BarClrBNB),Color(hex: AppConstants.BarClrOther)], data: [12.5, 28.3, 15.7, 43.5], transactions: [
            Transaction(category: "Health", date: "7 Feb", time: "4:40 PM", amount: "-$16,46.00", eth: "0.05 ETH", icon: "heart.fill"),
            Transaction(category: "Shopping", date: "8 Feb", time: "2:13 PM", amount: "-$413.40", eth: "1.05 ETH", icon: "cart.fill"),
            Transaction(category: "Clothes", date: "13 Feb", time: "1:01 PM", amount: "-$20,19.00", eth: "0.07 ETH", icon: "tshirt.fill"),
            Transaction(category: "Shopping", date: "18 Feb", time: "8:29 PM", amount: "-$90,99.00", eth: "0.79 ETH", icon: "cart.fill")
        ],month: "February")
    ]
    
    var body: some View {
        ZStack {
            Color(hex: AppConstants.ViewBackGroundClr)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                DetailsHeaderView(backImageName: "arrow.left", rightImageName: "calendar", title: "Statistic")
                    .padding(.top, -32)
                
                ChartsCarouselView(charts: $charts, selectedChartIndex: $selectedChartIndex)
                    .padding()
                    .padding(.top, -25)
                
                TransectionHistoryListView(charts: $charts, selectedChartIndex: $selectedChartIndex)
                //Spacer()
            }.padding(.vertical)
                .background(Color(hex: AppConstants.ViewBackGroundClr).edgesIgnoringSafeArea(.all))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    StatsView()
}
