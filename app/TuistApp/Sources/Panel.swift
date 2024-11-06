import SwiftUI

struct Panel<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme

    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .background(.thinMaterial)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(.white.opacity(showProminentBorder ? 0.1 : 0), lineWidth: lineWidth)
            )
            .padding(lineWidth)
            .overlay(
                RoundedRectangle(cornerRadius: 4 + lineWidth)
                    .strokeBorder(.black.opacity(showProminentBorder ? 0.2 : 0), lineWidth: lineWidth)
            )
            .compositingGroup()
            .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 2)
    }

    private var showProminentBorder: Bool {
        colorScheme == .dark
    }

    private var lineWidth: CGFloat {
        0.5
    }
}
