//
//  StoreViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation

class StoreViewModel {
    
    private var service: StoreService?
    
    private var error : Error?{
        didSet{
            self.didError?(error)
        }
    }
    private var stores : [Store]?{
        didSet{
            self.didFinishFetch?(stores)
        }
    }
    
    var didFinishFetch: (([Store]?) -> ())?
    var didError      : ((Error?) -> ())?
    
    init(service: StoreService) {
        self.service = service
    }
    
    func fetchStores(){
        service?.fetchStoreList(completion: {
            stores,error in
            if let stores = stores{
                self.stores = stores.data
            }
            if let error = error{
                self.error = error
            }
        })
    }
}
