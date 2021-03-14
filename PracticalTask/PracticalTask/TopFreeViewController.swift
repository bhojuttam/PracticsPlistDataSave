//
//  TopFreeViewController.swift
//  PracticalTask
//
//  Created by Uttam Bhoj on 08/03/21.
//

import UIKit
import SafariServices

class TopFreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    var arrayFreeApps: [TopFreeModel] = []
    @IBOutlet var tblView : UITableView!
    
    var plistURL : URL {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent("data.plist")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Free Apps"
        
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 300
        self.fetchDataFromDataPlist()
    }
    
    func fetchDataFromDataPlist() {
        do {
            let dict = try self.loadPropertyList()
            print(dict)
            if let results = dict["results"] as? [[String: AnyObject]] {
                for object in results {
                    self.arrayFreeApps.append(TopFreeModel.init(object as NSDictionary))
                }
            }
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        } catch {
            self.apiCallForTopFreeData()
            print(error.localizedDescription)
        }
    }
    
    func apiCallForTopFreeData() {
        
        var request = URLRequest(url: URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/100/explicit.json")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                if let dict = json["feed"] as? [String: AnyObject] {
                    do {
                        try self.savePropertyList(dict)
                    } catch {
                        print(error)
                    }
                    
                    if let results = dict["results"] as? [[String: AnyObject]] {
                        for object in results {
                            self.arrayFreeApps.append(TopFreeModel.init(object as NSDictionary))
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFreeApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopFreeTableCell") as? TopFreeTableCell {
            cell.updateCell(arrayFreeApps[indexPath.row])
            cell.contentView.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safariVC = SFSafariViewController.init(url: URL(string: arrayFreeApps[indexPath.row].appUrl)!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    
    //SFSafari show app in safari
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    //Save data into data.plist
    func savePropertyList(_ plist: Any) throws
    {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }


    func loadPropertyList() throws -> [String: AnyObject]
    {
        let data = try Data(contentsOf: plistURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: AnyObject] else {
            return [:]
        }
        return plist
    }
    
}



