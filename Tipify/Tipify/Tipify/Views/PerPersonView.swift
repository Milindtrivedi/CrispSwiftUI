//
//  PerPersonView.swift
//  Tipify
//
//  Created by Apple on 04/03/23.
//

import SwiftUI

struct PerPersonView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("EACH BILL".uppercased())
                            .font(.title3)
                            .foregroundColor(.white)
                            //.padding()
                        Spacer()
                    }
                    HStack(){
                        Text(BindedVM.eachBillLHS)
                            .font(.system(size: 50.0,weight: .semibold))
                            .foregroundColor(.white)
                            .keyboardType(.decimalPad)
                        Text(BindedVM.eachBillRHS)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .keyboardType(.decimalPad)
                            .padding(.leading, -8)
                            .padding(.top, -16)
                    }.frame(maxHeight: 70.0)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    HStack(alignment: .center){
                        Spacer()
                        Text("eaCH TIP".uppercased())
                            .font(.title3)
                            .foregroundColor(.white)
                            //.padding()
                    }
                    HStack(){
                        Text(BindedVM.eachTipLHS)
                            .font(.system(size: 50.0,weight: .semibold))
                            .foregroundColor(.white)
                            .keyboardType(.decimalPad)
                            
                        Text(BindedVM.eachTipRHS)
                        
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .keyboardType(.decimalPad)
                            .padding(.leading, -8)
                            .padding(.top, -16)
                        
                        
                    }.frame(maxHeight: 70.0)
                }
            }
            .padding()
        }//.background(Color.black)
    }
}

struct PerPersonView_Previews: PreviewProvider {
    static var previews: some View {
        PerPersonView(BindedVM: viewModel())
    }
}
