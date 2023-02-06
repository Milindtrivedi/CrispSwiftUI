//
//  BackgroundImageUploadTests.swift
//  BackgroundImageUploadTests
//
//  Created by Apple on 06/02/23.
//

import XCTest
@testable import BackgroundImageUpload

final class BackgroundImageUploadTests: XCTestCase {
    
    var model = FileUploader()
    let url = URL(string: "http://127.0.0.1:5000/upload")!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var arrofImage = [UIImage]()
        var arrofURL = [URL]()
        for _ in 0...2 {
            for images in 1...10 {
                arrofImage.append(UIImage(named: String(describing: images))!)
            }
        }
        
        for image in arrofImage {
            
            saveImageInDocumentDirectory(tempImage: image) { url in
                arrofURL.append(url!)
            }
        }
        
        model.uploadFiles(files: arrofURL, to: url)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testExample() throws {
    }
    
    func testPerformanceExample() throws {

    }
}
