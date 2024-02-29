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
    
    @Binding var options: [OpenEndedListOption]
    
    @FocusState var isFirstElementFocused
    
    @State private var focusedFieldId: UUID? = nil
    
    var body: some View {
        VStack(alignment: .center) {
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
            .onChange(of: options) { oldValue, newValue in
                let everythingIsNotEmpty = newValue.allSatisfy { !$0.contents.isEmpty }
                if everythingIsNotEmpty {
                    withAnimation {
                        options.append(.init())
                    }
                }
            }
            .onAppear {
                focusedFieldId = options.first?.id
                isFirstElementFocused = true
            }
            
            if shouldDisplayTechnologiesAutocomplete,
               let optionIndex = options.firstIndex(where: { $0.id == focusedFieldId }) {
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
                }
            }
            
            Text("Press Return to go to the next item.")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom)
    }
}

#Preview {
    OpenEndedList(options: .constant([]))
}
