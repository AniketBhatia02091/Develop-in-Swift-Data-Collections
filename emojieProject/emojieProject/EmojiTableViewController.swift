//
//  EmojiTableViewController.swift
//  emojieProject
//
//  Created by Aniket Bhatia on 17/09/25.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content  = cell.defaultContentConfiguration()
        content.text = "\(emojis[indexPath.row].symbol) - \(emojis[indexPath.row].name)"
        content.secondaryText = "\(emojis[indexPath.row].description)"
        
        cell.contentConfiguration = content
        cell.showsReorderControl = true

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
    }

    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let removedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(removedEmoji, at: to.row)

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditScreen", sender: indexPath)
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBSegueAction func addeditSegueAction(_ coder: NSCoder, sender: Any?) -> AddEditTableViewController? {
        guard let sender = sender as? IndexPath else {
            return AddEditTableViewController(coder: coder)
        }
    return AddEditTableViewController(coder: coder, emoji: Emoji(symbol: emojis[sender.row].symbol, name: emojis[sender.row].name, description: emojis[sender.row].description, usage: emojis[sender.row].usage))
    }
    
    @IBAction func unwindToList(_ segue: UIStoryboardSegue){
        guard let sourceVC = segue.source as? AddEditTableViewController,let emoji = sourceVC.emoji else { return }
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
    }
    

}
