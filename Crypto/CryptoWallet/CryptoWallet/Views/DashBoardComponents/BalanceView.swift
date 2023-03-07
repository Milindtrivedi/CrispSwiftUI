//
//  BalanceView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct BalanceView: View {
    
    var balanceVariation = "+1,024.59 (+4,5%)" //TO-DO FETCH FROM VIEW MODEL
    
    var AvlBalance = "$68,990.45"
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                HStack(){
                    Text(AppStrings.DashboarBalanceTitle)
                        .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                        .font(.title3)
                    
                    Text(balanceVariation)
                        .foregroundColor(Color(hex: AppConstants.TextYellowClr))
                        .font(.title3)
                    
                    Spacer()
                }.padding(.leading)
                
                HStack {
                    Text(AvlBalance)
                        .font(.system(size: 60.0))
                        .foregroundColor(.white)
                        .padding(.leading)
                        .bold()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    Spacer()
                }
            }
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
