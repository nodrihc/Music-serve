//
//  Server.swift
//  Music-Serve
//
//  Created by Chirdon Mohamed Houssein on 19/01/2018.
//  Copyright © 2018 Chirdon Mohamed Houssein. All rights reserved.
//

import Foundation
import GCDWebServer
import MediaPlayer

class Server
{
    let webServer = GCDWebServer()
    let mainBundle = Bundle.main
    let jqueryFile1Path : String = ""
    let jqueryFile2Path : String = ""
    let playerCssPath : String = ""
    var contentFile1 : String = ""
    var contentFile2 : String = ""
    var contentFile3 : String = ""
    var theIndexString : String = ""
    
    
    func runServer() {
        //Media Item
        
        //Test song
        var songTitle : String = "chi"
        var songArtist : String = "chichi"
        var songAlbum : String = "chirdon"
        var songPath : String! = ""
        var songPath2 : String = ""
        
        
        //Get the differents path
        let jqueryFile1Path : String = (mainBundle.path(forResource: "jquery-1.11.3.min", ofType: "js")?.description)!
        let jqueryFile2Path : String = (mainBundle.path(forResource: "jquery.cleanaudioplayer", ofType: "js")?.description)!
        let playerCssPath : String = (mainBundle.path(forResource: "player", ofType: "css")?.description)!
        
        
        //Initialise the html
         theIndexString  = "<!DOCTYPE html>\n" +
            "<html lang=\"en\">\n" +
            "<head>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n" +
            "    <title>Index</title>\n" +
            "    <script src=\"jquery-1.11.3.min.js\"></script>\n" +
            "    <script src=\"jquery.cleanaudioplayer.js\"></script>\n" +
            "    <link rel=\"stylesheet\" href=\"player.css\" >\n" +
            "</head>\n" +
            "<body>\n" +
            "        <div class=\"mediatec-cleanaudioplayer\">\n" +
            "            <ul data-theme=\"default\" data-autoplay=\"true\">"
        
        let mediaItems = MPMediaQuery.songs().items
        let mediaCollection = MPMediaItemCollection(items: mediaItems!)
        let items : MPMediaItem!
        for items in mediaCollection.items
        {
            songTitle = items.title!
            songArtist = items.artist!
            songAlbum = items.albumTitle!
            songPath2 = String (describing: items.accessibilityPath)
            songPath = (items.assetURL?.absoluteString)!
            
            print(songPath2)
            theIndexString += "<li data-title=\"" + songTitle + "\" data-artist=\"" + songArtist + " (" + songAlbum + ")\" data-type=\"mp3\" data-url=\"" + songPath + "\" data-free=\"false\"></li>"
        }
       
        theIndexString += "</ul>\n" +
            "   </div>\n" +
            "</body>\n" +
        "</html>"
        do {
            //get content of different path
            contentFile1 = (try? (String(contentsOfFile: jqueryFile1Path, encoding: String.Encoding.utf8).description))!
            contentFile2 = (try? (String(contentsOfFile: jqueryFile2Path, encoding: String.Encoding.utf8).description))!
            contentFile3 = (try? (String(contentsOfFile: playerCssPath, encoding: String.Encoding.utf8).description))!

        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        //Listining CSS
        webServer.addGETHandler(forPath: "/jquery-1.11.3.min.js",
                                staticData: (contentFile1.data(using: String.Encoding.utf8))!,
                                contentType: "application/javascript",
                                cacheAge: 3600)
        webServer.addGETHandler(forPath: "/jquery.cleanaudioplayer.js",
                                staticData: (contentFile2.data(using: String.Encoding.utf8))!,
                                contentType: "application/javascript",
                                cacheAge: 3600)
        webServer.addGETHandler(forPath: "/player.css",
                                staticData: (contentFile3.data(using: String.Encoding.utf8))!,
                                contentType: "text/css",
                                cacheAge: 3600)
        webServer.addGETHandler(forPath: "/ipod-library://item/item.mp3",
                                staticData: (contentFile3.data(using: String.Encoding.utf8))!,
                                contentType: "audio/mpeg",
                                cacheAge: 3600)
        
        
        
        
        //Default handler
        webServer.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self, processBlock: {request in
            return GCDWebServerDataResponse(data:(self.theIndexString.data(using: String.Encoding.utf8))!, contentType: "text/html")})
        
        
        
        //start Server
        webServer.start(withPort: 8080, bonjourName: "HelloWord")
        
        print("Visit \(webServer.serverURL) in your web browser")
        
    }
    
    func stopServ()
    {
        webServer.removeAllHandlers();
        webServer.stop();
    }
    
    
    

    
    

}
