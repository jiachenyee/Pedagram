//
//  PhotoCellView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI

struct PhotoCellView: View {
    
    @Binding var session: Session
    var image: ImageRecord
    
    @State private var isImageCaptionSheetPresented = false
    
    var body: some View {
        Button {
            isImageCaptionSheetPresented = true
        } label: {
            LocalFileImageLoader(name: image.imageName)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .clipShape(.rect(cornerRadius: 8))
        }
        .sheet(isPresented: $isImageCaptionSheetPresented) {
            if let imageIndex = session.images?.firstIndex(where: {
                $0.imageName == image.imageName
            }) {
                let recordBinding = Binding {
                    session.images![imageIndex]
                } set: { newValue in
                    session.images?[imageIndex] = newValue
                }

                ImageCaptionInputView(record: recordBinding) {
                    session.images?.remove(at: imageIndex)
                }
            }
        }
    }
}
