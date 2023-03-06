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
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false){
                VStack(spacing: 16.0) {
                    
                    //:HEADER BILL INPUT VIEW
                    BillInputView(BindedVM: vm)
                    
                    //:MIDDLE SECTION TIP INPUT VIEW
                    TipView(BindedVM: vm)
                    
                    //:MIDDLE SECTION SPLIT BETWEEN PERSON VIEW
                    SplitPersonView(BindedVM: vm)
                    
                    //:BOTTOM SECTION PER PERSON SPLIT VIEW
                    PerPersonView(BindedVM: vm)
                    
                    //:FOOTER SECTION PER PERSON TOTAL VIEW
                    EachTotalView(BindedVM: vm)
                    
                    
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
