import UIKit

class AddMoodViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var activitiesTextView: UITextView!
    
    var user: User!
    var mood: Mood?
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        if let mood = mood {
            datePicker.date = mood.date
            categoryPicker.selectRow(user.categoryIndex(mood.category), inComponent: 0, animated: true)
            activitiesTextView.text = user.activitiesText(mood.activities)
        }
    }
    
    @IBAction func save() {
        if mood != nil {
            performSegue(withIdentifier: "didEditMood", sender: self)
        } else {
            performSegue(withIdentifier: "didAddMood", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "chooseActivities"?:
                let activitiesViewController = segue.destination as! ActivitiesViewController
                activitiesViewController.user = user
            case "didAddMood"?: mood = Mood(date: datePicker.date, category: user.categories[categoryPicker.selectedRow(inComponent: 0)], activities: activities)
            case "didEditMood"?:
                mood!.date = datePicker.date
                mood!.category = user.categories[categoryPicker.selectedRow(inComponent: 0)]
            default:
                fatalError("Unknown segue")
        }
        
    }
    
    @IBAction func unwindFromAddActivities(_ segue: UIStoryboardSegue) {
        if (segue.identifier == "didChooseActivities"){
            let activitiesViewController = segue.source as! ActivitiesViewController
            activities = activitiesViewController.chosenActivities
            activitiesTextView.text = user.activitiesText(activitiesViewController.chosenActivities)
        } else {
            fatalError("Unknown segue")
        }
    }
}

extension AddMoodViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return user.categoryName(at: row)
    }
}

extension AddMoodViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return user.categories.count
    }
}
