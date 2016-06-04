//
//  ViewController.swift
//  WebBrowser
//
//  Created by Robert on 5/30/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import WebKit
import UIKit
import Font_Awesome_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addSomething()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func addSomething(){
        let labelName = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 500))
        
        labelName.FAIcon = FAType.FAGithub
        
        labelName.setFAIcon(FAType.FAGithub, iconSize: 35)
        
        labelName.setFAText(prefixText: "follow me on ", icon: FAType.FAAngleLeft, postfixText: ". Thanks!", size: 25)
        
        // bigger icon:
        labelName.setFAText(prefixText: "follow me on  ", icon: FAType.FAAngleLeft, postfixText: ". Thanks!", size: 25, iconSize: 30)
        
        labelName.setFAColor(UIColor.redColor())
        self.view.addSubview(labelName)
    }


}

