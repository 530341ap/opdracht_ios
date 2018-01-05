import UIKit

class MoodlyViewController : UITableViewController {
    var user: User = User()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addActivities"?:
            let addActivitiesViewController = segue.destination as! AddActivitiesViewController
            addActivitiesViewController.user = user
        case "showMoods"?:
            //Source: https://github.com/NatashaTheRobot/UISplitViewControllerDemo/blob/master/SplitViewControllerDemo/SelectColorTableViewController.swift voor topViewController op te vragen
            let navigationController = segue.destination as? UINavigationController
            let moodViewController = navigationController!.topViewController as! MoodsViewController
            let selection = tableView.indexPathForSelectedRow!
            moodViewController.user = user
            moodViewController.year = user.years()[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.numberOfYears()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yearCell", for: indexPath) as! YearCell
        cell.year = user.years()[indexPath.row]
        return cell
    }
}
extension MoodlyViewController : UISplitViewControllerDelegate {
    
}
