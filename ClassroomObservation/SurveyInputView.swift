//
//  SurveyInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI

struct SurveyInputView: View {
    
    @State private var entry = Entry()
    @State private var question = Question.studentsWorkingWithTechnology
    
    @State private var value = 0
    
    @State private var selectedValue = ""
    @State private var openEndedOptions: [OpenEndedListOption] = [.init()]
    
    @State var isStaticText = true
    @FocusState var focused
    
    @Environment(\.dismiss) var dismiss
    var completion: ((Entry) -> Void)
    
    var body: some View {
        HStack {
            ForEach(Question.allCases, id: \.rawValue) { question in
                Button {
                    let record: EntryRecord = {
                        switch question.inputType {
                        case .numeric:
                            return EntryRecord.numeric(value)
                        case .openEndedList:
                            return EntryRecord.openEndedList(openEndedOptions.map({
                                $0.contents
                            }))
                        case .options:
                            return EntryRecord.options(selectedValue)
                        case .scale:
                            return EntryRecord.numeric(value)
                        }
                    }()
                    
                    entry[keyPath: question.path] = record
                    
                    withAnimation {
                        value = 0
                        selectedValue = ""
                        openEndedOptions = [.init()]
                        self.question = question
                    }
                } label: {
                    Group {
                        if question == self.question {
                            Capsule()
                                .fill(Color.blue)
                                .frame(height: 8)
                        } else if entry[keyPath: question.path] == nil {
                            Capsule()
                                .stroke(lineWidth: 2)
                                .frame(height: 8)
                                .padding(1)
                        } else {
                            Capsule()
                                .fill(Color.blue)
                                .frame(height: 8)
                                .opacity(0.5)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .padding(.horizontal)
        
        ScrollView {
            VStack {
                Image(systemName: question.symbol)
                    .frame(height: 96)
                    .font(.system(size: 64))
                    .foregroundStyle(.blue)
                    .padding(.top)
                    .accessibilityHidden(true)
                
                Text(try! AttributedString(markdown: question.title)
                    .transformingAttributes(\.link, { transformer in
                        print(transformer.range)
                        if transformer.value != nil {
                            transformer.replace(with: \.backgroundColor, value: .yellow)
                        }
                    })
                )
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
                
                if let subtitle = question.subtitle {
                    Text(subtitle)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                }
                
                switch question.inputType {
                case .numeric, .scale:
                    TextField("Number",
                              value: $value,
                              format: .number)
                    .keyboardType(.numberPad)
                    .focused($focused)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .padding(.vertical)
                    .background(.quinary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onAppear {
                        focused = true
                    }
                case .openEndedList:
                    OpenEndedList(options: $openEndedOptions)
                case .options(let array):
                    Picker("", selection: $selectedValue) {
                        Text("No Selection")
                            .tag("")
                        
                        ForEach(array, id: \.self) { option in
                            Text(option.capitalized)
                                .tag(option)
                        }
                    }
                }
            }
            .padding()
        }
        
        Button {
            let record: EntryRecord = {
                switch question.inputType {
                case .numeric:
                    return EntryRecord.numeric(value)
                case .openEndedList:
                    return EntryRecord.openEndedList(openEndedOptions.map({
                        $0.contents
                    }))
                case .options:
                    return EntryRecord.options(selectedValue)
                case .scale:
                    return EntryRecord.numeric(value)
                }
            }()
            
            entry[keyPath: question.path] = record
            
            withAnimation {
                if let nextQuestion = Question(rawValue: question.rawValue + 1) {
                    value = 0
                    selectedValue = ""
                    openEndedOptions = [.init()]
                    question = nextQuestion
                }
            }
            
            if Question.allCases.last == question {
                completion(entry)
                dismiss()
            }
        } label: {
            Text(Question.allCases.last == question ? "Done" : "Next")
                .padding(8)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.top, 8)
        .padding([.bottom, .horizontal])
    }
}
