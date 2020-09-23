//
//  DashBoardVCViewController.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class DashBoardVC: BaseViewController {
    

    
    let viewModel = DashboardViewModel(service: DashBoardService())
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPopUp()
        self.setUpView()
    }
    
    func setUpView(){
        searchTF.addTarget(self, action: #selector(DashBoardVC.textFieldChange(_:)), for: .editingChanged)
        self.setUpTableView()
    }
    
    func fetchMaterialRaws(storeId: String){
        self.loadingIndicator.startAnimating()
        viewModel.storeUUID = storeId
        viewModel.fetchRawMaterial()
        viewModel.didFinishFetch = {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.tableView.reloadData()
        }
        viewModel.didError = {
            error in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.showMessage(title: "Error", message: error?.localizedDescription)
        }
        
        viewModel.didFilter = {
            //scroll to position when search is finish
            self.tableView.reloadData()
        }
        viewModel.didSwitch = {
            isFiltered in
            if isFiltered{
                self.viewModel.scrollPosition = self.tableView.contentOffset
            }
            else {
                if let position = self.viewModel.scrollPosition{
                    self.tableView.setContentOffset(position, animated: false)
                }
            }
        }
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        viewModel.searchKey = textField.text
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
        viewModel.tableViewDataSource
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //check if last row visible
        if indexPath.row == viewModel.materialRaws.count - 1 && viewModel.isLoadMoreEnable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading-cell", for: indexPath) as! LoadingCell
            cell.selectionStyle = .none
            cell.loadingIndicator.startAnimating()
            //request for next page
            self.viewModel.fetchRawMaterial()
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "material-raw-cell", for: indexPath) as! MaterialRawCell
            let data = viewModel.isFilterActive == false ? viewModel.materialRaws[indexPath.row] : viewModel.filteredData[indexPath.row]
            cell.sku.text = data.sku
            if let price = data.defaultPrice{
                cell.price.text = String(price)
            }
            
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MaterialRawDetail") as! MaterialRawDetailVC
       
        let materialRaw = viewModel.isFilterActive == false ? self.viewModel.materialRaws[indexPath.row] : viewModel.filteredData[indexPath.row]
        controller.uuId        = materialRaw.uuid
        self.present(controller, animated: true, completion: nil)
        
              
    }
    
}
