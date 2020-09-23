//
//  MaterialRawDetailVC.swift
//  Mvvm
//
//  Created by laluheri on 9/23/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class MaterialRawDetailVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var sku: UILabel!
    @IBOutlet weak var englishName: UILabel!
    @IBOutlet weak var chineseName: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var packing: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator:
    UIActivityIndicatorView!
    
    var materialRaw : MaterialRaw?
    var uuId        : String?
    
    let viewModel = MaterialRawDetailViewModel(service: DashBoardService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDetail()
    }
    
    
    func getDetail(){
        if let uuid = self.uuId{
            self.loadingIndicator.startAnimating()
            viewModel.showDetail(id: uuid)
            viewModel.didFinishFetch = {
                self.materialRaw = self.viewModel.materialRaw
                self.setUpView()

                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            }
            viewModel.didError = {
                error in
                self.showMessage(title: "Error", message: error?.localizedDescription)
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            }
        }
    }
    
    func setUpView(){
        sku.text = materialRaw?.sku
        englishName.text = materialRaw?.nameEng == nil ? "-" : materialRaw?.nameEng
        chineseName.text = materialRaw?.nameChin == nil ? "-" : materialRaw?.nameChin
        unit.text        = materialRaw?.unit == nil ? "-" : materialRaw?.unit
        price.text       = materialRaw?.defaultPrice == nil ? "-" : materialRaw?.defaultPrice?.doubleToString()
        packing.text     = materialRaw?.packing == nil ? "-" : materialRaw?.packing
        self.setUpTableView()
    }
    
    func setUpTableView(){
        self.tableView.register(UINib(nibName: "StoreCell", bundle: nil), forCellReuseIdentifier: "store-cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materialRaw?.stores == nil ? 0 : materialRaw!.stores!.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store-cell", for: indexPath) as! StoreCell
        cell.storeName.text = self.materialRaw?.stores?[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
      }
    
}
