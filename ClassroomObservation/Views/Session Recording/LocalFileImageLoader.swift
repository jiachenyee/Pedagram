//
//  LocalFileImageLoader.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 14/5/24.
//

import SwiftUI

struct LocalFileImageLoader: View {
    
    var name: String
    
    @State private var state: LocalFileImageLoaderState = .loading
    
    var body: some View {
        switch state {
        case .loading:
            Rectangle()
                .fill(.gray.opacity(0.3))
                .task {
                    let baseURL = URL.documentsDirectory.appending(path: "images")
                    
                    let url = baseURL.appending(path: name)

                    guard let data = try? Data(contentsOf: url),
                          let image = UIImage(data: data) else {
                        state = .error
                        return
                    }
                    state = .image(image)
                }
        case .error:
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                Image(systemName: "exclamationmark.triangle.fill")
            }
        case .image(let uIImage):
            Image(uiImage: uIImage)
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.rect(cornerRadius: 8))
        }
    }
}

enum LocalFileImageLoaderState {
    case loading
    case error
    case image(UIImage)
}
