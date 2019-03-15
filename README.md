# Tasks

This is a task tracker app! Here are some of the design decisions I made:

- a user has a manager flag that determines if they are able to manage
underlings. Rather than adding some permissions around this flag, I just made
it an editable field of the user

- there is a "manager" section that is a separate template that I render
both on the home page and on the user's page, if they are a manager. It
includes their underlings and the task report for those underlings

- this task tracker currently does not support direct input of the
time blocks for a task 😢
