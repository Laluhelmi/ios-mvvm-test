//
//  DashBoardVCViewController.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class DashBoardVC: BaseViewController {
    

    
    let viewModel = DashboardViewModel(service: ProfileService())
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var materialRaws = [MaterialRaw]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPopUp()
        self.setUpTableView()
    }
    
    func fetchMaterialRaws(storeId: String){
        self.loadingIndicator.startAnimating()
        viewModel.fetchRawMaterial(storeId: storeId)
        viewModel.didFinishFetch = {
            if let materialRaws = self.viewModel.materialRaws{
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.materialRaws.append(contentsOf: materialRaws)
                //append empty data to provide loading view
                self.materialRaws.append(MaterialRaw())
                self.tableView.reloadData()
            }
        }
        viewModel.didError = {
            error in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.showMessage(title: "Error", message: error?.localizedDescription)
        }
    }
    
    func setUpTableView(){
        let nib        = UINib(nibName: "MaterialRawCell", bundle: nil)
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: "material-raw-cell")
        self.tableView.register(loadingNib, forCellReuseIdentifier: "loading-cell")
        
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.tableView.rowHeight = UITableView.automaticDimension
     }
     
    
    func showPopUp(){
        let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StoreVC") as! StoreVc
        if #available(iOS 13.0, *) {
            controller.isModalInPresentation = true
        }
        controller.finish = {
            uuid,storeName in
            if let uuid = uuid{
                self.fetchMaterialRaws(storeId: uuid)
            }
            self.tabBarController?.title = storeName
        }
        
        self.present(controller, animated: true, completion: nil)
      
    }

}

extension DashBoardVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.materialRaws.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //check if last row visible
        if indexPath.row == self.materialRaws.count - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading-cell", for: indexPath) as! LoadingCell
            cell.selectionStyle = .none
            cell.loadingIndicator.startAnimating()
              DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.materialRaws.removeLast()
                self.materialRaws.append(contentsOf: self.materialRaws)
                self.tableView.reloadData()
              })
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "material-raw-cell", for: indexPath) as! MaterialRawCell
            cell.selectionStyle = .none
            let data = self.materialRaws[indexPath.row]
            cell.sku.text = data.sku
            if let price = data.defaultPrice{
                cell.price.text = String(price)
            }
            
            return cell
            
        }
    }
    
    
}
