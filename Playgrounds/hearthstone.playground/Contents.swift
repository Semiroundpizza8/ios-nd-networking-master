//
//  hearthstone.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = Bundle.main.path(forResource: "hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForHearthstoneJSON!))

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! JSONSerialization.jsonObject(with: rawHearthstoneJSON!, options: .allowFragments) as! NSDictionary

func parseJSONAsDictionary(_ dictionary: NSDictionary) {
    
    var fiveCost = 0
    var twoDurabilityWeapons = 0
    var battlecries = 0
    var totalCostOfCommonMinions = 0.0
    var totalNumOfCommonMinions = 0.0
    var statsToCostRatio = 0.0
    var minionCount = 0.0
    
    guard let hearthDict = parsedHearthstoneJSON["Basic"] as? [[String:AnyObject]] else {
        print("Cannot find key 'Basic' in \(parsedHearthstoneJSON)")
        return
    }
    hearthDict[0]
    
    for (index, card) in hearthDict.enumerated() {
        let cost = card["cost"] as? Double
        let type = card["type"] as? String
        let durability = card["durability"] as? Int
        let cardText = card["text"] as? String
        let rarity = card["rarity"] as? String
        let attack = card["attack"] as? Double
        let health = card["health"] as? Double
        
        
        if type == "Minion" {
            
            //Find the number of 5 cost minions
            if cost == 5 {
                fiveCost += 1
            }
            
            //Find the number of minions w/ Battlecries
            if cardText?.range(of: "Battlecry") != nil {
                battlecries += 1
            }
            
            //Find the average cost of Common minions start
            if rarity == "Common" {
                totalCostOfCommonMinions += cost!
                totalNumOfCommonMinions += 1.0
            }
            
            //Attack+Health/Cost Ratio Start
            if cost != 0 {
                statsToCostRatio += ((attack! + health!)/cost!)
                minionCount += 1.0
                
            }
        } else if type == "Weapon" {
            if durability == 2 {
                twoDurabilityWeapons += 1
            }
        }
    }
    
    print(fiveCost)
    print(twoDurabilityWeapons)
    print(battlecries)
    print("Common Minions: \(totalNumOfCommonMinions) Total Cost: \(totalCostOfCommonMinions)")
    print(totalCostOfCommonMinions/totalNumOfCommonMinions)
    print(statsToCostRatio/minionCount)
}

parseJSONAsDictionary(parsedHearthstoneJSON)
