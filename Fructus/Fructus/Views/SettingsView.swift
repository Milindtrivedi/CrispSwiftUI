//
//  SettingsView.swift
//  Fructus
//
//  Created by Apple on 17/01/23.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - BODY
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20.0){
                    //MARK: - SECTION 1
                    
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Milind", labelImage: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10.0) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80.0, height: 80.0)
                                .cornerRadius(9.0)
                            Text ("Most fruits are naturally low in fat, sodium, and calories. None have cholesterol. Fruits are sources of many essential nutrients, including potassium, dietary fiber, vitamins, and much more.")
                                .font(.footnote)
                        }
                    }
                    
                    
                    //MARK: - SECTION 2
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Customization".uppercased(), labelImage: "paintbrush")
                    ) {
                        Divider().padding(.vertical,4)
                        
                        Text("If you wish, you can restart the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
                            .padding(.vertical,8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.secondary)
                                
                            }
                        }
                        .padding()
                        .background {
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8,style: .continuous))
                        }
                    }
                    
                    
                    //MARK: - SECTION 3
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application".uppercased(), labelImage: "apps.iphone")
                    ) {
                        SettingsRowView(name: "Developer", content: "Milind Trivedi")
                        SettingsRowView(name: "Designer", content: "Milind Trivedi")
                        SettingsRowView(name: "Compatibility", content: "iOS 15")
                        SettingsRowView(name: "Website",linkLabel: "Milind Trivedi", linkDestination: "github.com/Milindtrivedi")
                        SettingsRowView (name: "Twitter", linkLabel: "@MilindTrivedi", linkDestination:
                        "twitter.com/Trivedimilind47")
                        SettingsRowView(name: "SwiftUI", content: "3.0")
                        SettingsRowView(name: "Version", content: "1.3.4")
                        
                    } //: BOX
                    
                }//: VSTACK
                .padding()
                .navigationBarTitle(Text("Settings"),displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                )
                
            }//: SCROLL
        }//: NAVIGATION
    }
}

//MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
