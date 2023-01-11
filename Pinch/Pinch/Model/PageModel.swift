//
//  PageModel.swift
//  Pinch
//
//  Created by Milind Trivedi on 06/09/22.
//

import Foundation


struct Page : Identifiable {
    let id : Int
    let imageName : String
}

extension Page {
    var thumbnail : String {
        return "thumb-" + imageName
    }
}
