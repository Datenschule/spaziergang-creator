# coding: utf-8
json.status status

json.data do
  json.walk do
    json.id @walk.id
    json.name @walk.name
    json.location @walk.location
    json.preview_image @walk.preview_image
    json.description @walk.description
    json.courseline @walk.courseline
    json.entry @walk.entry
    json.stations do
      json.array! @walk.stations do |station|
        json.id station.id
        json.name station.name
        json.description station.description
        json.position do
          json.lat station.lat
          json.lon station.lon
        end
        json.next station.next
        json.line station.line
        json.subjects do
          json.array! station.subjects do |subject|
            json.id subject.id
            json.name subject.name
            json.description subject.description
            json.entry subject.entry

            json.pages subject.pages, partial: 'api/walks/page', as: :page
          end
        end
      end
    end
  end
end
