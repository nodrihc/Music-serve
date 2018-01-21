//
//  ViewController.swift
//  Music-Serve
//
//  Created by Chirdon Mohamed Houssein on 04/01/2018.
//  Copyright © 2018 Chirdon Mohamed Houssein. All rights reserved.
//
import UIKit
import Foundation
import GCDWebServer

class ViewController: UIViewController {
let serveur = Server()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func startServer(_ sender: UIButton) {
       
        serveur.runServer()
    }
}


