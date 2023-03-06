//
//  EachTotalView.swift
//  Tipify
//
//  Created by Milind Trivedi on 03/03/23.
//  Copyright Milind Trivedi © 2023 all rights reserved

import SwiftUI

struct EachTotalView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 16.0){
                HStack {
                    Text("Each total".uppercased())
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    HStack(alignment: .top){
                        TextField("", text: $BindedVM.FinalTotalLHS)
                            .disabled(true)
                            .font(.system(size: 50.0,weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.leading, 25)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .minimumScaleFactor(0.5)
                            .onTapGesture {
                                BindedVM.totalValue = ""
                            }
                        TextField("", text: $BindedVM.FinalTotalRHS)
                            .disabled(true)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 60.0)
                            .padding(.leading, 0)
                            .padding(.top, 5)
                            .keyboardType(.decimalPad)
                            .minimumScaleFactor(0.5)
                            .onTapGesture {
                                BindedVM.decimalValue = ""
                            }
                    }
                }
                Text("$" + BindedVM.eachBillLHS + " BILL")
                    .font(.title3)
                    .foregroundColor(.white)
                Text("+ $" + BindedVM.eachTipLHS + " TIP")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, -15)
            }
            .padding()
        }//.background(.blue)
    }
}

struct EachTotalView_Previews: PreviewProvider {
    static var previews: some View {
        EachTotalView(BindedVM: viewModel())
    }
}
