import SwiftUI
import Accessibility

@available(iOS 17.0, *)
@available(macOS 12.0, *)

public struct ATextField: View {
    var textHint: AText
    var color: Color
    @Binding var receivedText: String
    var height: CGFloat?
    var width: CGFloat?
    
    
    public init(textHint: AText, receivedText: Binding<String>, color: Color = Color.gray) {
        self.textHint = textHint
        self._receivedText = receivedText
        self.color = color
    }
    
    public init(textHint: AText, receivedText: Binding<String>, color: Color = Color.gray, height: CGFloat = 44.0, width: CGFloat = .infinity) {
        self.textHint = textHint
        self._receivedText = receivedText
        self.color = color
        self.height = height
        self.width = width
    }
    public var body: some View {
        TextField( textHint.text, text: $receivedText)
            .foregroundColor(self.textHint.color)
            .border(self.color)
            .accessibilityLabel(self.textHint.accessibilityText)
            .padding()
            .frame(minWidth: 44, idealWidth: 44 * (width ?? 1.0), minHeight: 44, idealHeight: 44 * (height ?? 1.0))
    }
}

