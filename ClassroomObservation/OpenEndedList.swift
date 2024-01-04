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
    
    @Binding var options: [OpenEndedListOption]
    
    @FocusState var isFirstElementFocused
    
    @State private var focusedFieldId: UUID? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach($options) { $option in
                if options.first?.id == option.id {
                    TextField("Type an item here.",
                              text: $option.contents)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding(.vertical, 8)
                    .background(.quinary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .focused($isFirstElementFocused)
                    .onSubmit {
                    }
                } else {
                    OpenEndedListTextField(isFocused: Binding {
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
            }
            .onChange(of: options) { newValue in
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
        }
        .padding(.bottom)
    }
}

#Preview {
    OpenEndedList(options: .constant([]))
}
