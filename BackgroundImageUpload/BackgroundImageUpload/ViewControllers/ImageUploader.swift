//
//  ImageUploader.swift
//  BackgroundImageUpload
//
//  Created by Apple on 28/01/23.
//

import UIKit

class ImageUploader: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!

    var arrofImg = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10")]
    

    let model = FileUploader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.img.image = arrofImg[0]
        
    }

    @IBAction func btnUploadTappex(_ sender: Any) {
    
        //Show some loading effect here
        
        //arrofURL is an array where we will append URLs of image
        
        var arrofURL = [URL]()
        
        //serverURL
        
        let serverURL = URL(string: "YOUR BASE + ENDPOINT URl")
        
        guard let finaleserverURL = serverURL else {
            return
        }
        
        //Loop through image array and save the image in document's directory
        
        for images in self.arrofImg {
            saveImageDocumentDirectoryWithDate(tempImage: images!) { (url) in
                if url != nil{
                    arrofURL.append(url!)
                }
            }
        }
        
        //Start uploading
        
        if arrofURL.count > 0 {
            model.uploadFiles(files: arrofURL, to: finaleserverURL)
        }
    }
}
