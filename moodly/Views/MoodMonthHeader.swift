import UIKit

class MoodMonthHeader: UICollectionReusableView {
    
    @IBOutlet weak var monthLabel: UILabel!
    
    var month: String! {
        didSet {
            monthLabel.text = month
        }
    }
}
