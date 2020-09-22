//
//  ProfileViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/21/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
class DashboardViewModel: BaseViewModel {
     
    var service : ProfileService?
    
    var profile : Profile?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
    var materialRaws: [MaterialRaw]?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
     init(service: ProfileService)  {
        self.service = service
    }
    
    
    func fetchRawMaterial(storeId: String){
        service?.fetchMaterialRaws(storeId: storeId, completion: {
            materialRawResponse, error in
            
            if let materialRawResponse = materialRawResponse{
                self.materialRaws = materialRawResponse.data
            }
            if let error = error{
                self.error = error
            }
        })
    }
    
    func fetchProfile(){
        service?.fetchProfile(completion: {
            (profile,error) in
            if let profile = profile{
                self.profile = profile.data
            }
            if let error = error{
                self.error = error
            }
        })
    }
}
