//
//  MainViewController.swift
//  logosgospelwall
//
//  Created by Sam Cheung on 8/26/16.
//  Copyright © 2016 Logos. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

public class MainViewController : UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! AVPlayerViewController
        if let url = NSBundle.mainBundle().URLForResource("Lego", withExtension: "mp4") {
            destination.player = AVPlayer(URL: url)
        }else  {
            print("No URL")
        }
    }
}