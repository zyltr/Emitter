import UIKit

class TextEmitter {
    
    private let bounds: CGRect
    private let text: [String]
    
    
    public init (bounds: CGRect, text: [String]) {
        self.bounds = bounds
        self.text = text
    }
    
    public func emitterLayer() -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterSize = self.bounds.insetBy(dx: -self.bounds.size.width * 0.01, dy: -self.bounds.size.height * 0.01).size
        emitterLayer.emitterMode = .outline
        
        var cells = [CAEmitterCell]()
        
        self.text.forEach {
            string in
            
            let fontSize = CGFloat.random(in: 10.0 ... 30.0)
            let fontWeight = self.randomFontWeight(choices: [.thin, .regular, .bold])
            let font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
            let size = self.boundingRectagle(forString: string, usingFont: font)
            
            let textLayer = CATextLayer()
            
            textLayer.frame = CGRect(origin: CGPoint.zero, size: size)
            textLayer.string = string
            textLayer.font = font
            textLayer.fontSize = fontSize
            
            let cell = CAEmitterCell()
            
            cell.contents = self.imageFromLayer(layer: textLayer).cgImage
            cell.color = UIColor.black.cgColor
            cell.alphaSpeed = -0.25
            cell.scale = 0.2
            cell.scaleRange = 0.5
            cell.spinRange = 2.0 * CGFloat.pi
            cell.emissionRange = 2.0 * CGFloat.pi
            cell.birthRate = Float.random(in: 1 ... 5)
            cell.lifetime = 4.0
            cell.velocity = 50.0
            cell.velocityRange = CGFloat.random(in: 75.0 ... 125.0)
            
            cells.append(cell)
        }
        
        emitterLayer.emitterCells = cells
        
        return emitterLayer
    }
    
    private func randomFontWeight(choices: [UIFont.Weight]) -> UIFont.Weight {
        guard !choices.isEmpty else {
            return UIFont.Weight.regular
        }
        
        return choices[Int.random(in: 0 ..< choices.count)]
    }
    
    private func boundingRectagle(forString string: String, usingFont font: UIFont) -> CGSize {
        let attributes : [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font : font]
        return (string as NSString).size(withAttributes: attributes)
    }
    
    private func imageFromLayer(layer: CALayer) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: layer.bounds.size)
        return renderer.image { context in layer.render(in: context.cgContext) }
    }
    
}
