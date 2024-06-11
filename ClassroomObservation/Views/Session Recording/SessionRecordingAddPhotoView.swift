//
//  SessionRecordingAddPhotoView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import SwiftUI
import PhotosUI

struct SessionRecordingAddPhotoView: View {
    
    @Binding var session: Session
    
    @State private var isPhotoPickerPresented = false
    @State private var isCameraPresented = false
    
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var image: UIImage?
    
    var body: some View {
        Section {
            Menu {
                Button {
                    isCameraPresented = true
                } label: {
                    Label("Take Photo", systemImage: "camera")
                }
                
                Button {
                    isPhotoPickerPresented = true
                } label: {
                    Label("Choose from Photos", systemImage: "photo.on.rectangle.angled")
                }
            } label: {
                Text("Add Photo")
            }
            
            if !(session.images?.isEmpty ?? true) {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 100))]) {
                    ForEach((session.images ?? [])) { image in
                        PhotoCellView(session: $session, image: image)
                    }
                }
            }
        } header: {
            Text("Photos")
        } footer: {
            Text("Attach images of the classroom into the report.")
                .photosPicker(isPresented: $isPhotoPickerPresented,
                              selection: $photoPickerItem,
                              matching: .images)
                .fullScreenCover(isPresented: $isCameraPresented) {
                    AccessCameraView(selectedImage: $image)
                        .ignoresSafeArea()
                }
        }
        .onChange(of: photoPickerItem) { oldValue, newValue in
            newValue?.loadTransferable(type: Data.self, completionHandler: { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data!)
                    self.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
        .onChange(of: image) { oldValue, newValue in
            if newValue != nil {
                isCameraPresented = false
                
                let imagesDirectory = URL.documentsDirectory.appending(path: "images")
                
                try! FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true)
                
                let imageName = "\(UUID().uuidString).png"
                
                let imageURL = imagesDirectory.appending(path: imageName)
                
                try! newValue?.pngData()?.write(to: imageURL)
                
                let record = ImageRecord(imageName: imageName, caption: "", date: .now)
                
                if session.images == nil {
                    session.images = []
                }
                session.images?.append(record)
            }
        }
    }
}

struct AccessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: AccessCameraView
    
    init(picker: AccessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        self.picker.selectedImage = selectedImage
//        self.picker.dismiss.callAsFunction()
    }
}
