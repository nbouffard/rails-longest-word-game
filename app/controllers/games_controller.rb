require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    @letters = params[:letters].delete(' ').split('')
    @word.chars.all? do |letter|
      if @letters.include?(letter.upcase) && word['found'].to_s == 'true'
        @result = "#{@word} is an english word"
      elsif @letters.include?(letter.upcase) == false && word['found'].to_s == 'true'
        @result = "#{@word} cannot be made using the letters of the grid"
      else
        @result = "#{@word} is not an english word"
      end
    end
  end
end
