//
//  animals.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = Bundle.main.path(forResource: "animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForAnimalsJSON!))

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! JSONSerialization.jsonObject(with: rawAnimalsJSON!, options: .allowFragments) as! NSDictionary

func parseJSONAsDictionary(_ dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    guard let photosDict = parsedAnimalsJSON["photos"] as? NSDictionary else {
        print("Cannot find key 'photos' in \(parsedAnimalsJSON)")
        return
    }
    
    guard let totalAnimalPhotos = photosDict["total"] as? Int else {
        print("Cannot find key 'total' in \(photosDict)")
        return
    }
    
    totalAnimalPhotos
    photosDict["total"]
    
    guard let arrayOfPhotos = photosDict["photo"] as? [[String: AnyObject]] else {
        print("Cannot find key 'photo' in \(photosDict)")
        return
    }
    

    
}

parseJSONAsDictionary(parsedAnimalsJSON)

//
//let blogs = json["blogs"] as? [[String: Any]] {
//    for blog in blogs {
//        if let name = blog["name"] as? String {
//            names.append(name)
//        }
//}
