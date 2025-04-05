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
            Text("January")
                .font(.title)
                .bold()
                
            
            TabView(selection: $selectedChartIndex) {
                ForEach(charts.indices, id: \ .self) { index in
                    ZStack {
                        CryptoChartView(data: .constant(charts[index].data), colors: .constant(charts[index].color))
                    }
                    .tag(index)
                }
            }.frame(height: 300.0)
                .padding()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
}
