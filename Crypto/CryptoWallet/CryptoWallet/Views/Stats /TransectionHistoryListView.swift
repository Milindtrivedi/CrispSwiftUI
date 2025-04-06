//
//  TransectionHistoryListView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 05/04/25.
//

import SwiftUI

struct TransectionHistoryListView: View {
    
    @Binding var charts: [ChartData]
    @Binding var selectedChartIndex : Int
    
    var body: some View {
        Text("Transaction History")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        ScrollView {
            VStack(spacing: 24) {
                ForEach(charts[selectedChartIndex].transactions) { transaction in
                    HStack {
                        Image(systemName: transaction.icon)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color(hex: AppConstants.BarClrBTC))
                            .background(Color(hex: AppConstants.BgClrIcons))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading,spacing: 4) {
                            Text(transaction.category)
                                .bold()
                            Text("\(transaction.date), at \(transaction.time)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(transaction.amount)
                                .bold()
                            Text(transaction.eth)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
