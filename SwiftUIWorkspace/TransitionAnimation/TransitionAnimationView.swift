//
//  TransitionAnimationView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/1/25.
//

import SwiftUI

struct TransitionAnimationView: View {
    @Namespace private var namespace
        @State private var isShowingDetail = false

        var body: some View {
            if !isShowingDetail {
                Button("Show Detail") {
                    withAnimation {
                        isShowingDetail.toggle()
                    }
                }
                .matchedGeometryEffect(id: "detail", in: namespace)
            } else {
                TransitionDetailView(isShowingDetail: $isShowingDetail)
                    .matchedGeometryEffect(id: "detail", in: namespace)
            }
        }
}

struct TransitionDetailView: View {
    @Binding var isShowingDetail: Bool

    var body: some View {
        VStack {
            Text("Detail View")

            Button("Dismiss") {
                isShowingDetail.toggle()
            }
        }
    }
}

#Preview {
    TransitionAnimationView()
}
