# Tasks1

This is a task tracker app! Here are some of the design decisions I made:

- adding an assignee involves selecting a user from a dropdown
  - this means that all users must be fetched to edit a task...
   hopefully my app does not become too popular

- I decided not to add a separate "complete" feature, so completing a task means
manually editing it, checking the completed box, and setting time_taken.

- it is also necessary to always input a time taken, even when creating the
task. I could not find a good way to separate those concerns.

- It *is* possible to view all of an individual user's tasks through /tasks/personal, and that
path accepts a parameter of user_id. That is linked on the Users page as well.
