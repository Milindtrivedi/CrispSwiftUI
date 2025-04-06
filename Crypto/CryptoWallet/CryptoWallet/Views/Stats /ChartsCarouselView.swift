//
//  ChartsCarouselView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 05/04/25.
//

import SwiftUI

struct ChartsCarouselView: View {
    
    @Binding var charts: [ChartData]
    @Binding var selectedChartIndex : Int
    
    var body: some View {
        VStack(spacing: 16.0){
            
            Text(charts[selectedChartIndex].month)
                .font(.title)
                .bold()
            
            
            TabView(selection: $selectedChartIndex) {
                ForEach(charts.indices, id: \ .self) { index in
                    ZStack {
                        CryptoChartView(data: .constant(charts[index].data), colors: .constant(charts[index].color), percentage: .constant(String(describing: charts[index].percentage) + "%"))
                    }
                    .tag(index)
                }
            }.frame(height: 275.0)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Custom Page Indicator BELOW the chart
            HStack(spacing: 8) {
                ForEach(charts.indices, id: \.self) { index in
                    Circle()
                        .fill(selectedChartIndex == index ? Color.white : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}
