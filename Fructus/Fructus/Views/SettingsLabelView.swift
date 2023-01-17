//
//  SettingsLabelView.swift
//  Fructus
//
//  Created by Apple on 17/01/23.
//

import SwiftUI

struct SettingsLabelView: View {
    
    //MARK: - PROPERTIES
    var labelText : String
    var labelImage : String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}


    //MARK: - PREVIEW
struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Milind", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
