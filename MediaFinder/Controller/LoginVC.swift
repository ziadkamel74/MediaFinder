//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by Ziad on 1/19/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    let databaseManager = DatabaseManager.shared()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // setting textfields icon
        setTextFieldsIcons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setTextFieldsIcons() {
        // setting textfields icon
        setTextFieldIcon(textField: emailTextField, image: "email")
        setTextFieldIcon(textField: passTextField, image: "password")
    }

    
    private func isEmptyLogData() -> Bool {
        if emailTextField.text?.isEmpty ?? false || passTextField.text?.isEmpty ?? false {
            return true
        }
        return false
    }
    
    @IBAction func createAccBtnPressed(_ sender: UIButton) {
        let signUpVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signUpVC) as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    private func goToMoviesListScreen() {
        self.navigationController?.pushViewController(TabBarVC(), animated: true)
    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        // decode our user data
//        guard let user = LoginVC.getUserData(forKey: UserDefaultsKeys.userLogData) else { return }
        guard let email = emailTextField.text, let password = passTextField.text else { return }
        if databaseManager.validUserLogData(email, password) {
            goToMoviesListScreen()
        } else if isEmptyLogData() {
            showAlert(title: "Can't log in", message: "Enter all text fields above", actionTitle: "Ok")
        } else {
            //making alert if the user enter wrong email or password
            showAlert(title: "Unauthorized user appear", message: "Wrong email or password", actionTitle: "Ok")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
