import UIKit


extension UIView {
    
    func bounceOut(duration: TimeInterval) {
        
        UIView.animate(withDuration: duration) {
            [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.001)
        }
    }
}


extension Int {
    
    func times(_ closure: () -> Void) {
        
        guard self > 0 else { return }
        
        for _ in 0..<self {
            closure()
        }
    }
}

5.times {
    print("Hello")
}


extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

var test = [1,2,3]
test.remove(item: 3)
