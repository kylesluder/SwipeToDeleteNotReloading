UITableView does not request cells for rows reloaded during -setEditing:animated:
===


Summary
---

When my table view controller transitions to and from editing mode, I want to replace some cells in my table view. To do this, I override `-setEditing:animated:` to send `-reloadRowsAtIndexPaths:withRowAnimation:` to my table view.

The first time I swipe to delete a row in the table view, this works. My table view controller is asked for a new cell at the given index path (though the row animates incorrectly when canceling delete mode). But on subsequent occasions, the rows at the indexes passed to `-reloadRows...` simply vanish, and my view controller is never asked to provide new cells.


Steps to Reproduce
---

1. Build and run the attached demo app.
2. Swipe to enter delete mode on any of the numbered rows.

Note that the first row changes background color.

3. Cancel delete mode by tapping elsewhere.

Note that the first row animates incorrectly.

4. Swipe to delete any of the numbered rows again.


Expected Results
---

First row changes background color again; log message indicates that the data source has been asked for a new cell at the 0th index.


Actual Results
---

First row disappears. No log message indicating the data source was asked for a new cell.


Configuration
---

iOS 8.0 beta 5 Simulator


Version & Build
---

8.0 (12A4345d)
