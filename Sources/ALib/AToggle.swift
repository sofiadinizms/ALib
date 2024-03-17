import SwiftUI
import Accessibility


@available(iOS 15.0, *)
@available(macOS 12.0, *)


public struct AToggle: View {
    @Binding var enableToggle: Bool
    var toggleText: AText
    var height: CGFloat
    var width: CGFloat
    
    public init(enableToggle: Binding<Bool>, toggleLabel: AText, height: CGFloat = 1.0, width: CGFloat = 1.0) {
        self._enableToggle = enableToggle
        self.toggleText = toggleLabel
        self.height = height
        self.width = width
    }
    
    public var body: some View {
        Toggle(isOn: $enableToggle){
            Text(toggleText.text)
        }
        .accessibilityValue(enableToggle == true ? "enable" : "disable")
        .padding()
        .frame(minWidth: 44, idealWidth: 44 * width, minHeight: 44, idealHeight: 44 * height)
    }
}
