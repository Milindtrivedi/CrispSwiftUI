//
//  someview.swift
//  AnimatedCheckmarkView
//
//  Created by Apple on 01/03/23.
//

import SwiftUI

struct someview: View {
    
    @State private var isShowLoader = false
    @State private var isShowCompleteEffect = false
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 16.0) {
                Button {
                    self.isShowLoader.toggle()
                } label: {
                    Text("Press me to show loader")
                }
                
                Button {
                    self.isShowCompleteEffect.toggle()
                } label: {
                    Text("Press me to show completion animation ")
                }
                
                
            }
            
            
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        
        .background(
            Color.cyan.opacity(0.3)
        )
        
        .overlay {
            if isShowLoader {
                ZStack {
                    Color(white: 0, opacity: 0.55)
                    //ProgressView().tint(.white)
                    if #available(iOS 16.0, *) {
                        RingAnimation()
                    }
                }.ignoresSafeArea(.all)
                    .onTapGesture {
                        isShowLoader = false
                    }
            } else if isShowCompleteEffect {
                ZStack {
                    Color(white: 0, opacity: 0.55)
                    AnimatedCheckmarkView()
                }.ignoresSafeArea(.all)
                    .onTapGesture {
                        isShowCompleteEffect = false
                    }
            }
        }
        
    }
}

struct someview_Previews: PreviewProvider {
    static var previews: some View {
        someview()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
