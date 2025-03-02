//
//  ViewController.swift
//  Note
//
//  Created by Marwan Mekhamer on 08/08/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNotDataYet: UILabel!
    
    private var arrModel : [ (title : String, subTitle : String) ] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        title = "Note..."
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTabNew))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action: #selector(didTapEdit))
    }
    
    @objc func didTapEdit(){
        tableView.isEditing = !tableView.isEditing
    }
    
    @objc func didTabNew(){
        tableView.isEditing = false
        let vc = NewTabVC()
        vc.title = "New Note..."
        vc.completion = {note, subnote in
            self.navigationController?.popToRootViewController(animated: true)
            self.arrModel.append((title: note, subTitle: subnote))
            self.lblNotDataYet.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()

        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension ViewController : UITableViewDelegate & UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = arrModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = view.title
        cell.detailTextLabel?.text = view.subTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = arrModel[indexPath.row]
        let vc = NoteTapVC()
        vc.title = "Note Ditails..."
        vc.lbltitlenote = model.title
        vc.txtsubview = model.subTitle
        tableView.reloadData()
        vc.newData = { marwan, mekhamer in
            self.navigationController?.popToRootViewController(animated: true)
            self.arrModel.append((title: marwan, subTitle: mekhamer))
            self.tableView.reloadData()

        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        arrModel.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { _, _, marwan in
            self.arrModel.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            if self.arrModel.count == 0{
                self.lblNotDataYet.isHidden = false
                self.tableView.isEditing = false
            }
            marwan(true)
        }
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
}
