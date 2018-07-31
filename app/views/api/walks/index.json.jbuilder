json.status status

json.data do
  json.walks do
    json.array! @walks do |walk|
      json.id walk.id
      json.name walk.name
      json.location walk.location
      json.preview_image walk.preview_image
      json.description walk.description
      json.courseline walk.courseline
    end
  end
end
