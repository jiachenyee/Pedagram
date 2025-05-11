//
//  ReportPhotosView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI

struct ReportPhotosView: View {
    
    var session: Session
    
    var body: some View {
        if let images = session.images,
           !images.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                Text("Images")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(images.count)")
                    .monospacedDigit()
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TabView {
                    ForEach(images) { image in
                        VStack {
                            let time = image.date.formatted(date: .omitted, time: .shortened)
                            
                            LocalFileImageLoader(name: image.imageName)
                            
                            Divider()
                                .padding(.vertical)
                            
                            HStack(alignment: .top) {
                                Text(time)
                                    .foregroundStyle(.secondary)
                                    .monospacedDigit()
                                
                                Text(image.caption.isEmpty ? String(localized: "No Caption") : image.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 400)
            }
            .padding()
            .background(Material.ultraThick)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}
