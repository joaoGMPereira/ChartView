import SwiftUI

public enum ChartLabelType {
    case title
    case subTitle
    case largeTitle
    case custom(size: CGFloat, padding: EdgeInsets, color: Color)
    case legend
}

public enum ChartLabelFormat {
    case custom(completion: (Double) -> String)
    case none
    
    func format(value: Double) -> String {
        switch self {
        case .custom(let completion):
            return completion(value)
        case .none:
            return String(format: "%.01f", value)
        }
    }
}

public enum ChartLabelPosition {
    case left
    case middle
    case right
}

public struct ChartLabel: View, LabelBase {
    @EnvironmentObject private var data: LabelData
    @EnvironmentObject var chartValue: ChartValue
    @State var textToDisplay: String = ""
    
    public var labelData = LabelData()
    private var position: ChartLabelPosition
    private var format: ChartLabelFormat
    
    private var labelSize: CGFloat {
        switch labelType {
        case .title:
            return 32.0
        case .legend:
            return 14.0
        case .subTitle:
            return 24.0
        case .largeTitle:
            return 38.0
        case .custom(let size, _, _):
            return size
        }
    }

    private var labelPadding: EdgeInsets {
        switch labelType {
        case .title:
            return EdgeInsets(top: 16.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .legend:
            return EdgeInsets(top: 4.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .subTitle:
            return EdgeInsets(top: 8.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .largeTitle:
            return EdgeInsets(top: 24.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
        case .custom(_, let padding, _):
            return padding
        }
    }

    private let labelType: ChartLabelType

    private var labelColor: Color {
        switch labelType {
        case .title:
            return .black
        case .legend:
            return .gray
        case .subTitle:
            return .black
        case .largeTitle:
            return .black
        case .custom(_, _, let color):
            return color
        }
    }

    public init (type: ChartLabelType = .title, position: ChartLabelPosition = .left, format: ChartLabelFormat = .none) {
        self.labelType = type
        self.position = position
        self.format = format
    }

    public var body: some View {
        HStack {
            if position == .right || position == .middle {
                Spacer()
            }
            Text(textToDisplay)
                .font(.system(size: labelSize))
                .bold()
                .foregroundColor(self.labelColor)
                .padding(self.labelPadding)
                .onAppear {
                    self.textToDisplay = self.data.title
            }
            .onReceive(self.chartValue.objectWillChange) { _ in
                self.textToDisplay = self.chartValue.interactionInProgress ? self.format.format(value: self.chartValue.currentValue) : self.data.title
            }.onReceive(self.data.$title) { _ in
                self.textToDisplay = self.data.title
            }
            if position == .left || position == .middle {
                Spacer()
            }
        }
    }
}
