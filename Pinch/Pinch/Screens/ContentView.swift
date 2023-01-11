//
//  ContentView.swift
//  Pinch
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTY
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    @State private var isDrawerOpen : Bool = false
    
    let pages : [Page] = pagesData
    @State private var pageIndex : Int = 1
    
    //MARK: - FUNCTION
    
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    //MARK: - CONTENT
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                //MARK: - PAGE IMAGE
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                //MARK: - 1. Tap Gesture
                
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else{
                            resetImageState()
                        }
                    }
                
                //MARK: - 2. Drag Gesture
                
                    .gesture(
                        
                        DragGesture()
                            .onChanged({ val in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = val.translation
                                }
                            })
                        
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                
                //MARK: - 3. Magnification Gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ val in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = val
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            })
                        
                            .onEnded({ val in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                        
                    )
                
                
            } //: ZSTACK VIEW
            
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            //MARK: - INFO PANEL
            
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            
            //MARK: - CONTROLS
            
            .overlay(
                Group{
                    
                    HStack{
                        
                    //MARK: - SCALE DOWN
                        
                        Button{
                            withAnimation(.spring()){
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                     
                                }
                            }
                            
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                    //MARK: - RESET
                        
                        Button{
                            
                            resetImageState()
                            
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        
                    //MARK: - SCALE UP
                        
                        Button{
                            
                            withAnimation(.spring()){
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                     
                                }
                            }
                            
                            
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    } //CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12.0)
                    .opacity(isAnimating ? 1 : 0)
                    
                }
                .padding(.bottom,30)
                ,alignment: .bottom
            )
            
            .overlay(
                HStack(spacing: 12){
                    //MARK: - DRAWER HANDLE
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(count: 1) {
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        }
                    
                    //MARK: - THUMBNAILS
                    
                    ScrollView(.horizontal) {
                        HStack {
                        ForEach(pages){ dt in
                            Image(dt.thumbnail)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                                .opacity(isDrawerOpen ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                                .onTapGesture(count: 1) {
                                    isAnimating = true
                                    pageIndex = dt.id
                                }
                        }
                    }
                        }
                       
                    
                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 0 : UIScreen.main.bounds.width - 40)
                , alignment: .topTrailing
            )
            
        } //: NAVIGATION VIEW
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).previewDevice("iPhone 13")
    }
}
