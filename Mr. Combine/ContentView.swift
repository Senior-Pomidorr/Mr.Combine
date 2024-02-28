//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var number = ""
    @State private var checkNumbers = false
    @StateObject private var vm = AllSatisfy()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("TryContains",
                           subtitle: "Introduction",
                           desc: "TryContains")
                
                Form {
                    NavigationLink {
                        CountDetailView(data: vm.data)
                    } label: {
                        Text(vm.title)
                            .frame(width: .infinity, alignment: .leading)
                        Text("\(vm.count)")
                    }
                }
                Text("Result: \(vm.count)")
            }
            .onAppear() {
                vm.fetch()
            }
            .padding(.bottom)
            .font(.title)
        }
    }
}


struct CountDetailView: View {
    var data: [String]
    
    var body: some View {
        List(data, id: \.self) { dataIn in
            Text(dataIn)
        }
        .font(.title)
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
