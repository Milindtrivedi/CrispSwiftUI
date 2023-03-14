//
//  DetailsHeaderView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 07/03/23.
//

import SwiftUI

struct DetailsHeaderView: View {
    
    var backImageName : String
    var rightImageName : String
    var title : String
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    
    var body: some View {
        ZStack {
            HStack {
                Button {
                    if backImageName.localizedCaseInsensitiveContains("arrow") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                } label: {
                    Image(systemName: backImageName)
                        .foregroundColor(.white)
                        .frame(width: 40.0,height: 40.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color(hex: AppConstants.BorderClr))
                        }
                }
                Spacer()
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.title2)
                    
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: rightImageName)
                        .foregroundColor(.white)
                        .frame(width: 40.0,height: 40.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color(hex: AppConstants.BorderClr))
                        }
                }
                
                
            }.padding()
            
        }.background(Color(hex: AppConstants.ViewBackGroundClr))
    }
}

struct DetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsHeaderView(backImageName: "arrow.left", rightImageName: "gear", title: "Swap")
    }
}
