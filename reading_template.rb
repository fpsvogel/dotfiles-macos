# This script tranforms the line at the cursor into a reading.csv row.
# By mapping this script to a keyboard shortcut, entering a new row
# becomes just a matter of filling in a few blank columns.

# For more on reading.csv, see https://github.com/fpsvogel/reading

# Cut the line/selection, then grab it from the clipboard. Typically this is the
# head (format, author, title) optionally followed by the Source column.
`osascript -e 'tell application "System Events" to keystroke "x" using {command down}'`
cut = `pbpaste`

comment_char = "\\"
cut = cut.delete_prefix(comment_char).chomp

# Extract the Source and Length columns, if present.
head, source, length = cut.split("|")

start_date = `date +'%Y/%m/%d'`.chomp

row = "|#{head}|#{source}|#{start_date}|||#{length}"

# Output the row to the clipboard, then paste it.
`echo "#{row}" | pbcopy`
sleep 0.05
`osascript -e 'tell application "System Events" to keystroke "v" using {command down}'`
sleep 0.05

# Move the cursor to the end of the row, from the beginning of the next row.
`osascript -e 'tell application "System Events" to key code 123'`
