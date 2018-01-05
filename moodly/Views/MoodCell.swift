import UIKit

class MoodCell: UICollectionViewCell {
    @IBOutlet weak var activitiesTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var mood: Mood! {
        didSet{
            dateLabel.text = mood.date.description
            categoryLabel.text = mood.category.name
            self.backgroundColor = mood.category.color
            
            var text = ""
            for actvitity in mood.activities {
                text.append(actvitity.icon+" "+actvitity.name+"\n")
            }
            activitiesTextView.text = text
            activitiesTextView.backgroundColor = mood.category.color
        }
        
    }
    
    private func prepareView() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
}
