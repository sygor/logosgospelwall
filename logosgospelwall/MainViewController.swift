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

open class MainViewController : UIViewController {
    
    @IBOutlet weak var video0: UIButton!
    @IBOutlet weak var video1: UIButton!
    
    var backgroundImageViewPreload: [UIImageView]!
    var backgroundImageView: UIImageView!
    var activeButton: UIButton?
    
    @IBAction func ButtonPressed(_ buttonPressed: UIButton) {
        if (activeButton == buttonPressed) {
            // Play Video
            self.performSegue(withIdentifier: "playVideoSegue", sender: activeButton)
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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageViewPreload = createBackgroundImageViewArray()
        
        activeButton = video0
        setBackground(0)
    }
    
    open override func viewWillLayoutSubviews() {
        
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! AVPlayerViewController
        let buttonPressed = sender as! UIButton
        
        // Set the URL of the video and play
        if let url = retrieveVideoURL(buttonPressed) {
            destination.player = AVPlayer(url: url)
            destination.player?.play()
        } else {
            print("Error retrieving video file")
        }
    }
    
    // Retrieve the Video that the player is about to play
    fileprivate func retrieveVideoURL(_ buttonPressed: UIButton) -> URL? {
        
        switch buttonPressed {
        case video0:
            if let url = Bundle.main.url(forResource: "Lego", withExtension: "mp4") {
                return url
            }
        case video1:
            if let url = Bundle.main.url(forResource: "Rabbit", withExtension: "mp4") {
                return url
            }
        default:
            return nil
        }
        return nil
    }
    
    fileprivate func setBackground(_ backgroundIndex: Int) {
        
        // Remove existing background
        if (backgroundImageView != nil) {
            backgroundImageView.removeFromSuperview()
        }
        
        // Fetch preloaded background and switch
        backgroundImageView = backgroundImageViewPreload[backgroundIndex]
        self.view.insertSubview(backgroundImageView, at: 0)
        
    }

    // Create background image view
    fileprivate func createBackgroundImageView(_ backgroundIndex: Int) -> UIImageView {
        let image = UIImage(imageLiteralResourceName: "background" + String(backgroundIndex) + ".jpg")
        let imageView = UIImageView(frame:self.view.frame)
        imageView.image = image
        
        return imageView
    }
    
    // Create a list of background and store in memory
    fileprivate func createBackgroundImageViewArray() -> [UIImageView]{
        var backgroundImageViewArray: [UIImageView] = []
        for i in 0...2 {
            backgroundImageViewArray.append(createBackgroundImageView(i))
        }
        
        return backgroundImageViewArray
    }

}
