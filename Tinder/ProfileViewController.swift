//
//  ProfileViewController.swift
//  Tinder
//
//  Created by David Tan on 4/15/18.
//  Copyright © 2018 DavidTan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var photo: UIImage? // passed in photo image view
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func onDone(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cardsViewController = storyBoard.instantiateViewController(withIdentifier: "CardsViewSegue") as! CardsViewController
        self.present(cardsViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.image = photo
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

}
