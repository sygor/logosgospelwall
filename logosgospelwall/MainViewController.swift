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
    
    @IBOutlet weak var video0: UIButton!
    @IBOutlet weak var video1: UIButton!
    
    var backgroundImageViewPreload: [UIImageView]!
    var backgroundImageView: UIImageView!
    var activeButton: UIButton?
    
    @IBAction func ButtonPressed(buttonPressed: UIButton) {
        if (activeButton == buttonPressed) {
            // Play Video
            self.performSegueWithIdentifier("playVideoSegue", sender: activeButton)
        } else {
            // Set Background
            activeButton = buttonPressed
            switch buttonPressed {
            case video0:
                setBackground(0)
            case video1:
                setBackground(1)
            default:
                setBackground(2)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageViewPreload = createBackgroundImageViewArray()
        
        activeButton = video0
        setBackground(0)
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! AVPlayerViewController
        let buttonPressed = sender as! UIButton
        
        // Set the URL of the video and play
        destination.player = AVPlayer(URL: retrieveVideoURL(buttonPressed))
        destination.player?.play()
        
    }
    
    // Retrieve the Video that the player is about to play
    private func retrieveVideoURL(buttonPressed: UIButton) -> NSURL {
        
        switch buttonPressed {
        case video0:
            if let url = NSBundle.mainBundle().URLForResource("Lego", withExtension: "mp4") {
                return url
            }
        case video1:
            if let url = NSBundle.mainBundle().URLForResource("Rabbit", withExtension: "mp4") {
                return url
            }
        default:
            return NSURL()
        }
        
        return NSURL()

    }
    
    private func setBackground(backgroundIndex: Int) {
        
        // Remove existing background
        if (backgroundImageView != nil) {
            backgroundImageView.removeFromSuperview()
        }
        
        // Fetch preloaded background and switch
        backgroundImageView = backgroundImageViewPreload[backgroundIndex]
        self.view.insertSubview(backgroundImageView, atIndex: 0)
        
    }

    // Create background image view
    private func createBackgroundImageView(backgroundIndex: Int) -> UIImageView {
        let image = UIImage(imageLiteral: "background" + String(backgroundIndex) + ".jpg")
        let imageView = UIImageView(frame:self.view.frame)
        imageView.image = image
        
        return imageView
    }
    
    // Create a list of background and store in memory
    private func createBackgroundImageViewArray() -> [UIImageView]{
        var backgroundImageViewArray: [UIImageView] = []
        for i in 0...2 {
            backgroundImageViewArray.append(createBackgroundImageView(i))
        }
        
        return backgroundImageViewArray
    }

}