//
//  ContentView.swift
//  Tipify
//
//  Created by Milind Trivedi on 03/03/23.
//  Copyright Milind Trivedi © 2023 all rights reserved

//https://dribbble.com/shots/6355184-Daily-Ui-4-Tip-Calculator-Compliant

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @ObservedObject var vm = viewModel()
    @FocusState var isTotalInputActive: Bool
    @FocusState var isDecimalInputActive: Bool
    @State var isEditTip : Bool = true
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(spacing: 16.0) {
                    HStack {
                        HStack {
                            Text("BILL TOTAL")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 150.0)
                            
                            Spacer()
                            
                            HStack(alignment: .top){
                                TextField("TOTAL", text: $vm.totalValue)
                                    .font(.system(size: 50.0,weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 25)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .focused($isTotalInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") {
                                                isTotalInputActive = false
                                            }.padding(.trailing, 16)
                                        }
                                    }
                                
                                
                                TextField("deci", text: $vm.decimalValue)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 60.0)
                                    .padding(.leading, 0)
                                    .padding(.top, 5)
                                    .keyboardType(.decimalPad)
                                    .focused($isTotalInputActive)
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 100)
                    
                    HStack {
                        Text("TIP")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                        
                        Text("custom >".uppercased())
                            .font(.title3)
                            .foregroundColor(.white)
                            .onTapGesture {
                                self.isEditTip.toggle()
                            }
                        
                        
                    }
                    .padding([.leading,.trailing], 20)
                    
                    
                    HStack(spacing: 16.0) {
                        Button {
                            
                        } label: {
                            Image("substract")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 50.0,height: 50.0)
                          
                            
                        }

                            TextField("Tip", text: $vm.tip)
                            .onChange(of: vm.tip, perform: { newValue in
                                let oldval = newValue.replacingOccurrences(of: "%", with: "") + "%"
                                vm.tip = oldval
                            })
                                .font(.system(size: 40.0, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth * 0.5)
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                                .focused($isTotalInputActive)
                                .allowsHitTesting(self.isEditTip)
                        
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 50.0,height: 50.0)
                        }
                        
                    }
                    .padding()
                    
                    
                } //:VSTACK
            }//:SCROLL VIEW
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.size.width)
            .background(
                Gradient(colors: [vm.topclr, vm.btmclr])
            )
        }//:ZSTACK
    }
}


//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
