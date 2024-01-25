//
//  AsyncImageView.swift
//  Recipes
//
//  Created by Mayur Nilwant on 23/01/2024.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    
    @ObservedObject var downLoadManager: AsyncDownloader
    
    private var image : some View
    {
            Group (){
                
                if self.downLoadManager.recipeImage != nil {
                    Image(uiImage: self.downLoadManager.recipeImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight:200.0)
                    
                }else {
                    
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 120.0)
                }
            }
    }
    
    
    
    var body: some View {
        image
            .onDisappear {
                self.downLoadManager.stop()
            }
    
}
}


class AsyncDownloader: ObservableObject {
    
    @Published  var recipeImage: UIImage?
    let imgUrl: String
    var cancellable: AnyCancellable?
    
    init(imgUrl: String) {
        
        self.imgUrl = imgUrl
        if self.imgUrl != "" {
            start()
        }

    }
    
    func start () {
        
        guard let imageUrl = URL(string: self.imgUrl) else {
            
            recipeImage = nil
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map{UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to:\.recipeImage, on : self )
            
        
    }
    
    func stop() {
        
        cancellable?.cancel()
    }
    
    deinit {
        self.stop()
    }
}


