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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let webServer = GCDWebServer()
        let mainBundle = Bundle.main
        let jquery = mainBundle.url(forResource: "jquery-1.11.3.min", withExtension: "js")
        let jqueryAudio = mainBundle.url(forResource: "jquery.cleanaudioplayer", withExtension: "js")
        let playerCss = mainBundle.url(forResource: "player", withExtension: "css")
        print (jquery)
        var myHtml : String = "<!DOCTYPE html>\n" +
            "<html lang=\"en\">\n" +
            "<head>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n" +
            "    <title>Index</title>\n" +
            "    <script src=\"jquery-1.11.3.min.js\"></script>\n" +
            "    <script src=\"jquery.cleanaudioplayer.js\"></script>\n" +
            "    <link href=\"player.css\" rel=\"stylesheet\">\n" +
            "</head>\n" +
            "<body>\n" +
            "        <div class=\"mediatec-cleanaudioplayer\">\n" +
            "            <ul>" +
        "                   <li>chi</li>" +
            "            </ul>\n" +
            "        </div>\n" +
            "</body>\n" +
            "</html>"
        
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
            return GCDWebServerDataResponse(html: myHtml)
            
        })

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


