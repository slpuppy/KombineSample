//
//  TagListViewController+Drop.swift
//  Kombine
//
//  Created by Gabriel Puppi on 12/09/23.
//

import UIKit

extension TagListViewController {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
