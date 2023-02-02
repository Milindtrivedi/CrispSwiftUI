//
//  ImageUploaderViewModel.swift
//  BackgroundImageUpload
//
//  Created by Milind Trivedi on 28/01/23.
//

import Foundation
import Combine
import Dispatch
import CoreServices
import UIKit


class FileUploader : NSObject {

    let param = ["yourparam" : "one"]
    
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
            // FileUploader.semaphore.wait() this can be used but you might end up awaiting for a very long time if server doesn't respond and can run into deadlock so we will avoid it and use timeout interval instead
            
            let result = FileUploader.semaphore.wait(timeout: .now() + .seconds(5))
            
            if result == .timedOut {
                // The semaphore was not available after 5 seconds, handle accordingly
                print("Semaphore isn't availble even after waiting for 5 seconds so handle accordingly")
                
            } else {
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
                    
                    //let formData = self.createMultipartFormData(parameters: self.param, fileData: fileData, fileName: file.lastPathComponent, mimeType: self.mimeType(forPathExtension: file.pathExtension), boundary: "Boundary-\(UUID().uuidString)", name: "file")
                    
                    let formData = self.createMultipartFormData(parameters: self.param, boundary: "Boundary-\(UUID().uuidString)", data: fileData, mimeType: self.mimeType(forPathExtension: file.pathExtension), filename: file.lastPathComponent)
                    
                    // Set the request body and headers
                    
                    request.httpBody = formData
                    
                    // Add token if needed this is just for an example
                    
                    //request.addValue(self.token, forHTTPHeaderField: "Authorization")
                    
                    // Create a upload task for the request
                    let task = self.session.uploadTask(with: request, fromFile: file)
                    
                    // Start the task and store it in the upload tasks array
                    task.resume()
                    self.uploadTasks.append(task)
                }
            }
        }
    }
    
//    func createMultipartFormData(parameters: [String: String], filePathKey: String, paths: URL, boundary: String) -> Data {
//        let boundary = "Boundary-\(UUID().uuidString)"
//            var body = NSMutableData()
//
//            for (key, value) in parameters {
//                body.append("--\(boundary)\r\n")
//                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.append("\(value)\r\n")
//            }
//
//            body.append("--\(boundary)\r\n")
//            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
//            body.append("Content-Type: \(mimeType)\r\n\r\n")
//            body.append(fileData)
//            body.append("\r\n")
//            body.append("--\(boundary)--\r\n")
//
//            return body
        
        
//        let multipartFormData = MultipartFormData()
//
//
//        for (key, value) in parameters {
//            if let temp = value as? String {
//                multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//            }
//            if let temp = value as? Int {
//                multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//            }
//            if let temp = value as? NSArray {
//                temp.forEach({ element in
//                    let keyObj = key + "[]"
//                    if let string = element as? String {
//                        multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                    } else
//                    if let num = element as? Int {
//                        let value = "\(num)"
//                        multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                    }
//                })
//            }
       // }
        
      
                   // multipartFormData.append(paths, withName: filePathKey)
        
        
        
        
       // return try! multipartFormData.encode()
//    }
    
    
    func createMultipartFormData(parameters: [String: String],
                                boundary: String,
                                data: Data,
                                mimeType: String,
                                filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--".data(using: .utf8)!)
        body.append(boundary.data(using: .utf8)!)
        body.append("--".data(using: .utf8)!)
        
        return body as Data
    }


    
    private func mimeType(forPathExtension pathExtension: String) -> String {
        if
            let id = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue(),
            let contentType = UTTypeCopyPreferredTagWithClass(id, kUTTagClassMIMEType)?.takeRetainedValue()
        {
            return contentType as String
        }

        return "application/octet-stream"
    }
    
    private func contentHeaders(withName name: String, fileName: String? = nil, mimeType: String? = nil) -> [String: String] {
        var disposition = "form-data; name=\"\(name)\""
        if let fileName = fileName { disposition += "; filename=\"\(fileName)\"" }

        var headers = ["Content-Disposition": disposition]
        if let mimeType = mimeType { headers["Content-Type"] = mimeType }

        return headers
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
            
            //HERE's the right time to perform some UI changes
        }
        
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        let progressPercentage = Int(progress * 100)
        
    }
    
}

public func saveImageInDocumentDirectory(tempImage:UIImage, block : @escaping (_ url: URL?) -> Void ){
    
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

//Build input file cannot be found: '/Users/sohilsarkazi/Desktop/BG upload Task/BackgroundImageUpload/BackgroundImageUpload/App/Info.plist'. Did you forget to declare this file as an output of a script phase or custom build rule which produces it?


extension String {
    
    func toData() -> Data {
        return self.data(using: .utf8) ?? Data()
    }
    
}
