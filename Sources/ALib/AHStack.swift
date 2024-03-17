import SwiftUI
import Accessibility

@available(iOS 15.0, *)
@available(macOS 14.0, *)

public struct AHStack<Content>: View where Content: View{
    var backgroundColor: Color?
    var foregroundColor: Color?
    var alignment: VerticalAlignment
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
        let color1 = Color(color1)
        let color2 = Color(color2)
        
        // Calculate the luminance of each color
        func individualFormula(value: Double) -> Double {
                let Y = ((value + 0.055) / 1.055)
                return pow(Y, 2.4)
                
            }
        
        func luminance(color: Color) -> CGFloat {
            let components = color.cgColor?.components ?? [0, 0, 0, 0] // RGBA or grayscale
            return individualFormula(value: components[0]) * 0.2126 + individualFormula(value: components[1]) * 0.7152 + individualFormula(value: components[2]) * 0.0722
        }
        
        let luminance1 = luminance(color: color1) + 0.05 // Add 0.05 to avoid division by zero
        let luminance2 = luminance(color: color2) + 0.05
        
        // Return the contrast ratio
        
        return max(luminance1, luminance2) / min(luminance1, luminance2)
    }

    
    
    public init(backgroundColor: Color, foregroundColor: Color, @ViewBuilder view: @escaping () -> Content, alignment: VerticalAlignment = .center, spacing: CGFloat = 10) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.view = view
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public init(@ViewBuilder view: @escaping () -> Content, alignment: VerticalAlignment = .center, spacing: CGFloat = 10) {
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
                HStack(alignment: alignment, spacing: spacing) {
                    view()
                }.foregroundColor(contrastRatio(color1: foregroundColor!, color2: backupColor) >= 4.5 ? foregroundColor : backupColor)
            } else {
                HStack(alignment: alignment, spacing: spacing) {
                    view()
                }
            }
            
        }

        
    }
}
