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
            VStack(spacing: 16.0){
                Group {
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .center){
                                Text("EACH BILL".uppercased())
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                            }.padding(.leading, 16)
                            
                            
                            HStack(alignment: .top){
                                TextField("", text: $BindedVM.eachBillLHS)
                                    .font(.system(size: 50.0,weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 16)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                
                                TextField("", text: $BindedVM.eachBillRHS)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 60.0)
                                    .padding(.leading, 0)
                                    .padding(.top, 5)
                                    .keyboardType(.decimalPad)
                                
                            }
                            
                        }
                        
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .center){
                                Text("eaCH TIP".uppercased())
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                            }.padding(.leading, 16)
                            
                            HStack(alignment: .top){
                                TextField("", text: $BindedVM.eachTipLHS)
                                    .font(.system(size: 50.0,weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 25)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                
                                TextField("deci", text: $BindedVM.eachTipRHS)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 60.0)
                                    .padding(.leading, 0)
                                    .padding(.top, 5)
                                    .keyboardType(.decimalPad)
                                
                            }
                        }
                        
                    }
                    .padding()
                }
                
                
            }
        }//.background(Color.black)
    }
}

struct PerPersonView_Previews: PreviewProvider {
    static var previews: some View {
        PerPersonView(BindedVM: viewModel())
    }
}
