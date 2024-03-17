import SwiftUI
import Accessibility

@available(iOS 17.0, *)
@available(macOS 12.0, *)


public struct AText: View {
    var text:  String
    var color: Color?
    var accessibilityText: String
    var isDecorative: Bool
        
    public init(text: String, color: Color, size: CGFloat = 20, accessibilityText: String, isDecorative: Bool) {
        self.text = text
        self.color = color
        self.accessibilityText = accessibilityText
        self.isDecorative = isDecorative
        
    }
    
    public init(text: String, accessibilityText: String, isDecorative: Bool) {
        self.text = text
        self.accessibilityText = accessibilityText
        self.isDecorative = isDecorative
        
    }
    
    public var body: some View {
        if self.color != nil{
            Text(self.text)
                .foregroundStyle(self.color!)
                .accessibilityLabel(self.accessibilityText)
                .accessibilityHidden(self.isDecorative)
        } else {
            Text(self.text)
                .accessibilityLabel(self.accessibilityText)
                .accessibilityHidden(self.isDecorative)
        }
        
    }
    
}
