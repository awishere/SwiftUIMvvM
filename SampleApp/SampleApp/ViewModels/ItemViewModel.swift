//
//  ItemViewModel.swift
//  SampleApp
//
//  Created by Muhammad Anas on 18/12/2022.
//

import Foundation

struct ItemViewModel {
    
    let model: Item
    
    var id: Int{
        model.id
    }
    
    var login: String {
        model.login
    }
    
    var imgUrl: URL? {
        URL(string: model.avatarURL)
    }
    
    var type: String{
        model.type
    }
}
