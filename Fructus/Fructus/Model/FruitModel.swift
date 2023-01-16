//
//  FruitModel.swift
//  Fructus
//
//  Created by Apple on 11/01/23.
//

import SwiftUI

//MARK: - DATA MODEL FOR FRUIT

struct Fruit : Identifiable {
    var id = UUID()
    var title : String
    var headline : String
    var image : String
    var gradientColors : [Color]
    var description : String
    var nutrition : [String]
}
