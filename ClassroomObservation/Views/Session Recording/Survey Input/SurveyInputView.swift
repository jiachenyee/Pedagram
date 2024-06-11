//
//  SurveyInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI

struct SurveyInputView: View {
    
    var recordingFrequency: Double
    
    @State private var observation = Observation()
    @State private var selectedQuestion = Question.studentsWorkingWithTechnology
    @State private var record = ObservationRecord.numeric(0)
    
    var completion: ((Observation) -> Void)
    
    @State var isStaticText = true
    
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
                            if observation[keyPath: question.path] != nil {
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
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            SurveyQuestionView(recordingFrequency: recordingFrequency,
                               observation: observation,
                               selectedQuestion: $selectedQuestion,
                               record: $record) {
                completion(observation)
            } save: {
                save()
            } reset: {
                reset()
            }
        }
    }
    
    func save() {
        observation[keyPath: selectedQuestion.path] = self.record
    }
    
    func reset() {
        guard let nextValue = observation[keyPath: selectedQuestion.path] else {
            record = .numeric(0)
            return
        }
        
        record = nextValue
    }
}
