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
        UrlParser.shared.parse(regex: .hostname)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

