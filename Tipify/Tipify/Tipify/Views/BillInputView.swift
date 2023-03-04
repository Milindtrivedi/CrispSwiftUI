//
//  BillInputView.swift
//  Tipify
//
//  Created by Apple on 04/03/23.
//

import SwiftUI

struct BillInputView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                HStack {
                    HStack {
                        Text("BILL TOTAL")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 150.0)
                        
                        Spacer()
                        
                        HStack(alignment: .top){
                            TextField("TOTAL", text: $BindedVM.totalValue)
                                .font(.system(size: 50.0,weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.leading, 25)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                            
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                                let keyWindow = windowScene.windows.filter { $0.isKeyWindow }.first
                                                keyWindow?.endEditing(true)
                                            }
                                        }.padding(.trailing, 16)
                                    }
                                }
                                .onTapGesture {
                                    BindedVM.totalValue = ""
                                }
                            
                            
                            TextField("deci", text: $BindedVM.decimalValue)
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
                .padding(.top, 100)
            }
        }
        
        .onChange(of: BindedVM.totalValue) { newValue in
            BindedVM.performCalculations()
        }
        
        .onChange(of: BindedVM.decimalValue) { newValue in
            BindedVM.performCalculations()
        }
    }
}

struct BillInputView_Previews: PreviewProvider {
    static var previews: some View {
        BillInputView(BindedVM: viewModel())
    }
}
