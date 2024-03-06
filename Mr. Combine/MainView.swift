//
//  SwiftUIView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("Collect") {
                    CollectView()
                }
                NavigationLink("CollectBy: ") {
                    CollectBy()
                }
                NavigationLink("CollectByTime: ") {
                    CollectByView()
                }
                NavigationLink("IgnoreOutput") {
                    IgnoreOutput()
                }
                NavigationLink("Reduce") {
                    ReduceView()
                }
                NavigationLink("First(where:)") {
                    FirstWhereView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
