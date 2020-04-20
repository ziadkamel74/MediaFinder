//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by Ziad on 1/30/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var phoneTextField: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    let databaseManager = DatabaseManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        //get user data
        let user = databaseManager.getUserData()
        
        // present the user data
        nameTextField.text = user?.name
        emailTextField.text = user?.email
        phoneTextField.text = user?.phone
        if let imageData = user?.photo {
            profilePicture.image = UIImage(data: imageData)
        }
        genderTextField.text = user?.gender
        addressTextField.text = user?.address
        
    }
    
    func loggedOut() {
        UserDefaultsManager.shared().isLoggedIn = false
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {  
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        let loginVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.loginVC) as! LoginVC
        loggedOut()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
}
