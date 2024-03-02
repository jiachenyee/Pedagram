//
//  SurveyInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI

struct SurveyInputView: View {
    
    @State private var entry = Observation()
    @State private var selectedQuestion = Question.studentsWorkingWithTechnology
    
    @State private var value = 0
    
    @State private var selectedValue = ""
    @State private var openEndedOptions: [OpenEndedListOption] = [.init()]
    
    @State var isStaticText = true
    @FocusState var focused
    
    @Environment(\.dismiss) var dismiss
    var completion: ((Observation) -> Void)
    
    @State private var isDismissReportAlertPresented = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(Question.allCases, id: \.title) { question in
                    Button {
                        save()
                        selectedQuestion = question
                        reset()
                    } label: {
                        HStack {
                            Text(question.unformattedTitle)
                                .foregroundStyle(question == selectedQuestion ? .white : .primary)
                            Spacer()
                            if entry[keyPath: question.path] != nil {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(question == selectedQuestion ? .white : Color.accentColor)
                            }
                        }
                    }
                    .padding(8)
                    .background(question == selectedQuestion ? Color.blue : Color.clear)
                    .clipShape(.rect(cornerRadius: 8))
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        } detail: {
            VStack {
                VStack(alignment: .leading) {
                    Text("\(Question.allCases.firstIndex(of: selectedQuestion)! + 1) of \(Question.allCases.count)")
                        .contentTransition(.numericText())
                    
                    Text(try! AttributedString(markdown: selectedQuestion.title)
                        .transformingAttributes(\.link, { transformer in
                            if transformer.value != nil {
                                transformer.replace(with: \.backgroundColor, value: .yellow)
                            }
                        })
                    )
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    if let subtitle = selectedQuestion.subtitle {
                        Text(subtitle)
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        switch selectedQuestion.inputType {
                        case .numeric:
                            TextField("Number",
                                      value: $value,
                                      format: .number)
                            .keyboardType(.numberPad)
                            .focused($focused)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.vertical)
                            .background(.quinary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onAppear {
                                focused = true
                            }
                            
                            HStack {
                                SurveyInputQuickCompletionButton(value: $value, increment: 1)
                                SurveyInputQuickCompletionButton(value: $value, increment: -1)
                            }
                            
                            HStack {
                                SurveyInputQuickCompletionButton(value: $value, increment: 5)
                                SurveyInputQuickCompletionButton(value: $value, increment: -5)
                            }
                            HStack {
                                SurveyInputQuickCompletionButton(value: $value, increment: 10)
                                SurveyInputQuickCompletionButton(value: $value, increment: -10)
                            }
                        case .openEndedList:
                            OpenEndedList(shouldDisplayTechnologiesAutocomplete: selectedQuestion == .technologyUsedByStudent || selectedQuestion == .technologyUsedByTeacher,
                                          options: $openEndedOptions)
                        case .options(let array):
                            ChecklistPickerView(selectedValue: $selectedValue, options: array)
                        case .scale(let range):
                            ScaleInputView(value: Binding(get: {
                                Double(value)
                            }, set: { newValue in
                                value = Int(round(newValue))
                            }))
                        }
                    }
                    .padding()
                }
                
                HStack {
                    if selectedQuestion != Question.allCases.first {
                        Button {
                            save()
                            withAnimation {
                                if let nextQuestion = Question(rawValue: selectedQuestion.rawValue - 1) {
                                    reset()
                                    selectedQuestion = nextQuestion
                                }
                            }
                            
                            if Question.allCases.last == selectedQuestion {
                                completion(entry)
                                dismiss()
                            }
                        } label: {
                            Text("Previous")
                                .padding(8)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Button {
                        save()
                        withAnimation {
                            if let nextQuestion = Question(rawValue: selectedQuestion.rawValue + 1) {
                                reset()
                                selectedQuestion = nextQuestion
                            }
                        }
                        
                        if Question.allCases.last == selectedQuestion {
                            completion(entry)
                            dismiss()
                        }
                    } label: {
                        Text(Question.allCases.last == selectedQuestion ? "Done" : "Next")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top, 8)
                .padding([.bottom, .horizontal])
            }
            .toolbar {
                Button {
                    isDismissReportAlertPresented = true
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .alert("Close Observation Record", isPresented: $isDismissReportAlertPresented) {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Close Without Saving")
                }
                
                Button {
                    save()
                    completion(entry)
                    dismiss()
                } label: {
                    Text("Save and Close")
                }
                
                Button(role: .cancel) {
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
    
    func save() {
        let record: ObservationRecord = {
            switch selectedQuestion.inputType {
            case .numeric:
                return ObservationRecord.numeric(value)
            case .openEndedList:
                return ObservationRecord.openEndedList(openEndedOptions.map({
                    $0.contents
                }))
            case .options:
                return ObservationRecord.options(selectedValue)
            case .scale:
                return ObservationRecord.numeric(value)
            }
        }()
        
        entry[keyPath: selectedQuestion.path] = record
    }
    
    func reset() {
        value = 0
        selectedValue = ""
        openEndedOptions = [.init()]
        
        guard let previousValue = entry[keyPath: selectedQuestion.path] else { return }
        switch previousValue {
        case .numeric(let number):
            value = number
        case .openEndedList(let list):
            openEndedOptions = list.map {
                .init(contents: $0)
            }
        case .options(let option):
            selectedValue = option
        }
    }
}
