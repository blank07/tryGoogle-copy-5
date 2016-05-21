

import UIKit

class RegisterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var pswField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var protraitImg: UIButton!
    
    var protaritData: NSData?
    var user: User?
    let userModel = UserModel()
    
    var isValidEmail: Bool?
    var haveEmptyValue: Bool?
    
    private let cityNames = ["Melbourne", "Sydney", "Perth"]
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityField.inputView = cityPicker
        cityPicker.removeFromSuperview()
        emailField.becomeFirstResponder()
    }
    
    var loginModel = LoginModel()
    var userInfoModel = UserInfo()
    
    func signUp() {
        user = userModel.insertUser(emailField.text!, name: nameField.text!, age: ageField.text!, city: cityField.text!, password: pswField.text!, protraitData: protaritData!)
    }
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        emailField.resignFirstResponder()
        nameField.resignFirstResponder()
        ageField.resignFirstResponder()
        pswField.resignFirstResponder()
        cityField.resignFirstResponder()
    }
    @IBAction func nextStepTouched(sender: AnyObject) {
        if self.haveEmptyValue(emailField.text!, name: nameField.text!, age: ageField.text!, password: pswField.text!, city: cityField.text!) == false {
            if self.isEmailValid(emailField.text!) == true {
                //performSegueWithIdentifier("showHobbies", sender: nil)
                self.signUp()
            }
        }
        //performSegueWithIdentifier("showHobbies", sender: nil)
    }
    // check if there have empty textfield
    func haveEmptyValue(email: String, name: String, age: String, password: String, city: String) -> Bool {
        if (email == "" || name == "" || age == "" || password == "" || city == "") {
            self.haveEmptyValue = true
            return true
        }
        self.haveEmptyValue = false
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityNames.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityField.text = cityNames[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityNames[row]
    }
    
    @IBAction func selectCity(sender: AnyObject) {
        //cityPicker.hidden = false;
    }
    
    @IBAction func protraitTouched(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        
        let choosePhotoActionSheet = UIAlertController(title: "Choose a picture", message: "Which way you prefer", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let openCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (ACTION) in
            photoPicker.sourceType = .Camera
            self.presentViewController(photoPicker, animated: true, completion: nil)
            
        }
        let chooseFromPhotoLib = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (ACTION) in
            photoPicker.sourceType = .PhotoLibrary
            self.presentViewController(photoPicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        choosePhotoActionSheet.addAction(openCamera)
        choosePhotoActionSheet.addAction(chooseFromPhotoLib)
        choosePhotoActionSheet.addAction(cancelAction)
        self.presentViewController(choosePhotoActionSheet, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.protaritData = UIImageJPEGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage)!, 1)
        protraitImg.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z)-9.-]+\\.[A-Za-z]{2,4}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isValidEmail = emailCheck.evaluateWithObject(email)
        return self.isValidEmail!
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showHobbies" {
            if self.haveEmptyValue == true {
                let emptyFieldAlert = UIAlertController(title: "All Field shouldn't be empty", message: "Please check your empty field", preferredStyle: .Alert)
                emptyFieldAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(emptyFieldAlert, animated: true, completion: nil)
                return false
            }
            if self.isValidEmail == false {
                let invalidEmailAlert = UIAlertController(title: "Invalid Email Format", message: "Please check your email address format", preferredStyle: .Alert)
                invalidEmailAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(invalidEmailAlert, animated: true, completion: nil)
                return false
            }
            return true
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHobbies" {
            let hobbies: RegisterHobbiesController = segue.destinationViewController as! RegisterHobbiesController
            hobbies.user = self.user
        }
    }
    
    
}
