module PagesHelper
  def pages_parse_answers(answers)
    answers
      .split('-')
      .select { |f| !f.empty? }
      .map { |f| f.strip }
  end

  def pages_clean_answers(answers_array)
    answers_array.map { |f| f.gsub("*", "").strip }
  end

  def pages_correct_answer_index(answers_array)
    @index
    answers_array.each_with_index do |v, i|
      @index =  i if v.include? "*"
    end
    @index
  end

  def pages_parse_challenges(challenges)
    challenges
      .split('-')
      .select { |f| !f.empty? }
      .map { |f| f.strip }
  end

  def pages_parse_content(content)
    content.split("\n").map { |f| f.strip }
  end
end
