//
//  AssetRow.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct AssetRow: View {
    var body: some View {
        
        ZStack{
            
            HStack(alignment:.center, spacing: 16.0) {
                
                Image(systemName: "pencil.circle")
                    
                
                VStack(spacing: 16.0){
                    
                    HStack {
                        Text("datum.name")
                            .foregroundColor(Color.white)
                            .font(.title2)
                        
                        Spacer()
                        
                        Text("datum.price")
                            .foregroundColor(Color.white)
                            .font(.title2)
                        
                        
                    }
                    
                    HStack {
                        Text("datum.name")
                            .foregroundColor(Color(hex: AppConstants.TextlightGrayClr))
                            .font(.title3)
                        
                        Spacer()
                        
                        Text("datum.price")
                            .foregroundColor(Color(hex: AppConstants.TextYellowClr))
                            .font(.title3)
                        
                        
                    }
                }
                
            }
        }.background(Color.black)
    }
}

struct AssetRow_Previews: PreviewProvider {
    static var previews: some View {
        AssetRow()
    }
}



struct coinAssetDetails : Identifiable, Hashable {
    
    var name : String
    var price : String
    var perunitPrice : String
    var variance : String
    var id = UUID()
    var logo : String
    
}

