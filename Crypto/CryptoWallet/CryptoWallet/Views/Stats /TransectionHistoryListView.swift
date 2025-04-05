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
            .padding(.horizontal)
        
        ScrollView {
            VStack(spacing: 16) {
                ForEach(charts[selectedChartIndex].transactions) { transaction in
                    HStack {
                        Image(systemName: transaction.icon)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(transaction.category)
                                .bold()
                            Text("\(transaction.date), at \(transaction.time)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
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
