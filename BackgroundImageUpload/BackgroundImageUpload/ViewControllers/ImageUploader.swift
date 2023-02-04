//
//  ImageUploader.swift
//  BackgroundImageUpload
//
//  Created by Milind Trivedi on 28/01/23.
//

import UIKit

class ImageUploader: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!

    var arrofImg = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10")]
    
    //var arrofImg = [UIImage(named: "1")]

    let model = FileUploader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.img.image = arrofImg[0]
        
        //Absolutely no need just cleaning up garbage
        
    }

    @IBAction func btnUploadTappex(_ sender: Any) {
        
        //Show some loading effect here
        
        //arrofURL is an array where we will append URLs of image you can choose to save these URLS in DB as well to handle cases when app goes in background or gets terminated you dont need to send all images again you can save the progress and resume from where it was left
        
        var arrofURL = [URL]()
        
        //serverURL
        
        let serverURL = URL(string: "http://127.0.0.1:5000/upload")
        
        guard let finaleserverURL = serverURL else {
            return
        }
        
        //Loop through image array and save the image in document's directory
        
        for images in self.arrofImg {
            saveImageInDocumentDirectory(tempImage: images!) { (url) in
                if url != nil{
                    arrofURL.append(url!)
                }
            }
        }
        
        //Start uploading
        
        if arrofURL.count > 0 {
            //model.uploadFiles(files: arrofURL, to: finaleserverURL)
            //for items in arrofImg {
                //requestNativeImageUpload(image: items!)
                let newmodel = FileUploaderII()
                newmodel.uploadFiles(files: arrofURL, to: URL(string: "http://127.0.0.1:5000/upload")!)
            //}
        }
    }
    
    
    func requestNativeImageUpload(image: UIImage) {

        guard let url = URL(string: "http://127.0.0.1:5000/upload") else { return }
        
       
        
        let boundary = generateBoundary()
        var request = URLRequest(url: url)

        let parameters = ["custom": "Hello"]

        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }

        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
                    "Accept": "application/json",
                    "Content-Type": "multipart/form-data; boundary=\(boundary)"]

        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody

        let session = URLSession.shared
        session.uploadTask(with: request, fromFile: mediaImage.localurl) { (data, response, error) in
            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }


    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        let body = NSMutableData()

        if let parameters = params {
            for (key, value) in parameters {
                body.appendString("--\(boundary + lineBreak)")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.appendString("\(value + lineBreak)")
            }
        }

        if let media = media {
            for photo in media {
                body.appendString("--\(boundary + lineBreak)")
                body.appendString("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.appendString("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.appendString(lineBreak)
            }
        }

        body.appendString("--\(boundary)--\(lineBreak)")

        return body as Data
    }
}


extension Data {
    mutating func append(_ string: String) {
     

   if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    let localurl: URL

    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"

        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        self.data = data
        
        let tempDir = FileManager.default.temporaryDirectory
        self.localurl = tempDir.appendingPathComponent("throwaway")
        try? data.write(to: localurl)
    }
}





class FileUploaderII: NSObject, URLSessionTaskDelegate {
    
    private let semaphore = DispatchSemaphore(value: 2)
    private let session: URLSession
    
    override init() {
        let configuration = URLSessionConfiguration.background(withIdentifier: "milind.vg.fetch.request")
        session = URLSession(configuration: configuration, delegate: BackgroundSessionDelegate(), delegateQueue: nil)
    }
    
    func uploadFiles(files: [URL], to url: URL) {
        DispatchQueue.global().async {
            for file in files {
                self.semaphore.wait()
                self.upload(file: file, to: url, withKey: "file")
            }
        }
    }
    
    private func upload(file: URL, to url: URL, withKey key: String) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let data = createBody(with: file, boundary: boundary, key: key)
        request.httpBody = data
        
        let task = session.uploadTask(with: request, fromFile: file)
        task.resume()
    }
    
    private func createBody(with file: URL, boundary: String, key: String) -> Data {
        let body = NSMutableData()
        
        let fileName = file.lastPathComponent
        let fileData = try! Data(contentsOf: file)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body as Data
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        semaphore.signal()
        if let error = error {
            print("Error uploading file: \(error)")
        } else {
            print("File uploaded successfully")
        }
    }
}
