class GamesController < ApplicationController
  require 'net/http'
  require 'json'

  def new
    alpha = ("A".."Z").to_a
    @letters = alpha.sample(8)
  end

  def score
    @letters = params[:letters].chars
    @answer = params[:answer].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    check = JSON.parse(response)
    if check["found"] == true
      @answer_sort = @answer.chars.sort
      @letters.each do |letter|
        @answer_sort.delete(letter)
      end
      if @answer_sort.empty?
        @output = "#{@answer} is correct! You scored #{@answer.length} points."
      else
        @output = "invalid answer: #{@answer_sort} isn't in #{@letters}"
      end
    else
      @output = "invalid word"
    end
  end
end
