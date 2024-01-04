//
//  OpenEndedListTextField.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 18/12/23.
//

import SwiftUI

struct OpenEndedListTextField: View {
    
    @FocusState var isFieldFocused
    
    @Binding var isFocused: Bool
    @Binding var text: String
    
    var onSubmit: () -> Void
    
    var body: some View {
        TextField("Type another item here.",
                  text: $text)
        .multilineTextAlignment(.center)
        .font(.title3)
        .padding(.vertical, 8)
        .background(.quinary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .focused($isFieldFocused)
        .onSubmit {
            onSubmit()
        }
        .onChange(of: isFocused) { oldValue, newValue in
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                if isFieldFocused != newValue {
                    isFieldFocused = newValue
                }
            }
        }
        .onChange(of: isFieldFocused) { oldValue, newValue in
            if isFocused != newValue {
                isFocused = newValue
            }
        }
    }
}