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
    var futurPath : String!
    var bobcontent : String = ""
    
    
    enum ExportError: Error {
        case unableToCreateExporter
    }
    
    
    func export(assetURL: URL, completionHandler: @escaping (URL?, Error?) -> ()) {
        let asset = AVURLAsset(url: assetURL)
        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
            completionHandler(nil, ExportError.unableToCreateExporter)
            return
        }
        
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString).appendingPathExtension("m4a")
        
        
        exporter.outputURL = fileURL
        self.futurPath = fileURL.absoluteString
        exporter.outputFileType = AVFileType.m4a
        
        exporter.exportAsynchronously
        {
            if exporter.status == .completed {
                completionHandler(fileURL as URL, nil)
            } else {
                completionHandler(nil, exporter.error)
            }
        }
    }
    
        
        
    func runServer() -> String{
       
        //Media Item
        
        //Test song
        var songTitle : String = "chi"
        var songArtist : String = "chichi"
        var songAlbum : String = "chirdon"
        var songPath : String! = ""
        var url : URL?
        var path : URL!
        var data: [String: Data] = ["":Data.init()]
        
        
        //Get the differents path
        let jqueryFile1Path : String = (mainBundle.path(forResource: "jquery-1.11.3.min", ofType: "js")?.description)!
        let jqueryFile2Path : String = (mainBundle.path(forResource: "jquery.cleanaudioplayer", ofType: "js")?.description)!
        let playerCssPath : String = (mainBundle.path(forResource: "player", ofType: "css")?.description)!
        let bobpath : String = (mainBundle.path(forResource: "bob", ofType: "mp3")?.description)!
        print(bobpath)

    
    
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
        
        
       // let mediaItems = MPMediaQuery.songs().items
       // let mediaCollection = MPMediaItemCollection(items: mediaItems!)
       // let items : MPMediaItem!
       /* for items in mediaCollection.items
        {
            songTitle = items.title!
            songArtist = items.artist!
            songAlbum = items.albumTitle!
    
    
           /* if let assetURL = items.assetURL {
                export(assetURL: assetURL) { fileURL, error in
                    guard let fileURL = fileURL, error == nil else {
                        print("export failed: \(error)")
                        return
                    }
                   
                    // use fileURL of temporary file here
                    path = fileURL
                    songPath  = fileURL.absoluteString
                    print("\(self.futurPath!)  data : \(data) load")
                    do
                    {
                     data = try Data.init(contentsOf: URL.init(string: songPath!)!)
                    }
                        
                    catch let error as NSError {
                        print("Ooops! Something went wrong: \(error)")
                    }
                    
                  
                }
            }*/
            
           
            /*webServer.addHandler(forMethod: "GET", path: "/"+self.futurPath, request: GCDWebServerRequest.self, processBlock: {request in
                return GCDWebServerDataResponse(data:data, contentType: "audio/m4a")})*/
            
  print(self.futurPath)
           /* webServer.addHandler(forMethod: "GET", path: "/"+self.futurPath, request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
                
                let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:data, contentType: "audio/m4a")
                completionBlock(response)
            })*/
            

        


            
            

            
           
        }*/



        do {
            //get content of different path
            contentFile1 = (try? (String(contentsOfFile: jqueryFile1Path, encoding: String.Encoding.utf8).description))!
            contentFile2 = (try? (String(contentsOfFile: jqueryFile2Path, encoding: String.Encoding.utf8).description))!
            contentFile3 = (try? (String(contentsOfFile: playerCssPath, encoding: String.Encoding.utf8).description))!
            //data = try Data.init(contentsOf: URL.init(fileURLWithPath: bobpath))
            //print(data)


        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        
        let mediaItems = MPMediaQuery.songs().items
        let mediaCollection = MPMediaItemCollection(items: mediaItems!)
        let items : MPMediaItem!
        var i : Int = 0
        for items in mediaCollection.items
        {
            songTitle = items.title!
            songArtist = items.artist!
            songAlbum = items.albumTitle!

            if let assetURL = items.assetURL {
                export(assetURL: assetURL) { fileURL, error in
                    guard let fileURL = fileURL, error == nil else {
                        print("export failed: \(error)")
                        return
                    }
                    
                    // use fileURL of temporary file here
                    songPath  = fileURL.absoluteString
                    print("Le path du song : \(songPath!)")
                   

                    do
                    {
                        data ["/\(songAlbum)-song-\(i)"] = try Data.init(contentsOf: URL.init(string: songPath!)!)
                    }
                        
                    catch let error as NSError {
                        print("Ooops! Something went wrong: \(error)")
                    }
                    
                    
                }
            }

                webServer.addHandler(forMethod: "GET", path: "/\(songAlbum)-song-\(i)", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
                    
                    print("THE REQUEST IS !!!0 \(request.path)")
                    
                   
                    
                    let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:data[request.path]!, contentType: "audio/mp3")
                    completionBlock(response)
                })
                        theIndexString += "<li data-title=\"" + songTitle + "\" data-artist=\"" + songArtist + " (" + songAlbum + ")\" data-type=\"mp3\" data-url=\""+"\(songAlbum)-song-\(i)"+"\" data-free=\"false\"></li>"

            i=i+1
}
       


        theIndexString += "</ul>\n" +
            "   </div>\n" +
            "</body>\n" +
        "</html>"
        /*webServer.addGETHandler(forPath: "/bob",
                                staticData: data,
                                contentType: "audio/mp3",
                                cacheAge: 3600)*/
        
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
        
      /*  webServer.addHandler(forMethod: "GET", path: "/jquery-1.11.3.min.js", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
            let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:(self.contentFile1.data(using: String.Encoding.utf8))!, contentType: "application/javascript")
            completionBlock(response)
        })
        
        webServer.addHandler(forMethod: "GET", path: "/jquery.cleanaudioplayer.js", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
            let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:(self.contentFile2.data(using: String.Encoding.utf8))!, contentType: "application/javascript")
            completionBlock(response)
        })
        
        webServer.addHandler(forMethod: "GET", path: "/player.css", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
            let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:(self.contentFile3.data(using: String.Encoding.utf8))!, contentType: "text/css")
            completionBlock(response)
        })
        */
        
       //Default handler

        

        /*webServer.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock ) in
            let response : GCDWebServerDataResponse = GCDWebServerDataResponse(data:(self.theIndexString.data(using: String.Encoding.utf8))!, contentType: "text/html")
            completionBlock(response)
        })*/
        

        
        webServer.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self, processBlock: {request in
            return GCDWebServerDataResponse(data:(self.theIndexString.data(using: String.Encoding.utf8))!, contentType: "text/html")})
        
        //start Server
        webServer.start(withPort: 8080, bonjourName: "HelloWord")
        
        print("Visit \(webServer.serverURL) in your web browser")
        
        return "ok"
    }
    
    func stopServ()
    {
        webServer.removeAllHandlers();
        webServer.stop();
    }
    
    
    /*func save(mediaItem: MPMediaItem) -> String?
    {
        let url = mediaItem.assetURL!

        exporter.outputFileType = AVFileType.mp3
        var fileUrl = Bundle.main.url(forResource: url.absoluteString, withExtension: ".mp3")
     
        exporter.outputURL = fileUrl
     
        return String (describing: fileUrl)
        
    }*/
    
    
    }
    
    

    
    
    

    
    


