//
//  CardsViewController.swift
//  Tinder
//
//  Created by David Tan on 4/15/18.
//  Copyright © 2018 DavidTan. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    var cardInitialRotation: CGAffineTransform!
    var rotationSpeed = 1.0
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(didTap(sender:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(panGestureRecognizer)
        
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ProfileViewSegue", sender: self)
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        let image = sender.view as! UIImageView
        let half = 150
        
        if sender.state == .began {
            print("Gesture began")
            cardInitialCenter = image.center
            cardInitialRotation = image.transform
            
            if location.y < CGFloat(half) {
                rotationSpeed = 0.5
            }
            else {
                rotationSpeed = -0.5
            }
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            
            image.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
            if velocity.x < 0 {
                image.transform = image.transform.rotated(by:
                    CGFloat(-rotationSpeed * Double.pi / 180))
            }
            else if velocity.x > 0 {
                image.transform = image.transform.rotated(by:  CGFloat(rotationSpeed * Double.pi / 180))
            }
            else {
                // restore original center and transform
                //image.center = cardInitialCenter
                //image.transform = CGAffineTransform.identity
            }
            
        } else if sender.state == .ended {
            print("Gesture ended")
            
            if translation.x > 50 { // send image off screen to the right
                print("Gesture ended and moved off right")
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                    image.center.x = 5000
                }, completion: nil)
                print(image.center)
            }
            
            else if translation.x < 50 { // send image off screen to the left
                print("Gesture ended and moved off left")
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                    image.center.x = -5000
                }, completion: nil)
                print(image.center)
                /*UIView.animate(withDuration:1, animations: {
                    // This causes first view to fade in and second view to fade out
                    image.center.x = -1000
                })*/
            }
            else {
                print("Gesture ended and restored positions")
                // Restore image position
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                image.center = self.cardInitialCenter
                                image.transform = self.cardInitialRotation
                }, completion: nil)
                print(image.center)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileViewController = segue.destination as! ProfileViewController
        
        // Pass on the data to the Detail ViewController
        profileViewController.photo = profileImage.image
        
        // Set the modal presentation style of your destinationViewController to be custom.
        //profileViewController.modalPresentationStyle = UIModalPresentationStyle.custom
    }
}
