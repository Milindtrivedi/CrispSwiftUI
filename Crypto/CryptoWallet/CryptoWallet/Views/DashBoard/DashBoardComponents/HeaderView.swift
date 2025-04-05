//
//  HeaderView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var isShowDetailsView = false
    
    var body: some View {
        ZStack {
            HStack {
                Text(AppStrings.Dashboardtitle)
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                Button {
                    isShowDetailsView = true
                } label: {
                    HStack(spacing: 4.0){
                        Image("eth")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30.0,height: 30.0)
                            .foregroundColor(.white)
                        Text(AppStrings.DashboardCryptoTitle)
                            .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                            .padding(.trailing, 10)
                            .font(.callout)
                    }.padding(8)
                        .background(
                            Color(hex: AppConstants.CapsuleBackGroundClr)
                        )
                        .clipShape(Capsule())
                }
            }
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
            .navigationDestination(isPresented: $isShowDetailsView) {
                StatsView()
                    .navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
            }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
