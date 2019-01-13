import UIKit

class EmitterViewController: UIViewController {

    @IBOutlet weak var emitterView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.emitterView.clipsToBounds = true
        
        let layer = self.emitterView.layer
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        let text = ["A", "B", "C", "D", "a", "b", "c", "d"]
        let textEmitter = TextEmitter(bounds: self.emitterView.bounds, text: text)
        self.emitterView.layer.addSublayer(textEmitter.emitterLayer())
    }
    
}
