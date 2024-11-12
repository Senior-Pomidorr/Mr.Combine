//
//  DataTaskPublisherView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 13.11.2024.
//

import SwiftUI


struct DataTaskPublisherView: View {
    @StateObject private var vm = DataTaskPublisherVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("URLSession DataTaskPublisher",
                       subtitle: "Introduction",
                       desc: "URLSession has a dataTaskPublisher you can use to get data from a URL and run it through a pipeline.")
            HStack {
                Button("simulateError") {
                    vm.simulateErrorURL()
                }
                .frame(maxWidth: .infinity)
                
                Button("correctUrl") {
                    vm.correctUrl()
                }
                .frame(maxWidth: .infinity)
            }
            List(vm.data) { post in
                Text(post.title)
                Text(post.body)
            }
            .font(.title3)
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
        .alert(item: $vm.errorForAlert) { error in
            Alert(title: Text(error.title),
                  message: Text(error.message)
            )
        }
    }
}

#Preview {
    DataTaskPublisherView()
}
