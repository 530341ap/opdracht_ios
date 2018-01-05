import UIKit

class Category {
    var name: String
    var color: UIColor
    
    init(name: String, color:UIColor = .orange) {
        self.name = name;
        self.color = color;
    }
}
