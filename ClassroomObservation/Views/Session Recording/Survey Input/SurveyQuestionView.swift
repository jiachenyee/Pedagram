//
//  SurveyQuestionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import SwiftUI

struct SurveyQuestionView: View {
    
    var recordingFrequency: Double
    var observation: Observation
    
    @Binding var selectedQuestion: Question
    @Binding var record: ObservationRecord
    
    var completion: (() -> Void)
    var save: (() -> Void)
    var reset: (() -> Void)
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isDismissReportAlertPresented = false
    
    @State private var isPopoverPresented = false
    
    var body: some View {
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
            
            VStack {
                switch selectedQuestion.inputType {
                case .numeric:
                    SurveyNumericInputView(record: $record)
                case .openEndedList:
                    OpenEndedList(shouldDisplayTechnologiesAutocomplete: selectedQuestion.supportsAutocomplete,
                                  record: $record, next: next, previous: previous)
                case .options(let array):
                    ChecklistPickerView(record: $record, options: array)
                case .scale:
                    StandaloneScaleInputView(record: $record)
                case .dict(let path):
                    let value = observation[keyPath: path]?.stringArrayValue ?? []
                    ListOfOptionsDictionarySurveyInput(sections: value,
                                                     record: $record)
                case .text:
                    TextSurveyInputView(record: $record)
                }
            }
            .padding(.horizontal)
            
            if !selectedQuestion.supportsAutocomplete {
                HStack {
                    if selectedQuestion != Question.allCases.first {
                        Button {
                            previous()
                        } label: {
                            Text("Previous")
                                .padding(8)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Button {
                        next()
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
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    isDismissReportAlertPresented = true
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItemGroup(placement: .navigation) {
                Button {
                    isPopoverPresented.toggle()
                } label: {
                    Text(observation.time.addingTimeInterval(recordingFrequency * 60), style: .timer)
                        .monospacedDigit()
                }
                .buttonStyle(.bordered)
                .popover(isPresented: $isPopoverPresented) {
                    Text("Time remaining before the next observation should be taken.")
                        .monospacedDigit()
                        .padding()
                        .onTapGesture {
                            isPopoverPresented.toggle()
                        }
                }
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
                completion()
                dismiss()
            } label: {
                Text("Complete and Close")
            }
            
            Button(role: .cancel) {
            } label: {
                Text("Cancel")
            }
        }
    }
    
    func next() {
        save()
        
        if Question.allCases.last == selectedQuestion {
            completion()
            dismiss()
        }
        
        withAnimation {
            if let nextQuestion = Question(rawValue: selectedQuestion.rawValue + 1) {
                selectedQuestion = nextQuestion
                reset()
            }
        }
    }
    
    func previous() {
        save()
        withAnimation {
            if let nextQuestion = Question(rawValue: selectedQuestion.rawValue - 1) {
                selectedQuestion = nextQuestion
                reset()
            }
        }
        
        if Question.allCases.last == selectedQuestion {
            completion()
            dismiss()
        }
    }
}
