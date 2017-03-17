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
        
        let regexForUrl: [RegexType] = [.scheme, .hostname, .username, .password, .path, .fragment, .fullQuery]
        let regexForQuery: [RegexType] = [.queryArgs, .queryValues]
        let map = RegexParser.shared.parse(text: "http://username:password@hostname/path?hej=hå&sug=min&kalle=tå#anchor", with: regexForQuery)
        var test = 0
    }
}

