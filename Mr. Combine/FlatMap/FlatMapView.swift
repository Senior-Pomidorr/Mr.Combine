//
//  FlatMapView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import SwiftUI

struct FlatMapView: View {
    @StateObject private var vm = FlatMapVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("FlatMap",
                           subtitle: "Introduction",
                           desc: "«The flatMap operator can be used to create a new publisher for each item that comes through the pipeline.")
               
                Text( vm.names.joined(separator: ", "))
                    .padding(.horizontal)
                
                HStack {
                    Button("Get Score") {
                        vm.fetchResults()
                    }
                    .padding(.horizontal)
                    Button("Clear") {
                        vm.removAll()
                    }
                    .padding(.horizontal)
                }
                
                
                List(vm.nameResult, id: \.name) { value in
                    HStack {
                        Text(value.name)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        Text("\(value.gender): ")
                        Text(getPercent(value.probability))
                    }
                }
                .listStyle(.plain)
            }
            .font(.title)
        }
    }
    func getPercent(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}


#Preview {
    FlatMapView()
}
