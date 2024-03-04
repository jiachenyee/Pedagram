//
//  ListOfScaleDictionarySurveyInput.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct ListOfScaleDictionarySurveyInput: View {
    
    var values: [String]
    @Binding var dictionary: [String: Int]
    
    var body: some View {
        VStack {
            ForEach(values, id: \.self) { value in
                if value.isEmpty {
                    EmptyView()
                } else {
                    Text(value)
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    ScaleInputView(value: Binding(get: {
                        Double(dictionary[value] ?? 3)
                    }, set: { newValue in
                        dictionary[value] = Int(round(newValue))
                    }))
                    
                    Divider()
                        .padding(.vertical)
                }
            }
        }
    }
}
