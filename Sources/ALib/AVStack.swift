import SwiftUI
import Accessibility

@available(iOS 17.0, *)
@available(macOS 14.0, *)

public struct AVStack<Content>: View where Content: View{
    @Environment(\.self) var environment
    
    var backgroundColor: Color?
    var foregroundColor: Color?
    var alignment: HorizontalAlignment
    var spacing: CGFloat
    var view: () -> Content
    var backupColor: Color{
        if contrastRatio(color1: .white, color2: backgroundColor!) > contrastRatio(color1: .black, color2: backgroundColor!){
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

    
    
    public init(backgroundColor: Color, foregroundColor: Color, @ViewBuilder view: @escaping () -> Content, alignment: HorizontalAlignment = .center, spacing: CGFloat = 10) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.view = view
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public init(@ViewBuilder view: @escaping () -> Content, alignment: HorizontalAlignment = .center, spacing: CGFloat = 10) {
        self.view = view
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public var body: some View {
        

        ZStack{
            if self.backgroundColor != nil{
                backgroundColor
            }
            
            if self.foregroundColor != nil{
                VStack(alignment: alignment, spacing: spacing) {
                    view()
                }.foregroundColor(contrastRatio(color1: foregroundColor!, color2: backgroundColor ?? .clear) >= 4.5 ? foregroundColor : backupColor)
            } else {
                VStack(alignment: alignment, spacing: spacing) {
                    view()
                }
            }
            
        }
        
    }
}
