import UIKit
import CoreData

class CreateEventController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    var posterImg = UIImage()
    
    var cityList = ["Melbourne", "Sydney", "Perth"]
    var cityPicker = UIPickerView()
    var event: Event?
    var user: User?
    
    var eventModel = EventModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityField.inputView = cityPicker
         self.tabBarController?.tabBar.hidden = true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityField.text = cityList[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row]
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == timeField {
            let datePicker = UIDatePicker()
            timeField.inputView = datePicker
            datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        }
        
    }
    @IBAction func begin(sender: UITextField) {
            let datePicker = UIDatePicker()
            timeField.inputView = datePicker
            datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter();
        formatter.dateFormat = "dd-MM-yyyy HH:mm";
        let defaultTimeZoneStr = formatter.stringFromDate(sender.date);
        timeField.text = defaultTimeZoneStr
    }
    
    @IBAction func addEvent(sender: UIButton) {
        let imgData = UIImageJPEGRepresentation(posterImg, 1)
        event = eventModel.insertEvent(titleField.text!, type: typeField.text!, time: timeField.text!, city: cityField.text!, address: addressField.text!, imgData: imgData!)
    }
    @IBAction func openPhotoLibrary(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        posterImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventPage" {
            let eventController: EventController = segue.destinationViewController as! EventController
            eventController.event = self.event
            eventController.user = self.user
        }
    }
    
}
