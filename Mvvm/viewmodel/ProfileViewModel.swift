//
//  ProfileViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/23/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
class ProfileViewModel: BaseViewModel {
   
    var service : DashBoardService?
    
    
    init(service: DashBoardService) {
        self.service = service
    }
    
    var profile : Profile?{
        didSet{
            self.didFinishFetch?()
        }
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
