//
//  userViewModel.swift
//  SampleApp
//
//  Created by Muhammad Anas on 17/12/2022.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var results = [Item]()
    @Published var searchText: String = ""
    @Published var page: Int = 1
    @Published var lastIndexId: Int  = 0
    @Published var isLimit = false
    @Published var isLoading = false
    @Published var isError = false
    @Published var firstHit = true
    
    
    
    func loadMoreContent(){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if(!self.isLimit){
                self.page += 1
                self.isError = false
                self.performSearch()
            }
            self.isLoading = false
        }
        
    }
    func performNewSearch(){
        if(!firstHit){
            self.results = []
            self.page = 1
            self.isLimit = false
        }
        self.performSearch()
    }
    
    func performSearch() {
        self.isLoading = true
        
        guard let gUrl = URL(
            string: "https://api.github.com/search/users?q=\(searchText)&per_page=9&page=\(page)"
        ) else {
            self.isLoading = false
            return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: gUrl)
                
                let response = try JSONDecoder()
                    .decode(Users.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.results.append(contentsOf: response.self.items.sorted{$0.login.lowercased() < $1.login.lowercased()})
                    if(response.self.items.count>2){
                        self?.lastIndexId =  response.self.items[response.self.items.count-1].id
                    }
                    self?.firstHit = false
                    self?.isError = false
                }
            } catch {
                if(page == 11){
                    DispatchQueue.main.async{ [weak self] in
                        self?.isLimit = true
                        self?.isLoading = false
                    }
                    return
                }
                DispatchQueue.main.async{ [weak self] in
                    self?.isLoading = false
                    self?.isError = true
                }
                
                print("*** ERROR ***")
            }
            
        }
        
    }
    
}
