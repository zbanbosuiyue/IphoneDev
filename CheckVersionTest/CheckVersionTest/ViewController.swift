//
//  ViewController.swift
//  CheckVersionTest
//
//  Created by Robert on 6/1/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit
import AudioToolbox  
import Alamofire // Asychrnoize Http
import Kanna  //HttpParser


class ViewController: UIViewController {
    
    /*
     This module named checkVersion() would take three parameters (updateURL, clientVersion, languages) as inputs.
     
     updateURL: Direct to server, get two parameters (updateStatus, errorMessage) to display the warning.
     
     updateStatus: 
        Has three states:
        1. OK
        2. Mandartory Update
        3. Optional Update
     
     

    
 
 
 
 
    */
    
    let currentVersion:Float = 0.9 //
    let currentLanguage = "cn"
    let updateUrl = "https://www.miibox.com/app.php"
    var errorMsg = ""
    var isMandartoryUpdate = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkVersion(updateUrl, version: currentVersion, lang: currentLanguage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkVersion(updateUrl: String, version:Float, lang: String){
        let url = updateUrl + "?version=" + String(version) + "&lang=" + lang
        // Asychronize Request
        Alamofire.request(.GET, url)
            .responseJSON { response in
                //let html = response.result.value
                //
                var updateStatus = ""
                (updateStatus, self.errorMsg)=self.checkJSON(response.data!)
                if updateStatus == "Mandartory Update"{
                    self.isMandartoryUpdate = true
                    self.showError()
                }
                else if updateStatus == "Optional Update"{
                    self.isMandartoryUpdate = false
                    self.showError()
                }else{
                    print ("ok")
                }
        }
        
    }
    
    // AlterBox
    func showError(){
        let alert = UIAlertController(title: errorMsg, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let updateAction = UIAlertAction(title: "Update", style: UIAlertActionStyle.Default, handler: updateHandle)
        var cancelAction = UIAlertAction()
        
        if isMandartoryUpdate{
            cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: cancelHandle)
        } else{
            cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        }
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    
    
    // If data in JSON
    func checkJSON(data: NSData) -> (String, String){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            let updateStatus = json["updateStatus"] as? String
            let errorMsg = json["errorMsg"] as? String
            return (updateStatus!, errorMsg!)
        } catch{
            print("error serializing JSON: \(error)")
        }
        return ("Unknown", "Unknown")
    }
    
    
    // Cancel Handle
    func cancelHandle(alert: UIAlertAction!){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        showError()
    }
    
    
    
    // Update Handle
    func updateHandle(alter: UIAlertAction!){
        UIApplication.sharedApplication().openURL(NSURL(string : updateUrl)!)
    }
    


}

