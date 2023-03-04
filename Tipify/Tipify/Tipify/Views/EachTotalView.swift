//
//  EachTotalView.swift
//  Tipify
//
//  Created by Apple on 04/03/23.
//

import SwiftUI

struct EachTotalView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                
                HStack {
                    HStack {
                        
                        VStack(alignment: .leading,spacing: 16.0) {
                            
                            Text("Each total".uppercased())
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("$" + BindedVM.eachBillLHS + " BILL")
                                .font(.title3)
                                .foregroundColor(.white)
                            Text("+ $" + BindedVM.eachTipLHS + " TIP")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.top, -15)
                            
                        }.padding()
                        
                        Spacer()
                        
                        HStack(alignment: .top){
                            TextField("", text: $BindedVM.FinalTotalLHS)
                                .font(.system(size: 50.0,weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.leading, 25)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    BindedVM.totalValue = ""
                                }
                            
                            
                            TextField("", text: $BindedVM.FinalTotalRHS)
                                .font(.title)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 60.0)
                                .padding(.leading, 0)
                                .padding(.top, 5)
                                .keyboardType(.decimalPad)
                            
                                .onTapGesture {
                                    BindedVM.decimalValue = ""
                                }
                                
                        }
                    }
                }
                .padding()
            }
        }//.background(.blue)
    }
}

struct EachTotalView_Previews: PreviewProvider {
    static var previews: some View {
        EachTotalView(BindedVM: viewModel())
    }
}
