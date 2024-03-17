import SwiftUI
import Accessibility

@available(iOS 17.0, *)
@available(macOS 12.0, *)


public struct AImage: View {
    var description:  String
    var image: Image
    var isDecorative: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(description: String, image: Image, isDecorative: Bool) {
        self.description = description
        self.image = image
        self.isDecorative = isDecorative
        
    }
    
    public var body: some View {
        if self.isDecorative {
            image
                .accessibilityHidden(true)
        } else {
            image
                .accessibilityLabel(self.description)
        }
        
    }
    
}
