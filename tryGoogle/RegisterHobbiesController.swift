


import UIKit


class RegisterHobbiesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    var Array = ["Music", "Movie", "Photo", "Sport", "Travel", "Reading"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        //cell.btn?.title = self.Array[indexPath.row]
        var Button = cell.viewWithTag(1) as! UIButton
        Button.setTitle(Array[indexPath.row], forState: UIControlState.Normal)
        
        return cell
    }
    
    @IBAction func selectHobby(sender: UIButton) {
        if sender.backgroundColor == UIColor.greenColor() {
            sender.backgroundColor = UIColor.orangeColor()
        } else {
            sender.backgroundColor = UIColor.greenColor()
        }
    }
    
    @IBAction func registerDone(sender: UIButton) {
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMainPage" {
            let mainPage: MeetUpTabBarController = segue.destinationViewController as! MeetUpTabBarController
            mainPage.user = self.user
        }
    }
}
