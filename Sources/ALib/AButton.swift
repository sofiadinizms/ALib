import SwiftUI
import Accessibility


@available(iOS 17.0, *)
@available(macOS 14.0, *)

public struct AButton<Content>: View where Content: View{
    @Environment(\.self) var environment
    
    var action: () -> Void
    
    var view: () -> Content
    var accessibilityText: String
    
    var width: CGFloat
    var height: CGFloat
    
    var backgroundColor: Color
    
    var padding:CGFloat
    
    var borderColor: Color
    var borderThickness: CGFloat
    
    var cornerRadius:CGFloat
    
    
    var foregroundColor: Color
    var backupColor: Color{
        if contrastRatio(color1: .white, color2: backgroundColor) > contrastRatio(color1: .black, color2: backgroundColor){
            return .white
        } else {
            return .black
        }
    }
    
    func contrastRatio(color1: Color, color2: Color) -> Double {
        // Convert colors to the sRGB color space
        let color1 = Color(color1).resolve(in: environment)
        let color2 = Color(color2).resolve(in: environment)
        
        // Calculate the luminance of each color
        let luminance1 = luminance(color: color1) + 0.05 // Add 0.05 to avoid division by zero
        let luminance2 = luminance(color: color2) + 0.05
        
        // Return the contrast ratio
        
        print(max(luminance1, luminance2) / min(luminance1, luminance2))
        return max(luminance1, luminance2) / min(luminance1, luminance2)
    }
    
    func luminance(color: Color.Resolved) -> CGFloat {
    
        let components = [color.red, color.green, color.blue] // RGBA or grayscale
        

        let r = individualFormula(value:components[0]) * 0.2126
        let g = individualFormula(value: components[1]) * 0.7152
        let b = individualFormula(value: components[2]) * 0.0722
        
        return CGFloat(r + g + b)
    }
    
    
    func individualFormula(value: Float) -> Float {
        let Y = ((value + 0.055) / 1.055)
        
        return pow(Y, 2.4)
    }
    
    

    public init(action:@escaping () -> Void, accessibilityText: String, padding: CGFloat = 10.0, cornerRadius:CGFloat = 10.0, borderColor: Color = Color.accentColor, backgroundColor: Color, borderThickness: CGFloat = 0.0, width: CGFloat = 100, height: CGFloat = 30, foregroundColor: Color, @ViewBuilder view: @escaping () -> Content) {
        
        self.action = action
        
        self.accessibilityText = accessibilityText
        self.foregroundColor = foregroundColor
        
        self.width = width
        self.height = height
        
        self.backgroundColor = backgroundColor
        
        self.padding = padding
        
        self.borderColor = borderColor
        self.borderThickness = borderThickness
        
        self.cornerRadius = cornerRadius
        
        self.view = view
        
    }
    public var body: some View {
        Button (action: self.action ) {
            view()
                .padding(self.padding)
                .foregroundColor(contrastRatio(color1: foregroundColor, color2: backupColor) >= 4.5 ? foregroundColor : backupColor)
                .background(
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(self.borderColor, lineWidth: self.borderThickness)
                        .frame(minWidth: 44, idealWidth:44 * self.width, minHeight: 44, idealHeight: 44 * self.height)
                    
                        .overlay( RoundedRectangle(cornerRadius: self.cornerRadius)
                            .fill(self.backgroundColor)
                            .frame(minWidth: 44, idealWidth:44 * self.width, minHeight: 44, idealHeight: 44 * self.height)
                        )
                    
                        
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(self.accessibilityText)
        .padding()
    }
}
