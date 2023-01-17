//
//  SettingsRowView.swift
//  Fructus
//
//  Created by Apple on 17/01/23.
//

import SwiftUI

struct SettingsRowView: View {
    
    //MARK: - PROPERTIES
    
    var name : String
    var content : String? = nil
    var linkLabel : String? = nil
    var linkDestination : String? = nil
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            Divider().padding(.vertical,4)
            HStack {
                Text(name)
                    .foregroundColor(Color.gray)
                Spacer()
                if (content != nil) {
                    Text(content!)
                } else if (linkLabel != nil && linkDestination != nil) {
                    Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.pink)
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
            }
        }//: VSTACK
    }
}




//MARK: - PREVIEW
struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(name: "Developer", content: "Milind Trivedi")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
        
        SettingsRowView(name: "Website",linkLabel: "Milind Trivedi", linkDestination: "www.github.com/MilindTrivedi47")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
            .preferredColorScheme(.dark )
    }
}
