//
//  OpenEndedList.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 23/9/23.
//

import SwiftUI

struct OpenEndedListOption: Identifiable, Equatable {
    var id = UUID()
    var contents: String = ""
}

struct OpenEndedList: View {
    
    var shouldDisplayTechnologiesAutocomplete = false
    
    @Binding var record: ObservationRecord
    
    @State private var options: [OpenEndedListOption] = []
    
    @State private var focusedFieldId: UUID? = nil
    @State private var internalChange = false
    
    var next: () -> Void
    var previous: () -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach($options) { $option in
                        OpenEndedListTextField(isFirstItem: options.first?.id == option.id, isFocused: Binding {
                            focusedFieldId == option.id
                        } set: { value in
                            if value {
                                focusedFieldId = option.id
                            } else {
                                focusedFieldId = nil
                            }
                        }, text: $option.contents) {
                            if focusedFieldId != options.last?.id {
                                focusedFieldId = options.last?.id
                            }
                        }
                    }
                    
//                    Text("Press Return to go to the next item.")
//                        .font(.caption)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom)
                }
            }
            
            if shouldDisplayTechnologiesAutocomplete,
               let optionIndex = options.firstIndex(where: { $0.id == focusedFieldId }) {
                HStack(alignment: .top) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(PotentialTechnology.suggestions(for: options[optionIndex].contents)) { value in
                                Button(value.name) {
                                    options[optionIndex].contents = value.name
                                    
                                    if focusedFieldId != options.last?.id {
                                        focusedFieldId = nil
                                        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { _ in
                                            focusedFieldId = options.last?.id
                                        }
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    HStack {
                        Button {
                            previous()
                        } label: {
                            Image(systemName: "arrowtriangle.left.circle.fill")
                                .padding(4)
                        }
                        .foregroundStyle(.secondary)
                        
                        Button {
                            next()
                        } label: {
                            Image(systemName: "arrowtriangle.right.circle.fill")
                                .padding(4)
                        }
                    }
                    .imageScale(.large)
                }
            }
        }
        .onAppear {
            options = (record.stringArrayValue ?? []).compactMap {
                $0.isEmpty ? nil : OpenEndedListOption(contents: $0)
            } + [OpenEndedListOption()]
            focusedFieldId = options.last?.id
        }
        .onChange(of: options) { oldValue, newValue in
            internalChange = true
            record = .openEndedList(newValue.map({
                $0.contents
            }))
            
            let everythingIsNotEmpty = newValue.allSatisfy { !$0.contents.isEmpty }
            if everythingIsNotEmpty {
                withAnimation {
                    options.append(.init())
                }
            } else if newValue.count == 0 {
                focusedFieldId = nil
            }
        }
        .onChange(of: record) { oldValue, newValue in
            guard !internalChange else { return }
            let newOptions = (newValue.stringArrayValue ?? []).compactMap {
                $0.isEmpty ? nil : OpenEndedListOption(contents: $0)
            } + [OpenEndedListOption()]
            
            if options != newOptions {
                options = newOptions
            }
            focusedFieldId = options.last?.id
            internalChange = false
        }
    }
}
