//
//  CatchView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import SwiftUI

struct CatchView: View {
    @StateObject private var vm = CatchVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Catch",
                           subtitle: "Introduction",
                           desc: "Use the catch operator to intercept errors thrown upstream and specify a publisher to publish new data from within the provided closure.")
                List(vm.dataToView, id: \.self) { value in
                    Text(value)
                }
                .listStyle(.plain)
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}

#Preview {
    CatchView()
}
