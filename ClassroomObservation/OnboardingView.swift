//
//  OnboardingView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 14/5/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isNewSessionPresented: Bool
    
    @State private var onboardingStage = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("WELCOME TO")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("Pedagram")
                .foregroundStyle(.blue)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TabView(selection: $onboardingStage) {
                OnboardingDynamicView(content: {
                    ZStack(alignment: .top) {
                        Image(systemName: "sidebar.left")
                            .font(.system(size: 200, weight: .light))
                            .foregroundStyle(.tertiary)
                        
                        ZStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.white)
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.blue)
                        }
                        .offset(x: -35)
                    }
                }, title: "Create a Record", description: "Work with a peer and observe their lessons. Use Pedagram to provide objective feedback.")
                .tag(0)
                
                OnboardingDynamicView(content: {
                    Image(systemName: "list.clipboard")
                        .font(.system(size: 200, weight: .light))
                        .foregroundStyle(.blue)
                        .symbolRenderingMode(.multicolor)
                }, title: "Set Up Your Session", description: "Record the class, subject, duration, and other additional details.\n\nThis information will show up in the report.")
                .tag(1)
                
                OnboardingDynamicView(content: {
                    HStack {
                        Image(systemName: "10.circle")
                            .font(.system(size: 150, weight: .regular))
                        Image(systemName: "15.circle.fill")
                            .font(.system(size: 150, weight: .regular))
                    }
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.hierarchical)
                    
                }, title: "Pick a Recording Duration", description: "A shorter observation durations can provide more granular data entry, while longer durations can provide more time for data entry.\n\nSelect the one you are most comfortable with. When starting out, it is recommended to go with 15 minutes to familiarise yourself with the process and questions.")
                .tag(2)
                
                OnboardingDynamicView(content: {
                    HStack {
                        Image(systemName: "plus")
                            .padding(.trailing)
                        Text("Create New Observation")
                    }
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.hierarchical)
                    .padding()
                    .background(.blue.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 16))
                    
                }, title: "Create an Observation", description: "Once you have set it up, get started by creating an observation. Follow the questions on screen and fill it out based on what you observe in the classroom.\n\nYou will be prompted to submit a new observation every 10 or 15 minutes, based on your Recording Duration.")
                .tag(3)
                
                OnboardingDynamicView(content: {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 270, weight: .light))
                        .foregroundStyle(.blue)
                        .symbolRenderingMode(.hierarchical)
                    
                }, title: "Analyse the Report", description: "When the lesson is over, select End Session to generate a report.\n\nThe report is designed to be easily analysed to gain insights into how technology is used in the classroom, and what the students have been doing at various times.\n\nYou can also export the report as a PDF to share with others.")
                .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<5) { page in
                    Button {
                        withAnimation {
                            onboardingStage = page
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(page == onboardingStage ? .blue : .gray.opacity(0.4))
                            .frame(height: 8)
                            .padding(.vertical)
                    }
                }
            }
            
            HStack {
                if onboardingStage >= 1 {
                    Button {
                        withAnimation {
                            onboardingStage -= 1
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .padding()
                    }
                    .buttonStyle(.bordered)
                }
                
                Button {
                    isNewSessionPresented.toggle()
                } label: {
                    Text("Create New Session")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                if onboardingStage < 4 {
                    Button {
                        withAnimation {
                            onboardingStage += 1
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .padding()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .animation(.default, value: onboardingStage)
        }
        .padding()
    }
}
