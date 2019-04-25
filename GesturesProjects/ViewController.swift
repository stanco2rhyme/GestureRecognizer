//
//  ViewController.swift
//  GesturesProjects
//
//  Created by Stanley Ejechi on 4/24/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var rotateLabel: UILabel!
    @IBOutlet weak var tutorialLabel: UILabel!
    
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    private var player:  AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       /*
         UITapGestureRecognizer
         UISwipeGestureRecognizer
         UIRotateGestureRecognizer
         UIPanGestureRecognizer
         UIPinchGestureRecognizer
         UILongPressGestureRecognizer
         UIScreenEdgePanGestureRecognizer
        */
        
        //get audio
        guard let chachingUrl = Bundle.main.url(forResource: "Cha-ching-sound", withExtension: "mp3") else {return}
        player = AVPlayer(url: chachingUrl)
        
        
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender:)))
        let tapOtherGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender:)))
        tapGesture.numberOfTapsRequired = 2
        tapOtherGesture.numberOfTapsRequired = 2
        tutorialLabel.addGestureRecognizer(tapGesture)
        changeLabel.addGestureRecognizer(tapOtherGesture)
    
        // Rotate label
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateLabelAction(sender:)))
        rotateLabel.addGestureRecognizer(rotateGesture)
        
        // Swipe Gesture
        let directionArray: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        
        for direction in directionArray {
            swipeLabel.addGestureRecognizer(getSwipeGesture(direction: direction))
        }
//        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(labelSwiped(sender:)))
//        swipeGestureLeft.direction = UISwipeGestureRecognizer.Direction.left
//        swipeLabel.addGestureRecognizer(swipeGestureLeft)
    }
    
    // Swipe gesture
    private func getSwipeGesture(direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(labelSwiped(sender:)))
        swipeGesture.direction = direction
        return swipeGesture
    }
    
    // rotate gesture
    @objc func rotateLabelAction(sender: UIRotationGestureRecognizer) {
        rotateLabel.transform = rotateLabel.transform.rotated(by: sender.rotation / 10)
        print("Rotate Label")
    }
    
    
//Tap gesture
    @objc func labelTapped(sender:UITapGestureRecognizer) {

        if sender.view === changeLabel {
            tutorialLabel.text = "Other label changed me"
        } else if sender.view === tutorialLabel {
            tutorialLabel.text = "Stop you pushed me."
        }
        player?.seek(to: .zero)
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        }
        catch {
            // report for an error
            print(error)
        }
        player?.play()
    }
    
    //swipe gesture
    @objc func labelSwiped(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            swipeLabel.frame.origin.x = 0
            break
        case .right:
            swipeLabel.frame.origin.x = UIScreen.main.bounds.width - swipeLabel.frame.width
            break
        case .up:
            swipeLabel.frame.origin.y = view.safeAreaInsets.top
            break
        case .down:
            swipeLabel.frame.origin.y = UIScreen.main.bounds.height - swipeLabel.frame.height
            break
        default:
            break
        }
    }
}

