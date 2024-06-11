//
//  ReportIndicatorsOverTime.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 29/4/24.
//

import SwiftUI
import Charts

struct GraphShape: Identifiable {
    var type: String
    var date: Date
    var count: Int
    var id = UUID()
}

struct ReportIndicatorsOverTime: View {
    
    var graphShape: [GraphShape] = []
    
    var session: Session
    
    init(session: Session) {
        self.session = session
        self.graphShape = convertToGraphShape()
        
        print(graphShape)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("How Technology is Being Used")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("Based on the total count of how the technologies are used.")
                .foregroundStyle(.secondary)
            
            Chart(graphShape) { shape in
                LineMark(
                    x: .value("Time", shape.date, unit: .second, calendar: .current),
                    y: .value("Count", shape.count)
                )
                .foregroundStyle(by: .value("Task", shape.type))
            }
            .chartLegend(.visible)
            .frame(height: 200)
        }
    }
    
    func convertToGraphShape() -> [GraphShape] {
        let allOptions = Set(session.observations.flatMap { observation in
            observation.howIsTheTeacherUsingTechnology?.dictValue.flatMap({
                $0.values.flatMap { $0 }
            }) ?? []
        }).sorted()
        
        return session.observations.flatMap { observation in
            var options: [String: Int] = [:]
            
            for option in allOptions {
                options[option] = 0
            }
            
            let date = observation.time
            let types: [String] = observation.howIsTheTeacherUsingTechnology?.dictValue.flatMap({
                $0.values.flatMap { $0 }
            }) ?? []
            
            for (key, value) in createShapeArray(from: types, date: date) {
                options[key] = value
            }
            
            return options.map { GraphShape(type: $0.key, date: date, count: $0.value) }
        }
    }
    
    func createShapeArray(from words: [String], date: Date) -> [String: Int] {
        var wordCount = [String: Int]()
        
        // Count each word's occurrences
        for word in words {
            wordCount[word, default: 0] += 1
        }
        
        // Create an array of Shape from the dictionary
        return wordCount
    }
}
