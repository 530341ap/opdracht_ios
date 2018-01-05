import UIKit

class YearCell: UITableViewCell {
    @IBOutlet weak var yearLabel: UILabel!
    
    var year: Int! {
        didSet{
            yearLabel.text = String(year)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
