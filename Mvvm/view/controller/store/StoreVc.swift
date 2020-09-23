//
//  StoreVc.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class StoreVc: BaseViewController ,UITableViewDataSource,UITableViewDelegate{
 
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var finish      : ((String?,String?) -> ())?
    
    
    //inject
    let viewModel = StoreViewModel(service: StoreService())
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.fetchStores()
        
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "StoreCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "store-cell")
        self.tableView.dataSource = self
        self.tableView.delegate   = self
    }
    
    func fetchStores(){
        self.loadingIndicator.startAnimating()
        viewModel.fetchStores()
        viewModel.didFinishFetch = {
            stores in
            if let stores = stores{
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.stores = stores
                self.tableView.reloadData()
            }
        }
        
        viewModel.didError = {
            error in
            self.loadingIndicator.stopAnimating()
                           self.loadingIndicator.isHidden = true
            self.showMessage(title: "Fail", message: error!.localizedDescription)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store-cell", for: indexPath) as! StoreCell
        cell.storeName.text = self.stores[indexPath.row].name
        cell.selectionStyle = .default
        
        return cell

     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uuid = self.stores[indexPath.row].uuid
        let storeName = self.stores[indexPath.row].name
        self.finish?(uuid,storeName)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
         
    }
     
     
     
    

}
