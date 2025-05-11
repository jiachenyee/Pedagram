//
//  ChecklistPickerView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/3/24.
//

import SwiftUI

struct ChecklistPickerView: View {
    
    @Binding var record: ObservationRecord
    
    var options: [ChecklistOption]
    
    var body: some View {
        let selectedValue = Binding {
            record.stringValue ?? ""
        } set: { newValue in
            record = .string(newValue)
        }
        
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(options) { option in
                    ChecklistRowView(selectedValue: selectedValue, option: option)
                }
            }
        }
    }
}

struct ChecklistRowView: View {
    
    @Binding var selectedValue: String
    var option: ChecklistOption
    
    var body: some View {
        Button {
            selectedValue = option.id
        } label: {
            HStack {
                Image(systemName: selectedValue == option.id ? "checkmark.circle.fill" : "circle")
                    .contentTransition(.symbolEffect(.replace))
                
                VStack(alignment: .leading) {
                    Text(option.title)
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
