//
//  ChecklistPickerView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/3/24.
//

import SwiftUI

struct ChecklistPickerView: View {
    
    @Binding var selectedValue: String
    var options: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(options, id: \.self) { option in
                Button {
                    selectedValue = option
                } label: {
                    HStack {
                        Image(systemName: selectedValue == option ? "checkmark.circle.fill" : "circle")
                        Text(option.capitalized)
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
