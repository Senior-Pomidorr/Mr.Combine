//
//  AnyPublisherView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import SwiftUI

struct AnyPublisherView: View {
    @StateObject private var vm = AnyPublisherVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("AnyPublisher",
                           subtitle: "Introduction",
                           desc: "The AnyPublisher is a publisher that all publishers (and operators) can become. You can use a special operator called eraseToAnyPublisher to create this common object.")
               
                Toggle("Home Team", isOn: $vm.home)
                    .padding(.horizontal)
                
                Text("Team")
                    .bold()
                
                List(vm.team, id: \.self) { value in
                    Text(value)
                }
                
                Spacer(minLength: 0)
            }
            .font(.title)
        }
    }
}

#Preview {
    AnyPublisherView()
}
