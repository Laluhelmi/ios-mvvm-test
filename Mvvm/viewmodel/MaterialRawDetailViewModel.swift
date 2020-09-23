//
//  MaterialRawDetailViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/23/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation


class MaterialRawDetailViewModel: BaseViewModel {
    
    
    var service : DashBoardService?
    
    var materialRaw : MaterialRaw?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
    init(service: DashBoardService) {
        self.service = service
    }
    
    func showDetail(id: String)  {
        service?.materialRawDetail(id: id, completion: {
            (materialRaw,error) in
            
            if let materialRaw = materialRaw{
                self.materialRaw = materialRaw.data
            }
            if let error = error{
                self.error = error
            }
        })
        
    }
}
