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
    
    let boundary : String!
    
    let result: DispatchTimeoutResult
    
    override init() {
        self.session = URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
        boundary = "Boundary-\(UUID().uuidString)"
        result = FileUploader.semaphore.wait(timeout: .now() + .seconds(5))
    }
    
    
    func uploadFiles(files: [URL], to url: URL) {
        
        // Iterate over the file URLs
        
        for file in files {
            // Wait for a semaphore to be available
            // FileUploader.semaphore.wait() this can be used but you might end up awaiting for a very long time if server doesn't respond and can run into deadlock so we will avoid it and use timeout interval instead
            
            
            
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
                    
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    request.addValue("multipart/form-data; boundary=\(String(describing: self.boundary!))", forHTTPHeaderField: "Content-Type")
                    
                    request.httpMethod = "POST"
                    
                    
                    //create a multipart form data body for the request
                    
                    //let fileData = try! Data(contentsOf: file)
                    
                    //created body using a separate function for the ease of adapting change
                    
                    
                    let formData = self.createDataBody(withParameters: ["file" : "one"], media: file, boundary: self.boundary, keyPath: "file")
                    // Set the request body and headers
                    
                    request.httpBody = formData
                    
                    // Add token if needed this is just for an example
                    
                    // request.addValue(self.token, forHTTPHeaderField: "Authorization")
                    
                    // Create a upload task for the request
                    
                    //                    for uploadingfiles in files {j
                    let task = self.session.uploadTask(with: request, fromFile: file)
                    // Start the task and store it in the upload tasks array
                    task.resume()
                    self.uploadTasks.append(task)
                    
                    //}
                }
            }
        }
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
    
    func createDataBody(withParameters params: [String: String]?, media: URL, boundary: String, keyPath: String) -> Data {
        
        let lineBreak = "\r\n"
        let body = NSMutableData()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.appendString("--\(boundary + lineBreak)")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.appendString("\(value + lineBreak)")
            }
        }
        
        
//        for photo in media {
            body.appendString("--\(boundary + lineBreak)")
            body.appendString("Content-Disposition: form-data; name=\"\(keyPath)\"; filename=\"\(media.lastPathComponent)\"\(lineBreak)")
            body.appendString("Content-Type: \(self.mimeType(forPathExtension: media.pathExtension) + lineBreak + lineBreak)")
            
            do  {
                let data = try Data(contentsOf: media)
                body.append(data)
            } catch let err {
                print(err.localizedDescription)
            }
            body.appendString(lineBreak)
//        }
        
        
        body.appendString("--\(boundary)--\(lineBreak)")
        
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
            
            //HERE's the right time to perform some UI changes
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        let progressPercentage = Int(progress * 100)
        
        print("Progress >>\(String(describing: progress))", "Percentage >>\(String(describing: progressPercentage))")
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


extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


public func DeleteAllDocumentsFromDirectory() throws {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,includingPropertiesForKeys: nil,options: .skipsHiddenFiles)
        for fileURL in fileURLs {
            try FileManager.default.removeItem(at: fileURL)
        }
    } catch  { print(error) }
    
}
