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
    
    @IBOutlet weak var video1: UIButton!
    @IBOutlet weak var video2: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(2)
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! AVPlayerViewController
        let buttonPressed = sender as! UIButton
        
        destination.player = AVPlayer(URL: retrieveVideoURL(buttonPressed))
        destination.player?.play()
        
    }
    
    private func retrieveVideoURL(buttonPressed: UIButton) -> NSURL {
        
        switch buttonPressed {
        case video1:
            if let url = NSBundle.mainBundle().URLForResource("Lego", withExtension: "mp4") {
                return url
            }
        case video2:
            if let url = NSBundle.mainBundle().URLForResource("Rabbit", withExtension: "mp4") {
                return url
            }
        default:
            return NSURL()
        }
        
        return NSURL()

    }
    
    private func setBackground(backgroundIndex: Int) {
        
        var backgroundImage:UIImage
        
        switch (backgroundIndex) {
        case 0:
            backgroundImage = UIImage(imageLiteral: "background1.jpg")
        case 1:
            backgroundImage = UIImage(imageLiteral: "background2.jpg")
        case 2:
            backgroundImage = UIImage(imageLiteral: "background3.jpg")
        default:
            backgroundImage = UIImage(imageLiteral: "background1.jpg")
        }

        
        let backgroundImageView = UIImageView(frame:self.view.frame)
        backgroundImageView.image = backgroundImage
        
        self.view.insertSubview(backgroundImageView, atIndex: 0)
    }
}