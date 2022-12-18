//
//  ContentView.swift
//  SampleApp
//
//  Created by Muhammad Anas on 16/12/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = UserViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Spacer().frame(minHeight:5,idealHeight: 30).fixedSize()
                VStack{
                    Section(header: Text("Search for Users").font(.headline)) {
                        Spacer().frame(minHeight:5,idealHeight: 30).fixedSize()
                        TextField("Enter Text", text: $viewModel.searchText )
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer().frame(minHeight:5,idealHeight: 30).fixedSize()
                    Button(action: {
                        
                        if(!$viewModel.searchText.wrappedValue.isEmpty){
                            viewModel.performNewSearch()
                        }
                    }) {
                        Text("Search")
                    }
                }.frame(width:300,alignment:.center)
                
                List {
                    
                    ForEach(viewModel.self.results,id:\.login) {
                        
                        let viewsModel = ItemViewModel(model: $0)
                        ResultView(itemViewModel:viewsModel).onAppear{
                            if(viewsModel.id ==  viewModel.lastIndexId  ){
                                viewModel.loadMoreContent()
                            }
                            
                        }
                        
                    }
                    if(viewModel.isLimit){
                        HStack{
                            Spacer()
                            Text("Api Call Limit Reached")
                            Spacer()
                        }
                    }
                    if(viewModel.isError){
                        HStack{
                            Spacer()
                            Text("Error Fetching Data")
                            Spacer()
                        }
                    }
                    if viewModel.isLoading &&
                        !viewModel.isLimit{
                        HStack{
                            Spacer()
                            ProgressView().progressViewStyle(CircularProgressViewStyle()).frame( alignment: .center)
                            Spacer()
                        }}
                    
                }
                .listStyle(.insetGrouped)
                
                
            }.navigationBarHidden(true)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
