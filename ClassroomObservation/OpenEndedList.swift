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
                } else {
                    TextField("Type another item here.",
                              text: $option.contents)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding(.vertical, 8)
                    .background(.quinary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
                isFirstElementFocused = true
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    OpenEndedList(options: .constant([]))
}
