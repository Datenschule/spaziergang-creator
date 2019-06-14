module PagesHelper
  def pages_clean_answers(answers_array)
    answers_array.map { |f| f.gsub(/^\*/, "").strip }
  end

  def pages_correct_answer_index(answers_array)
    index = nil
    answers_array.each_with_index do |v, i|
      index =  i if /^\*/.match? v
    end
    index
  end

  def pages_parse_list(list)
    list
      .split(/(\\r)?(\\n)?-/)
      .select { |f| !f.empty? }
      .map { |f| f.strip }
  end

  def pages_parse_content(content)
    content.split("\n").map { |f| f.strip }
  end
end
