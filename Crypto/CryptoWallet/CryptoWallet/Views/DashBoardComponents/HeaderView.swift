//
//  HeaderView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            HStack {
                Text(AppStrings.Dashboardtitle)
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                Button {
                    print("clicked")
                } label: {
                    HStack(spacing: 4.0){
                        Image("eth")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30.0,height: 30.0)
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
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
