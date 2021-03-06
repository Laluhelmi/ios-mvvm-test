//
//  ViewController.swift
//  Mvvm
//
//  Created by Lalu Hilmi on 9/17/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseViewController{

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    var viewModel = LoginViewModel(service: LoginService())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        self.attempLogin()
    }

    func attempLogin(){
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        viewModel.login(username: self.username.text!, password: self.password.text!)
        viewModel.didFinishFetch = {
            accesToken in
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            self.saveLoginState(accesToken: accesToken)
            //push to dashboard
            let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboardTabVC") as! DashboardTabVC
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        viewModel.didError = {
            error in
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            self.showMessage(title: "Error", message: error!.localizedDescription)
        }
    }
    
    func saveLoginState(accesToken: String?){
        //save acces token
        UserDefaults.standard.set(accesToken, forKey: Constant.API_TOKEN)
        //set login state
        UserDefaults.standard.set(true, forKey: Constant.IS_LOGGED_IN)
    }
    
    func setUpViews(){
        self.setUpTextField()
        self.setUpButton()
        //hide loading indicator
        self.loadingIndicator.isHidden  = true
        self.password.isSecureTextEntry = true
    }
    
    func setUpButton(){
        loginButton.layer.cornerRadius = 10
    }
    
    func setUpTextField(){
        username.delegate = self
        password.delegate = self
        
        username.addTarget(self, action: #selector(LoginViewController.textFieldChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(LoginViewController.textFieldChange(_:)), for: .editingChanged)
        viewModel.onTextFieldType = {
            self.loginButton.isEnabled = self.viewModel.isButtonEnabled
            self.loginButton.alpha     = self.viewModel.buttonAlpa
        }

    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        viewModel.username  = username.text
        viewModel.password  = password.text
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

