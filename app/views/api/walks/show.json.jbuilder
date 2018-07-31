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
    json.stations do
      json.array! @stations do |station|
        json.id station.id
        json.name station.name
        json.description station.description
        json.position do
          json.lat station.lat
          json.lon station.lon
        end
        json.entry 0
        json.next station.next
        json.line station.line
        json.subjects do
          json.array! station.subjects do |subject|
            json.id subject.id
            json.name subject.name
            json.description subject.description
            json.entry subject.entry
            json.line 0
            json.pages do
              json.array! subject.pages do |page|
                json.type page.variant
                json.id page.id
                json.name page.name
                json.next page.next if page.next
                json.prev page.prev if page.prev
                json.link page.link if page.link && page.variant == "iframe"
                if page.variant == "story"
                  #json.img page.img if page.img
                  json.content page.content
                  #json.content do
                    #json.array! page.content do |content|
                      #content if content
                    #end
                  #end

                  json.challenges page.challenges
                  #json.challenges do
                    #json.array! page.challenges do |challenge|
                      #challenge if challenge
                    #end
                  #end
                end
                if page.variant == "quiz"
                  json.question page.question if page.question
                  json.answers page.answers if page.answers
                  #json.answers do
                  #json.array! page.answers do |answer|
                  #    answer if answer
                  #  end
                  #end
                  #json.correct page.correct if page.correct
                end
              end
            end
          end
        end
      end
    end
  end
end
