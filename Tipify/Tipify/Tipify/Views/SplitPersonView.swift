//
//  SplitPersonView.swift
//  Tipify
//
//  Created by Milind Trivedi on 03/03/23.
//  Copyright Milind Trivedi © 2023 all rights reserved

import SwiftUI

struct SplitPersonView: View {
    
    @ObservedObject var BindedVM : viewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                HStack {
                    Text("Split".uppercased())
                        .font(.title3)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Text("".uppercased())
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding([.leading,.trailing], 20)
                
                HStack(spacing: 16.0) {
                    Button {
                        BindedVM.StepperSplitMinusTapped()
                    } label: {
                        Image("substract")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50.0,height: 50.0)
                    }
                    
                    ZStack {
                        TextField("", text: $BindedVM.Persons)
                            .font(.system(size: 40.0, weight: .semibold))
                            .foregroundColor(.white)
                        
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .minimumScaleFactor(0.9)
                    }
                    .frame(width: UIScreen.screenWidth * 0.5)
                
                    Button {
                        BindedVM.StepperSplitPlusTapped()
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
        .onChange(of: BindedVM.Persons) { newValue in
            BindedVM.performCalculations()
        }
    }
}

struct SplitPersonView_Previews: PreviewProvider {
    static var previews: some View {
        SplitPersonView(BindedVM: viewModel())
    }
}
