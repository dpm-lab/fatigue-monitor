//
//  ContentView.swift
//  E4tester
//
//  Created by Waley Zheng on 6/18/22.
//  Copyright © 2022 Felipe Castro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userChecker: UserExistenceChecker
    @EnvironmentObject var modelData: ModelData
    @State private var selection: Tab = .dashboard
    
    enum Tab {
        case dashboard
        case device
        case survey
        case tips
        case profile
    }

    
    var body: some View {
        switch userChecker.userExists {
        case .exists:
            TabView(selection: $selection) {
                DashboardView(tabSelection: $selection)
                    .tabItem {
                        Label("Dashboard", systemImage: "heart.text.square")
                    }
                    .tag(Tab.dashboard)
                
                DeviceView()
                    .tabItem {
                        Label("Device", systemImage: "applewatch")
                    }
                    .tag(Tab.device)
                
                SurveyInfoView()
                    .tabItem {
                        Label("Surveys", systemImage: "checkmark.square.fill")
                    }
                    .tag(Tab.survey)
                
                TipsView()
                    .tabItem {
                        Label("Tips", systemImage: "lightbulb.fill")
                    }
                    .tag(Tab.tips)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(Tab.profile)
            }
            .onAppear {
                FirebaseManager.connect()
                FirebaseManager.getUserGroupId()
            }
        case .doesNotExist:
            NewUserView()
        case .unknown:
            ProgressView()
        case .error:
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userChecker: .init(uid: "12345"))
            .environmentObject(ModelData())
    }
}
