//
//  ViewController.swift
//  APODTest
//
//  Created by Rafael Peñates on 9/26/19.
//  Copyright © 2019 Rafael Peñates. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    @IBOutlet weak var apodTitle: UILabel!
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var apodDescription: UITextView!
    
    let apiUrl = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "APOD Test"
        
        getApod()
    }
    
    func getApod() {
        Alamofire.request(apiUrl, method: .get)
            .responseJSON { response in
                let jsonApod = JSON(response.data!)
                
                self.apodTitle.text = jsonApod["title"].stringValue
                Alamofire.request(jsonApod["url"].stringValue, method: .get)
                    .responseImage { response in
                        if (response.result.value != nil) {
                            let fetchedImage = UIImage(data: response.data!, scale: 1.0)
                            self.apodImage.image = fetchedImage
                        } else {
                            print ("Error loading image")
                        }
                }
                self.apodDescription.text = jsonApod["explanation"].stringValue
                
        }
    }


}

