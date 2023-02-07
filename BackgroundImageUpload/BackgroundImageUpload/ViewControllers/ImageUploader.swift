//
//  ImageUploader.swift
//  BackgroundImageUpload
//
//  Created by Milind Trivedi on 05/02/23.
//

import UIKit

class ImageUploader: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    
    let model = FileUploader()
    var arrofImg = [UIImage]()
    var arrofURL = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrofImg = self.getImageArray()
        self.img.image = arrofImg[0]
    }
    
    @IBAction func btnUploadTappex(_ sender: Any) {
        
        //Show some loading effect here

        //serverURL
        
        let serverURL = URL(string: "http://127.0.0.1:5000/upload")
        
        guard let finaleserverURL = serverURL else {
            return
        }
        
        //Start uploading
        
        if arrofURL.count > 0 {
            model.uploadFiles(files: arrofURL, to: finaleserverURL)
        } else {
            print("Array of Files is empty please check for append or deletion of files from the file manager")
        }
    }
    
    fileprivate func getImageArray() -> [UIImage] {
        
        //arrofURL is an array where we will append URLs of image you can choose to save these URLS in DB as well to handle cases when app goes in background or gets terminated you dont need to send all images again you can save the progress and resume from where it was left
        
        var arrayOfImage = [UIImage]()
        for _ in 0...14 {
            for images in 1...10 {
                arrayOfImage.append(UIImage(named: String(describing: images)) ?? UIImage())
                
                //Loop through image array and save the image in document's directory you can use temp directory with which you can relinquish it when operation gets completed I chose to persist it for caching and future retrivals. You can always manually call the delete on all files or even a particular set of files
                
                saveImageInDocumentDirectory(tempImage: UIImage(named: String(describing: images)) ?? UIImage()) { (url) in
                    if url != nil{
                        self.arrofURL.append(url!)
                    }
                }
            }
        }
        return arrayOfImage
    }
    //:END CLASS
}
