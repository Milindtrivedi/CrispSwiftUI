//
//  ContentView.swift
//  CryptoWallet
//
//  Created by Apple on 07/03/23.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        ZStack {
            VStack(spacing: 16.0){
                HeaderView()
                    .padding()
                Spacer()
            }
        }.background(Color(hex: "0D0C0F"))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
