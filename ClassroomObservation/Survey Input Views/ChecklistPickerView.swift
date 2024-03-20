//
//  ChecklistPickerView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/3/24.
//

import SwiftUI

struct ChecklistPickerView: View {
    
    @Binding var selectedValue: String
    var options: [ChecklistOption]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(options) { option in
                Button {
                    selectedValue = option.title
                } label: {
                    HStack {
                        Image(systemName: selectedValue == option.title ? "checkmark.circle.fill" : "circle")
                        VStack(alignment: .leading) {
                            Text(option.title.capitalized)
                            if let description = option.description {
                                Text(description)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color(uiColor: .label))
                        Spacer()
                    }
                    .font(.title3)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}
