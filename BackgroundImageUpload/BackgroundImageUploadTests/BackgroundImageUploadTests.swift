//
//  BackgroundImageUploadTests.swift
//  BackgroundImageUploadTests
//
//  Created by Apple on 06/02/23.
//

import XCTest
@testable import BackgroundImageUpload

final class BackgroundImageUploadTests: XCTestCase {
    
    var model : FileUploader!
    let serverUrl = URL(string: "http://127.0.0.1:5000/upload")!
    var arrayOfImage = [UIImage]()
    var arrofURL = [URL]()
    
    override func setUp() {
        super.setUp()
        model = FileUploader()
        for _ in 0...1 {
            for images in 1...10 {
                arrayOfImage.append(UIImage(named: String(describing: images)) ?? UIImage())
                saveImageInDocumentDirectory(tempImage: UIImage(named: String(describing: images)) ?? UIImage()) { (url) in
                    if url != nil{
                        self.arrofURL.append(url!)
                    }
                }
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        try! DeleteAllDocumentsFromDirectory()
        model = nil
        arrayOfImage = []
        arrofURL = []
    }
    
    
    // Test if the file uploads are happening correctly
    func testFileUpload() {
        model.uploadFiles(files: arrofURL, to: serverUrl)
        // Wait for 5 seconds to allow the uploads to complete
        sleep(5)
        XCTAssertEqual(model.uploadTasks.count, arrofURL.count, "All files not uploaded")
    }
    
    //Here in this Test we will just upload a single item and validate response
    func testResponse() {
        let expectation = self.expectation(description: "Upload complete")
        model.uploadFiles(files: [arrofURL.first!], to: serverUrl)
        // Wait for a second to allow the uploads to complete as this is just "1" Single file
        sleep(1)
        for task in model.uploadTasks {
            task.resume()
            task.cancel()
            // Check the response
            guard let resp = task.response as? HTTPURLResponse else {
                XCTAssertFalse(true, "Failed to get a response")
                return
            }
            XCTAssertEqual(resp.statusCode, 200, "Wrong response returned")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // Test if the right number of concurrent uploads are happening
    func testConcurrentUploads() {
        model.uploadFiles(files: arrofURL, to: serverUrl)
        // Wait for 5 seconds to allow the uploads to complete
        sleep(5)
        XCTAssertLessThanOrEqual(model.uploadTasks.count, arrayOfImage.count, "Too many concurrent uploads")
    }
}
