//
//  CryptoChartView.swift
//  CryptoWallet
//
//  Created by Milind Trivedi on 05/04/25.
//

import SwiftUI

struct CryptoChartView: View {
    
    @Binding var data: [Double]
    @Binding var colors: [Color]
    
    @State private var animateChart = false
    
    var total: Double {
        data.reduce(0, +)
    }
    
    var body: some View {
        ZStack {
            // Draw each segment
            ForEach(0..<data.count, id: \.self) { index in
                DonutSegment(startAngle: angle(at: index),
                             endAngle: angle(at: index + 1))
                    .trim(from: 0, to: animateChart ? 1 : 0)  // Animate Drawing
                    .stroke(colors[index], lineWidth: 40)
                    .animation(.easeOut(duration: 1.2).delay(Double(index) * 0.2), value: animateChart)
            }
            
            VStack(spacing: 4) {
                Text("80%")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Transactions")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 250, height: 250)
        .background(Color(hex: AppConstants.ViewBackGroundClr))
        .onAppear {
            animateChart = true
        }
        .onChange(of: data) { _ in
            animateChart = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateChart = true
            }
        }
    }
    
    private func angle(at index: Int) -> Angle {
        guard total > 0 else { return .degrees(-90) }
        
        let value = data.prefix(index).reduce(0, +) / total
        return .degrees(value * 360 - 90)
    }
}

struct DonutSegment: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        
        return path
    }
}
