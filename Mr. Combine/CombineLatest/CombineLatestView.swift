//
//  CombineLatestView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import SwiftUI

struct CombineLatestView: View {
    @StateObject private var vm = CombineLatestVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("CombineLatest",
                           subtitle: "Introduction",
                           desc: "If you're working with more than two publishers then you will have to keep adding more input parameters into the closure.")
               
                VStack {
                    Image(vm.artData.artist)
                        .resizable()
                        .scaledToFit()
                    Text(vm.artData.artist)
                        .font(.body)
                }
                .padding()
                .background(vm.artData.color.opacity(0.3))
                .padding()
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}

#Preview {
    CombineLatestView()
}
