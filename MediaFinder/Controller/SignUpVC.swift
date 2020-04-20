//
//  ViewController.swift
//  RegistrationApp
//
//  Created by Ziad on 1/19/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userAddPhotoBtnPressed: UIButton!
    @IBOutlet weak var genderBtnSwitched: UISwitch!
    @IBOutlet weak var pickedLocationLabel: UILabel!
    let databaseManager = DatabaseManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setTextFieldsIcons()
    }
    
    private func setTextFieldsIcons() {
        // setting textfields icons
        setTextFieldIcon(textField: nameTextField, image: "fullname")
        setTextFieldIcon(textField: emailTextField, image: "email")
        setTextFieldIcon(textField: passwordTextField, image: "password")
        setTextFieldIcon(textField: confirmPassTextField, image: "password")
        setTextFieldIcon(textField: phoneNumberTextField, image: "phone")
    }
    
    
    private func checkForGender() -> String {
        if genderBtnSwitched.isOn {
            return Gender.female.rawValue
        } else {
            return Gender.male.rawValue
        }
    }
    
    private func isValidData() -> Bool {
        if let name = nameTextField.text, !name.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let confirmPass = confirmPassTextField.text, !confirmPass.isEmpty, let phone = phoneNumberTextField.text, !phone.isEmpty,  password.isValidPassword, confirmPass.isValidPassword,  emailTextField.text!.isValidEmail, phoneNumberTextField.text!.isValidPhone {
            return true
        }
        showAlert(title: "Can't sign up", message: "Enter all textfields above correctly", actionTitle: "Ok")
        return false
    }
    
    private func passwordsMatch() -> Bool {
        if passwordTextField.text == confirmPassTextField.text {
            return true
        }
        showAlert(title: "Passwords must match", message: "Make sure you entered your password twice correctly", actionTitle: "Ok")
        return false
    }
    
    private func locationPicked() -> Bool {
        if pickedLocationLabel.text?.isEmpty == false {
            return true
        }
        showAlert(title: "Address required", message: "Please pick pick your location", actionTitle: "Ok")
        return false
    }
    
    private func saveUser() {
        //making object for user data
        let user = User(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phone: phoneNumberTextField.text!, photo: userAddPhotoBtnPressed.currentImage?.pngData(), gender: checkForGender(), address: pickedLocationLabel.text)
        databaseManager.createUsersTable()
        databaseManager.insertUser(user)
        
    }
    
    private func goToLogInScreen() {
        let loginVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.loginVC) as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func MapBtnPressed(_ sender: UIButton) {
        let mapVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.mapVC) as! MapVC
        mapVC.delegate = self
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if isValidData() && passwordsMatch() && locationPicked() {
            saveUser()
            databaseManager.createSearchTable()
            databaseManager.insertMedia()
            goToLogInScreen()
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        goToLogInScreen()
    }
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentImagePicker() {
        // setting the picker and present it to the user
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func userAddPhotoBtnPressed(_ sender: UIButton) {
        presentImagePicker()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // setting the image that user choose to the userAddPhotoBtnPressed instead of the original icon
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        userAddPhotoBtnPressed.setImage(image, for: .normal)
        // then dismiss the picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss the picker when user press cancel
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removePhotoBtnPressed(_ sender: UIButton) {
        // retrieve the original button icon
        let defaultImage = UIImageView()
        defaultImage.image = UIImage(named: "userAddPhoto")
        userAddPhotoBtnPressed.setImage(defaultImage.image, for: .normal)
    }
}

extension SignUpVC: sendingMessageDelegate {
    func messageData(Data: String) {
        self.pickedLocationLabel.text = Data
    }
}
