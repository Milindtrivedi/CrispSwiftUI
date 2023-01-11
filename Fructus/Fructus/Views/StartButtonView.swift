 //
//  StartButtonView.swift
//  Fructus
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

struct StartButtonView: View {
    //MARK: - properties
    
    @AppStorage("isOnboarding") var isOnboarding : Bool?
    
    //MARK: - Body
    var body: some View {
        Button(action: {
            self.isOnboarding = false
        })  {
            HStack(spacing: 8) {
                
                Text("Start")
                
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal,16)
            .padding(.vertical,10)
            .background(
                Capsule()
                    .strokeBorder(.white, lineWidth: 1.25)
            )
        } //: Button
        .accentColor(.white)
    }
}


//MARK: - Preview
struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView().preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
