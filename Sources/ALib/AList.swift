import SwiftUI
import Accessibility

@available(iOS 15.0, *)
@available(macOS 12.0, *)

public struct AList<Element, RowContent: View>: View where Element: Identifiable {
    
    
    public enum ListColor: ShapeStyle {
        case red
        case blue
        case indigo
        case purple
        case pink
        case brown
        
        var color: Color {
            switch self {
            case .red:
                return Color.red
            case .blue:
                return Color.blue
            case .indigo:
                return Color.indigo
            case .purple:
                return Color.purple
            case .pink:
                return Color.pink
            case .brown:
                return Color.brown
            }
        }
    }
    
    private var items: [Element]
    private var rowContent: (Element) -> RowContent
    private var systemName1: String?
    private var action1: (() -> Void)?
    private var color1: ListColor?
    private var systemName2: String?
    private var action2: (() -> Void)?
    private var color2: ListColor?
    private var systemName3: String?
    private var action3: (() -> Void)?
    private var color3: ListColor?
    
    
    public init(_ items: [Element], @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.items = items
        self.rowContent = rowContent
    }
    
    public init(_ items: [Element], @ViewBuilder rowContent: @escaping (Element) -> RowContent, systemName1: String, action1: (() -> Void)?, color1: ListColor = .indigo) {
        self.items = items
        self.rowContent = rowContent
        self.systemName1 = systemName1
        self.action1 = action1
        self.color1 = color1
        
    }
    
    public init(_ items: [Element], @ViewBuilder rowContent: @escaping (Element) -> RowContent, systemName1: String, action1: (() -> Void)?,color1: ListColor = .indigo, systemName2: String, action2: (() -> Void)?, color2: ListColor = .indigo) {
        self.items = items
        self.rowContent = rowContent
        self.systemName1 = systemName1
        self.action1 = action1
        self.color1 = color1
        self.systemName2 = systemName2
        self.action2 = action2
        self.color2 = color2
        
    }
    
    public init(_ items: [Element], @ViewBuilder rowContent: @escaping (Element) -> RowContent, systemName1: String = "", action1: (() -> Void)? = nil, color1: ListColor = .indigo, systemName2: String = "", action2: (() -> Void)? = nil, color2: ListColor = .indigo, systemName3: String = "", action3: (() -> Void)? = nil, color3: ListColor = .indigo) {
        self.items = items
        self.rowContent = rowContent
        self.systemName1 = systemName1
        self.action1 = action1
        self.color1 = color1
        self.systemName2 = systemName2
        self.action2 = action2
        self.color2 = color2
        self.systemName3 = systemName3
        self.action3 = action3
        self.color3 = color3
    }
    
    public var body: some View {
        
        List(items){item in
            rowContent(item)
                .frame(minHeight: 44, idealHeight: 44)
                .swipeActions(edge: .trailing) {
                    if let action1 = action1 {
                        Button {
                            action1()
                        } label: {
                            Image(systemName: systemName1 ?? "")
                                .resizable()
                        }.tint(color1?.color)
                    }
                    
                    if let action2 = action2 {
                        Button {
                            action2()
                        } label: {
                            Image(systemName: systemName2 ?? "")
                                .resizable()
                        }.tint(color2?.color)
                    }
                    
                    if let action3 = action3 {
                        Button {
                            action3()
                        } label: {
                            Image(systemName: systemName3 ?? "")
                                .resizable()
                        }.tint(color3?.color)
                    }
                }
        }
        
        
    }
}

