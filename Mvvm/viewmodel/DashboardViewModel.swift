//
//  ProfileViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/21/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewModel: BaseViewModel {
     
    var service : DashBoardService?
    
    //properties for pagination
    var lastPage    : Int = 0
    var currentPage : Int = 0
    var storeUUID   : String!
    
    var isLoading : Bool = false
    // tableview last scroll position
    var scrollPosition : CGPoint?
    //switch from original tableview to filter tableview
    var onFilterTVActive : ((Bool) -> ())?
    
    //data found from the search
    var filteredData = [MaterialRaw]()
    var didFilter: (() -> ())?
    //is tableview switched from originial to filtered data
    var isSwitch : Bool = false
    var didSwitch : ((Bool) -> ())?
    var isFilterActive :Bool = false{
        didSet{
            if self.isFilterActive{
                if self.isSwitch == false {
                    self.isSwitch = true
                    self.didSwitch?(true)
                }
            }
            else {
                self.isSwitch = false
                if self.scrollPosition != nil{
                    self.didSwitch?(false)
                }
            }
            self.didFilter?()
        }
    }
    var searchKey : String?{
        didSet{
            if let text = searchKey{
                filteredData = materialRaws.filter {
                    return $0.sku == nil ? false : $0.sku!.contains(text)
                }
                if text == ""{
                    self.onFilterTVActive?(false)
                    isFilterActive = false
                }
                else {
                    self.onFilterTVActive?(true)
                    isFilterActive = true
                }
            }
        }
    }
    
    var materialRaws = [MaterialRaw](){
        didSet{
            self.didFinishFetch?()
        }
    }
    
     init(service: DashBoardService)  {
        self.service = service
    }
    
    
    func fetchRawMaterial(){
        self.isLoading = true
        let nextPage = self.currentPage + 1
        service?.fetchMaterialRaws(storeId: self.storeUUID,page: nextPage, completion: {
            materialRawResponse, error in
            if let materialRawResponse = materialRawResponse{
                //get pagination detail
                if let currentPage = materialRawResponse.meta?.current_page{
                    self.currentPage = currentPage
                }
                if let lastPage  = materialRawResponse.meta?.last_page{
                    self.lastPage = lastPage
                }
                if let data = materialRawResponse.data{
                    //remove last empty item loading if exist
                    if self.materialRaws.count > 0{
                        self.materialRaws.removeLast()
                    }
                    //append material raws array data
                    self.materialRaws.append(contentsOf: data)
                    //append empty data to provide loading view
                    if self.currentPage < self.lastPage{
                        self.materialRaws.append(MaterialRaw())
                    }
                }
            }
            if let error = error{
                self.error = error
            }
            //set loading state
            self.isLoading = false
            
        })
    }
    
}
