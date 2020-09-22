//
//  ProfileVC.swift
//  Mvvm
//
//  Created by laluheri on 9/21/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var profileContainer: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    //inject viewmodel
    let viewModel = DashboardViewModel(service: ProfileService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.fetchProfile()
        
    }
    
    func fetchProfile(){
        viewModel.fetchProfile()
        
        viewModel.didFinishFetch = {
            self.name.text   = self.viewModel.profile?.name
            self.email.text  = self.viewModel.profile?.email
        }
        
        viewModel.didError = {
            error in
            self.showMessage(title: "fail", message: error?.localizedDescription)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        self.showDialogAlert(title: "Logout", message: "Are you sure want to logout", completion: {
            
            //remove login state
            UserDefaults.standard.removeObject(forKey: Constant.IS_LOGGED_IN)
            UserDefaults.standard.removeObject(forKey: Constant.API_TOKEN)
            
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! ViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
            //remove prevous controller
            self.navigationController?.viewControllers.remove(at: 0)
        })
    }
    
    func setUpView(){

         roundedView.layer.cornerRadius = roundedView.frame.size.width/2
         roundedView.clipsToBounds = true

         roundedView.layer.borderColor = UIColor.white.cgColor
         roundedView.layer.borderWidth = 0.0
         //profile container
         profileContainer.layer.cornerRadius = 5.0
        // profileContainer.addShadow(color: UIColor.black, offSet: CGSize(width: -1, height: 1))
    }
    
 

}
