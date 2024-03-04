//
//  TextSurveyInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct TextSurveyInputView: View {
    
    @Binding var text: String
    @FocusState var focused
    
    var body: some View {
        TextEditor(text: $text)
            .frame(minHeight: 64)
            .scrollContentBackground(.hidden)
            .focused($focused)
            .multilineTextAlignment(.leading)
            .fontWeight(.medium)
            .padding()
            .background(.quinary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onAppear {
                focused = true
            }
            .font(.title3)
    }
}
