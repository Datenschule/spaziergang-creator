require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  describe 'pages_parse_content_helper' do
    it 'returns array split new lines' do
      content_mock = " Hello this is \n alot of test \n text on several lines. "
      expect(helper.pages_parse_content(content_mock)).to eq(['Hello this is',
                                                              'alot of test',
                                                              'text on several lines.'])
    end
  end

  describe 'pages_parse_list_helper' do
    it 'returns array split by newline and -' do
      list_mock = "- Hello this is\n- alot of test\n-* text on several lines."
      expect(helper.pages_parse_list(list_mock)).to eq(['Hello this is',
                                                        'alot of test',
                                                        '* text on several lines.'])
      other_mock = "-sdlfhsdlkj\r\n-* sdkfjsdf\r\n- last"
      expect(helper.pages_parse_list(other_mock)).to eq(['sdlfhsdlkj', '* sdkfjsdf', 'last'])
    end
  end

  describe 'pages_clean_answers_helper' do
    it 'takes a list and returns list cleaned from beginning *' do
      mock = ['Hello this is',
              'alot of test',
              '* text on several lines.']
      expect(helper.pages_clean_answers(mock)).to eq(['Hello this is',
                                                      'alot of test',
                                                      'text on several lines.'])
    end
  end

  describe 'pages_correct_answer_index_helper' do
    it "takes a list of answers and returns the index of the correct one" do
      mock = ['Hello* this is',
              'alot of test',
              '* text on several lines.']
      expect(helper.pages_correct_answer_index(mock)).to eq(2)
    end
  end
end
