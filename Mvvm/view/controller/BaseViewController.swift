//
//  BaseViewController.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showMessage(title: String,message: String?){
        if let message = message{
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func showDialogAlert(title: String,message:String,completion: @escaping (() -> ()) ){
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            completion()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(refreshAlert, animated: true, completion: nil)
    }
}
