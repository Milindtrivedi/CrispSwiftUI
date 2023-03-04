//
//  TipView.swift
//  Tipify
//
//  Created by Apple on 04/03/23.
//

import SwiftUI

struct TipView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                HStack {
                    Text("TIP")
                        .font(.title3)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Text("custom >".uppercased())
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding([.leading,.trailing], 20)
                
                HStack(spacing: 16.0) {
                    Button {
                        BindedVM.StepperMinusTapped()
                    } label: {
                        Image("substract")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50.0,height: 50.0)
                    }
                    ZStack {
                        Text(BindedVM.tip + "%")
                            .font(.system(size: 40.0, weight: .semibold))
                            .foregroundColor(.white)
                        TextField("", text: $BindedVM.tip)
                            .font(.system(size: 40.0, weight: .semibold))
                            .foregroundColor(.clear)
                        
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                    }
                    .frame(width: UIScreen.screenWidth * 0.5)
                    Button {
                        BindedVM.StepperPlusTapped()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50.0,height: 50.0)
                    }
                }
                .padding()
            }
        }//.background(.black)
        .onChange(of: BindedVM.tip) { newValue in
            BindedVM.performCalculations()
        }
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        TipView(BindedVM: viewModel())
    }
}
