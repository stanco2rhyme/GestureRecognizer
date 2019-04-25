//
//  SecondViewController.swift
//  GesturesProjects
//
//  Created by Stanley Ejechi on 4/24/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var longGesture = UILongPressGestureRecognizer()
    var currentRadius:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func rotateBallScreenEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            // 2
            if currentRadius==360.0 {
                currentRadius=0.0
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                self.currentRadius += 90.0
                self.imageView.transform = CGAffineTransform(rotationAngle: self.currentRadius * .pi / 180.0)
            })
        }
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        let alertC = UIAlertController(title: "Long Press", message: "Long press gesture called when you press on view of 1 second duration.", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert) in
        }
        alertC.addAction(ok)
        self.present(alertC, animated: true, completion: nil)
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            // 1
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            // 2
            let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                                     y:recognizer.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            // 5
            UIView.animate(withDuration: Double(slideFactor * 2),
                           delay: 0,
                           // 6
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {recognizer.view!.center = finalPoint },
                completion: nil)
        }
    }
    
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
}
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
