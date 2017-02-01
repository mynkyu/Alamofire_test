//
//  ViewController.swift
//  Alamofire_test
//
//  Created by User on 2017. 1. 20..
//  Copyright © 2017년 User. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        requestFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func requestFromServer() {
        let userString = "users"
        Alamofire.request("https://blink-154607.appspot-preview.com/" + userString, method: .get).responseJSON { (response) in
            switch(response.result) {
            case .success(let value):
                // construct the JSON
                let json = JSON(value)
                var data = ""

                // returns nil if it's not an array
                if let users = json["users"].array {
//                    for user in users {
//                        print(user["userInfo"]["nickname"].string ?? "cannot load nickname")
//                        print(user["userInfo"]["age"].int ?? "cannot load age")
//                    }
                    for user in users {
                        if let cardStories = user["cardStories"].array {
                            for cardStory in cardStories {
                                data = cardStory["imageUri"].string ?? "load imageUrl fail"
                                let imageUrl = URL(string: data)!
                                if (cardStory["imageUri"].string?.contains("https"))! {
                                    print(cardStory["imageUri"].string ?? "load imageUrl fail")
                                    DispatchQueue.main.async {
                                        let data = try? Data(contentsOf: imageUrl)
                                        self.imageView.image = UIImage(data: data!)!
                                    }
                                }
                                break
                            }
                        }
                    }
                }

                
//                performUIUpdatesOnMain { // explanation is in GCDBlackBox.swift (backgroudn to main)
//                    self.imageView.image = [UIImage imageWithContentsOfURL, data:data]
//                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
//            print(AlamofireResponse.result.value!)
        }
    }
}

