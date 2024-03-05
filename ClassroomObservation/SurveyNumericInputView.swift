//
//  SurveyNumericInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 5/3/24.
//

import SwiftUI

struct SurveyNumericInputView: View {
    
    @Binding var value: Int
    
    @FocusState var focused
    
    var body: some View {
        TextField("Number",
                  value: $value,
                  format: .number)
        .keyboardType(.numberPad)
        .focused($focused)
        .multilineTextAlignment(.center)
        .font(.title)
        .fontWeight(.medium)
        .padding(.vertical)
        .background(.quinary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                focused = true
            }
        }
        
        HStack {
            SurveyInputQuickCompletionButton(value: $value, increment: 1)
            SurveyInputQuickCompletionButton(value: $value, increment: -1)
        }
        
        HStack {
            SurveyInputQuickCompletionButton(value: $value, increment: 5)
            SurveyInputQuickCompletionButton(value: $value, increment: -5)
        }
        HStack {
            SurveyInputQuickCompletionButton(value: $value, increment: 10)
            SurveyInputQuickCompletionButton(value: $value, increment: -10)
        }
    }
}
