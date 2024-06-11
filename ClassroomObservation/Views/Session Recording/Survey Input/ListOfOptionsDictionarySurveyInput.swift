//
//  ListOfOptionsDictionarySurveyInput.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct ListOfOptionsDictionarySurveyInput: View {
    
    var sections: [String]
    @Binding var record: ObservationRecord
    @State private var otherValue = ""
    
    static let options = [
        "Assessment",
        "Content presentation – Data collection",
        "Digital product creation",
        "Discussion",
        "Non-instructional"
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(sections, id: \.self) { section in
                    if !section.isEmpty {
                        let value = (record.dictValue ?? [:])[section] ?? []
                        
                        Text(section)
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //                            let bindingValue = Binding(get: {
//                                if !options.contains(targetValue ?? "Assessment") {
//                                    return "Others"
//                                } else {
//                                    return targetValue ?? "Assessment"
//                                }
//                            }, set: { newValue in
//                                var dictValue = record.dictValue ?? [:]
//                                dictValue[value] = newValue
//                                
//                                record = .dict(dictValue)
//                            })
                            
//                            Picker("", selection: bindingValue) {
//                                ForEach(options, id: \.self) { option in
//                                    Text(option)
//                                        .tag(option)
//                                }
//                            }
                        ForEach(Self.options, id: \.self) { option in
                            let isSelected = Binding {
                                value.contains(option)
                            } set: { newValue in
                                var mutableDict = (record.dictValue ?? [:])
                                
                                if mutableDict[section] == nil {
                                    mutableDict[section] = []
                                }
                                
                                if newValue {
                                    mutableDict[section]!.append(option)
                                } else {
                                    mutableDict[section]!.removeAll {
                                        $0 == option
                                    }
                                }
                                
                                record = .dict(mutableDict)
                            }
                            
                            
                            CheckboxRowView(isSelected: isSelected,
                                            option: ChecklistOption(title: option))
                        }
                        
                        OtherCheckboxRowView(otherValue: Binding(get: {
                            value.filter({
                                !Self.options.contains($0)
                            }).first ?? ""
                        }, set: { newValue in
                            var mutableDict = (record.dictValue ?? [:])
                            
                            if mutableDict[section] == nil {
                                mutableDict[section] = []
                            }
                            
                            mutableDict[section] = mutableDict[section]!.filter {
                                Self.options.contains($0)
                            }
                            
                            if !newValue.isEmpty {
                                mutableDict[section]!.append(newValue)
                            }
                            
                            record = .dict(mutableDict)
                        }))
                        
                        Divider()
                            .padding(.vertical)
                    }
                }
            }
        }
    }
}

struct CheckboxRowView: View {
    
    @Binding var isSelected: Bool
    var option: ChecklistOption
    
    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .contentTransition(.symbolEffect(.replace))
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
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
        .buttonStyle(.bordered)
    }
}

struct OtherCheckboxRowView: View {
    
    @Binding var otherValue: String
    
    var body: some View {
            HStack {
                Image(systemName: !otherValue.isEmpty ? "checkmark.square.fill" : "square")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundStyle(Color.accentColor)
                VStack(alignment: .leading) {
                    TextField("Other", text: $otherValue)
                }
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(uiColor: .label))
                Spacer()
            }
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thickMaterial)
            .clipShape(.rect(cornerRadius: 8))
    }
}
