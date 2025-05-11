//
//  ReportView+PDFPages.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI
import SwiftUIPDF

extension ReportView {
    func pages() -> [PDFSection] {
        [
            createTitlePage(),
            createStudentsWorkingWithTechnologyPage(),
            createWhatsHappeningExportView(),
            createStudentEngagementView(),
            createHowTechnologyIsUsedView(),
            createQuestionsPosedView(),
            createCommentsView(),
            createImagesView()
        ]
    }
    
    fileprivate func createTitlePage() -> PDFSection {
        PDFSection {
            PDFViewGroup(VStack(alignment: .leading) {
                Text("Pedagram Report")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                Text("\(session.lessonTime.formatted(date: .abbreviated, time: .omitted)) • \(session.lessonTime.formatted(date: .omitted, time: .shortened))")
            }
            .padding(.bottom, 16))
            
            PDFViewGroup(HStack(alignment: .top) {
                ReportValueCardView(title: "Class", value: session.class)
                ReportValueCardView(title: "Grade", value: session.grade)
                ReportValueCardView(title: "Subject", value: session.subject ?? "N/A")
            }
            .padding(.bottom, 8))
            
            PDFViewGroup(HStack(alignment: .top) {
                ReportValueCardView(title: "Enrolment", value: "\(session.enrolment)")
                ReportValueCardView(title: "Observations", value: "\(session.observations.count)")
                ReportValueCardView(title: "Observation Interval", value: "\(Int(session.recordingFrequency ?? 15))m")
            })
        }
    }
    
    fileprivate func createStudentsWorkingWithTechnologyPage() -> PDFSection {
        createExportView(title: "Students working with technology",
                         description: "Count of the number of students working with technology at each observation.") {
            ReportExportStudentsWorkingWithTechnologyView(session: session)
        }
    }
    
    fileprivate func createWhatsHappeningExportView() -> PDFSection {
        createExportView(title: "What‘s Happening",
                         description: "Understand what the student is doing (independent work, pair work, or group work) compared to what the teacher is doing.") {
            ReportWhatsHappeningExportView(session: session)
        }
    }
    
    fileprivate func createStudentEngagementView() -> PDFSection {
        let commentCount = session.observations.reduce(0) { partialResult, observation in
            if let comment = observation.whatIsTheLevelOfStudentEngagement?.scaleComments?.comments, !comment.isEmpty {
                return partialResult + 1
            } else {
                return partialResult
            }
        }
        
        let observations = session.observations.reversed()
        
        return PDFSection {
            PDFViewGroup(VStack {
                Text("Student Engagement")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text("On a scale of 1 to 5.")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom))
            
            PDFViewGroup(ReportStudentEngagementGraphView(session: session))
            
            PDFViewGroup(Divider()
                .padding(.vertical))
            
            PDFViewGroup(HStack {
                Text("Comments (\(commentCount))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            })
            
            for observation in observations {
                ReportExportCommentView(observation: observation)
            }
            
            PDFViewGroup(
                VStack {
                    HStack {
                        Text("Teacher doing…")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    
                    ForEach(colorAssignment.keys.map { $0 }.sorted(), id: \.self) { key in
                        HStack {
                            Image(systemName: "square.fill")
                                .foregroundStyle(colorAssignment[key]!)
                                .opacity(0.4)
                            
                            Text(LocalizedStringKey(key))
                            Spacer()
                            
                            let count = session.observations.filter {
                                $0.whatIsTheTeacherDoing?.stringValue == key
                            }.count
                            
                            Text("\(count)")
                                .foregroundStyle(.secondary)
                                .monospaced()
                        }
                    }
                }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 8))
                    .padding(.top)
            )
        }
    }
    
    fileprivate func createHowTechnologyIsUsedView() -> PDFSection {
            PDFSection {
                PDFViewGroup(
                    VStack {
                        Text("How Technology is Used by Teacher")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        let technologies = session.observations.compactMap {
                            $0.technologyUsedByTeacher?.stringArrayValue ?? []
                        }.flatMap { $0 }.filter { !$0.isEmpty }
                        
                        VStack(alignment: .leading) {
                            Text("\(Double(technologies.count) / Double(session.observations.count), specifier: "%.2f")")
                                .monospacedDigit()
                                .contentTransition(.numericText())
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Average Number of Technologies Used")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding(.bottom)
                )
                
                PDFViewGroup(Divider().padding(.vertical))
                
                PDFViewGroup(
                    Text("By App")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                )
                
                let technologies = session.observations.compactMap {
                    $0.technologyUsedByTeacher?.stringArrayValue ?? []
                }.flatMap { $0 }.filter { !$0.isEmpty }
                
                let technologiesUsed = Array(Set(technologies)).sorted()
                for technology in technologiesUsed {
                    ReportExportMatrixView(rowHeaders: ListOfOptionsDictionarySurveyInput.options,
                                           columnHeaders: Array(session.sortedObservations.reversed()),
                                           title: LocalizedStringResource(stringLiteral: technology),
                                           columnHeaderLabel: { observation in
                        observation.time.formatted(date: .omitted, time: .shortened)
                    }, shouldHighlight: { row, observation in
                        let observationDict = observation.howIsTheTeacherUsingTechnology?.dictValue ?? [:]
                        let selections = observationDict[technology] ?? []
                        
                        return selections.contains(row)
                    })
                }
                
                PDFViewGroup(
                    Text("By Purpose")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .padding(.top)
                )
                
                for option in ListOfOptionsDictionarySurveyInput.options {
                    ReportExportMatrixView(rowHeaders: technologiesUsed.map {
                        LocalizedStringResource(stringLiteral: $0)
                    },
                                           columnHeaders: Array(session.sortedObservations.reversed()),
                                           title: option,
                                           columnHeaderLabel: { observation in
                        observation.time.formatted(date: .omitted, time: .shortened)
                    }, shouldHighlight: { technology, observation in
                        let observationDict = observation.howIsTheTeacherUsingTechnology?.dictValue ?? [:]
                        let selections = observationDict[technology] ?? []
                        
                        return selections.contains(option.key)
                    })
                }
            }
    }
    
    fileprivate func createQuestionsPosedView() -> PDFSection {
        let questions = session.observations.compactMap { observation in
            (observation.questionsPosedByTeacherToStudents?.stringArrayValue ?? []).compactMap {
                ($0, observation.time)
            }
        }.flatMap {
            $0
        }.filter { !$0.0.isEmpty }
        
        return PDFSection {
            PDFViewGroup(
                VStack {
                    Text("Questions Posed")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    
                    VStack(alignment: .leading) {
                        Text("\(questions.count)")
                            .monospacedDigit()
                            .contentTransition(.numericText())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                    .padding(.bottom)
            )
            
            for (question, date) in questions {
                ReportExportQuestionView(text: question, time: date)
            }
        }
    }
    
    fileprivate func createCommentsView() -> PDFSection {
        let comments = session.observations.compactMap { observation in
            if let comment = observation.comments?.stringValue, !comment.isEmpty {
                return (comment, observation.time)
            }
            return nil
        }
        
        return PDFSection {
            PDFViewGroup(
                VStack {
                    Text("Comments")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    
                    VStack(alignment: .leading) {
                        Text("\(comments.count)")
                            .monospacedDigit()
                            .contentTransition(.numericText())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                    .padding(.bottom)
            )
            
            for (comment, date) in comments {
                ReportExportQuestionView(text: comment, time: date)
            }
        }
    }
    
    fileprivate func createImagesView() -> PDFSection {
        let images = session.images ?? []
        
        return PDFSection {
            PDFViewGroup(
                VStack {
                    Text("Images")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    
                    VStack(alignment: .leading) {
                        Text("\(images.count)")
                            .monospacedDigit()
                            .contentTransition(.numericText())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                    .padding(.bottom)
            )
            
            for image in images {
                let baseURL = URL.documentsDirectory.appending(path: "images")
                
                let url = baseURL.appending(path: image.imageName)
                
                let data = try? Data(contentsOf: url)
                let outputImage = UIImage(data: data ?? .init()) ?? UIImage(systemName: "exclamationmark.triangle")!
                
                VStack {
                    Image(uiImage: outputImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 8))
                        .frame(maxWidth: .infinity)
                    
                    Text(image.date.formatted(date: .omitted, time: .shortened))
                        .foregroundStyle(.secondary)
                    
                    Text(image.caption.isEmpty ? String(localized: "No Caption") : image.caption)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 8))
                .padding(.top)
            }
        }
    }
}
