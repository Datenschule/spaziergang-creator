json.type page.variant
json.id page.priority
json.name page.name
json.next page.next if page.next
json.prev page.prev if page.prev

json.link page.link if page.link && page.variant == "iframe"

if page.variant == "story"
  json.content do
    json.array! pages_parse_content(page.content)
  end
  json.challenges do
    json.array! pages_parse_list(page.challenges) unless page.challenges.empty?
  end
end

if page.variant == "quiz"
  json.question page.question if page.question
  json.answers do
    json.array! pages_clean_answers(pages_parse_list(page.answers))
  end
  json.correct pages_correct_answer_index(pages_parse_list(page.answers))
end
