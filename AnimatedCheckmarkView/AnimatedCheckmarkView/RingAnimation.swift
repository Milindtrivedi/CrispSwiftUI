//
//  RingAnimation.swift
//  AnimatedCheckmarkView
//
//  Created by Apple on 01/03/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct RingAnimation: View {
    
    @State private var drawingStroke = false
    
    let strawberry = Color(#colorLiteral(red: 1, green: 0.1843137255, blue: 0.5725490196, alpha: 1))
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    let ice = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
    let customloadingclr = Color(#colorLiteral(red: 0.9725490196, green: 0.6078431373, blue: 0.02745098039, alpha: 1))
    
    let animation = Animation
        .easeOut(duration: 3)
        .repeatForever(autoreverses: false)
        .delay(0.5)
    
    
    var body: some View {
        ZStack {
            //Color.black
            ring(for: customloadingclr)
                .frame(width: UIScreen.screenWidth * 0.4)
//            ring(for: lime)
//                .frame(width: 128)
//            ring(for: ice)
//                .frame(width: 92)
        }
        .animation(animation, value: drawingStroke)
        .onAppear {
            drawingStroke.toggle()
        }
        .ignoresSafeArea()
    }
    
    func ring(for color: Color) -> some View {
        // Background ring
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay {
                // Foreground ring
                Circle()
                    .trim(from: 0, to: drawingStroke ? 1 : 0)
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}

struct RingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            RingAnimation()
        } else {
            // Fallback on earlier versions
        }
    }
}
