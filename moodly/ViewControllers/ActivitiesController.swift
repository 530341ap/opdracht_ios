import UIKit

class ActivitiesViewController : UICollectionViewController {
    var user: User!
    var chosenActivities: [Activity] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addActivities"?:
            let addActivitiesViewController = segue.destination as! AddActivitiesViewController
            addActivitiesViewController.user = user
        case "didChooseActivities"?:
            break;
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func save() {
        performSegue(withIdentifier: "didChooseActivities", sender: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.activities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCell
        cell.activity = user.activities[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCell
        let activity = user.activities[indexPath.item]
        if(chosenActivities.contains{activity.name == $0.name}) {
            chosenActivities.remove(at: chosenActivities.index(where: {activity.name == $0.name})!)
            cell.backgroundColor = .white
        } else {
            print(activity.name)
            chosenActivities.append(activity)
            cell.backgroundColor = .gray
        }
        
    }
}

extension ActivitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = traitCollection.horizontalSizeClass == .regular ? 6 : 3
        let whiteSpace = 16 + (columns - 1) * 8
        let cellWidth = (collectionView.frame.width - CGFloat(whiteSpace)) / CGFloat(columns)
        return CGSize(width: cellWidth, height: 80)
    }
}
