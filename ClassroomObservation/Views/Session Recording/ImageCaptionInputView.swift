//
//  ImageCaptionInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import SwiftUI

struct ImageCaptionInputView: View {
    
    @Binding var record: ImageRecord
    
    @State private var showConfirmationAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var onDelete: (() -> Void)
    
    var body: some View {
        NavigationStack {
            Form {
                LocalFileImageLoader(name: record.imageName)
                
                TextField("Caption", text: $record.caption)
                
                Section {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                Section {
                    Button("Delete", role: .destructive) {
                        showConfirmationAlert = true
                    }
                }
            }
            .navigationTitle("Photo")
        }
        .alert("Are you sure you want to delete this image?",
               isPresented: $showConfirmationAlert) {
            Button("Delete Image", role: .destructive) {
                onDelete()
                dismiss()
            }
            
            Button("Cancel", role: .cancel) {
            }
        }
    }
}
