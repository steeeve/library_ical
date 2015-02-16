json.array! @loans do |loan|
  json.title loan.title
  json.author loan.author
  json.due_date loan.due_date
end
