//
//  ResultView.swift
//  SampleApp
//
//  Created by Muhammad Anas on 17/12/2022.
//

import SwiftUI
struct ResultView: View {
    
    let itemViewModel: ItemViewModel
    
    var body: some View {
        HStack {
            
            AsyncImage(url: itemViewModel.imgUrl) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "camera.fill")
            }
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            
            Text(itemViewModel.login)
                .font(.title3)
                .lineLimit(2)
            
            Spacer()
            
            VStack {
                
                Text(itemViewModel.type)
                    .font(.caption2.weight(.heavy))
            }
            
        }.padding().frame(alignment:.center)
    }
}

struct ResultViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(itemViewModel: ItemViewModel(
            model: Item.example)
        )
            .previewLayout(.fixed(width: 360, height: 80))
    }
}
