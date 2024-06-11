//
//  TextSurveyInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct TextSurveyInputView: View {
    
    @Binding var record: ObservationRecord
    
    @FocusState var focused
    
    var body: some View {
        let value = Binding {
            record.stringValue ?? ""
        } set: { newValue in
            record = .string(newValue)
        }
        
        TextEditor(text: value)
            .frame(minHeight: 64)
            .scrollContentBackground(.hidden)
            .focused($focused)
            .multilineTextAlignment(.leading)
            .fontWeight(.medium)
            .padding()
            .background(.quinary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.title3)
    }
}
