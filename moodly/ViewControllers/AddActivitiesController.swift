import UIKit

class AddActivitiesViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var iconTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var user: User!
    
    @IBAction func add() {
        if nameTextField.text != nil && !(nameTextField.text?.isEmpty)! && iconTextField.text != nil && !(iconTextField.text?.isEmpty)!{
            user.activities.append(Activity(name: nameTextField.text!, icon: iconTextField.text!))
            collectionView.reloadData()
        }
    }
}

extension AddActivitiesViewController: UICollectionViewDelegate {
    
}

extension AddActivitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = traitCollection.horizontalSizeClass == .regular ? 6 : 3
        let whiteSpace = 8 + (columns - 1) * 8
        let cellWidth = (collectionView.frame.width - CGFloat(whiteSpace)) / CGFloat(columns)
        return CGSize(width: cellWidth, height: 80)
    }
}

extension AddActivitiesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCell
        cell.activity = user.activities[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        user.activities.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
    }
}
