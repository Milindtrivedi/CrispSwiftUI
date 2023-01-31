//
//  ImageUploaderViewModel.swift
//  BackgroundImageUpload
//
//  Created by Apple on 28/01/23.
//

import Foundation
import Combine
import UIKit
import Dispatch


class FileUploader : NSObject {

    let param = ["yourparam" : "one", "yourparam" : "two"]
    
    var progress: Float = 0.0
    
    let token = "Bearer yourtokenstringhere"

    // Create a semaphore to control the number of concurrent uploads you can just put your file array count here dynamically
    static let semaphore = DispatchSemaphore(value: 5)
    
    // Create a background queue to perform the uploads
    private let queue = DispatchQueue(label: "com.example.fileUploader.queue", qos: .background)
    
    // Create URL session configurations and add an identifier to it

    private let sessionConfig = URLSessionConfiguration.background(withIdentifier: "com.yourdomain.uploadfiles")
    
    // Create a URL session to perform the uploads
    
    private var session : URLSession
    
    // Create an array to store the upload tasks
    private var uploadTasks: [URLSessionUploadTask] = []
    
    let delegate = BackgroundSessionDelegate()
    
    override init() {
        self.session = URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
    }
  
    func uploadFiles(files: [URL], to url: URL) {
        
        // Iterate over the file URLs
        for file in files {
            
            // Wait for a semaphore to be available
            FileUploader.semaphore.wait()
            
            // Start the upload in the background queue
            queue.async { [weak self] in
                
                // Check if the weak self reference exists
                guard let self = self else { return }
                
                // Create a URL request to the upload URL
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                //create a multipart form data body for the request
            
                let fileData = try! Data(contentsOf: file)
                
                //created body using a separate function for the ease of adapting change
                
                let formData = self.createMultipartFormData(parameters: self.param, fileData: fileData, fileName: file.lastPathComponent, mimeType: "image/jpeg", boundary: "Boundary-\(UUID().uuidString)")
                
                // Set the request body and headers
                
                request.httpBody = formData
                
                // Add token if needed this is just for an example
                
                request.addValue(self.token, forHTTPHeaderField: "Authorization")
                
                // Create a upload task for the request
                let task = self.session.uploadTask(with: request, fromFile: file)
 
                // Start the task and store it in the upload tasks array
                task.resume()
                self.uploadTasks.append(task)
            }
        }
    }
    
    func createMultipartFormData(parameters: [String: String], fileData: Data, fileName: String, mimeType: String, boundary: String) -> Data {
        let body = NSMutableData()

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body as Data
    }
}

class BackgroundSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let error = error {
            // Handle the error
            print("Error uploading file: \(error)")
        } else if let response = task.response as? HTTPURLResponse, response.statusCode != 200 {
            // Handle the server error
            print("Server error: \(response.statusCode)")
        } else {
            // Handle the success
            FileUploader.semaphore.signal()
            let response = task.response as? HTTPURLResponse
            print("_____________________________")
            print("STATUS CODE :" ,String(describing: response?.statusCode))
            print("RESPONSE :" ,String(describing: response))
            print("_____________________________")
            print("File uploaded successfully")
            
            //HERE's the right time to perform some changes
        }
        
    }
    
}

public func saveImageDocumentDirectoryWithDate(tempImage:UIImage, block : @escaping (_ url: URL?) -> Void ){
    
    let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let random : String = randomString(length: 5)
    let fileURL = documentsDirectoryURL.appendingPathComponent(String(format:"CPImage%@.png",random))
    do {
        try tempImage.pngData()?.write(to: fileURL)
    } catch {
        block(nil)
    }
    block(fileURL)
}

public func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}
