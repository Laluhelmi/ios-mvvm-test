//
//  ViewController.swift
//  Mvvm
//
//  Created by Lalu Hilmi on 9/17/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: BaseViewController{

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
//    var viewModel = DataViewModel(service: DataService())
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
        viewModel.login(username: self.username.text!, password: self.password.text!)
        viewModel.didFinishFetch = {
            accesToken in
            self.loadingIndicator.isHidden = true
            
            //save acces token
            UserDefaults.standard.set(accesToken, forKey: Constant.API_TOKEN)
            //set login state
            UserDefaults.standard.set(true, forKey: Constant.IS_LOGGED_IN)
            
            //push to dashboard
            let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboardTabVC") as! DashboardTabVC
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        viewModel.didError = {
            error in
            self.loadingIndicator.isHidden = true
            self.showMessage(title: "Error", message: error!.localizedDescription)
        }
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
        
        username.addTarget(self, action: #selector(ViewController.textFieldChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(ViewController.textFieldChange(_:)), for: .editingChanged)
        
//        self.username.dropShadow(color: UIColor.blue, offSet: CGSize(width: 1, height: 1))    
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        if username.text != "" && password.text != ""{
            loginButton.isEnabled = true
            loginButton.alpha     = 1.0
        }
        else {
            loginButton.isEnabled = false
            loginButton.alpha     = 0.3
        }
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

