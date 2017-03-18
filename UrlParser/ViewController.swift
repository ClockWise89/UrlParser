//
//  ViewController.swift
//  UrlParser
//
//  Created by Christopher Eliasson on 2017-03-16.
//  Copyright © 2017 Christopher Eliasson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseString = "http://username:password@hostname/path?arg=value#anchor"
        let regexForBase: [RegexType] = [.scheme, .hostname, .username, .password, .path, .fragment, .query]
        
        let exampleString = "http://clockwise:difficultP455w0rd@celiasson.se/swift101/C:/myFolder?token=123847192asudhiIUjsa&loggedIn=true#anchor"
        let regexForFullExample: [RegexType] = [.scheme, .hostname, .username, .password, .path, .fragment, .query, .extractedQuery]
        
        let baseMap = RegexParser.shared.parse(text: baseString, with: regexForBase)
        
        print("****************************************************************")
        print(baseString)
        baseMap.forEach{
            print("----------------")
            print("Key: \($0.key)")
            print("Value: \($0.value)")
        }
        
        print("")
        print("****************************************************************")
        print(exampleString)
        
        let exampleMap = RegexParser.shared.parse(text: exampleString, with: regexForFullExample)
        exampleMap.forEach{
            print("----------------")
            print("Key: \($0.key)")
            print("Value: \($0.value)")
        }
    }
}

