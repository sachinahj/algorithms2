require_relative 'predictor'
require 'pry-byebug'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  @@count = 0

  def train!
    @data = {}

    @all_books.each do |category, books|
      @data[category] = {
        words: Hash.new(){0},
        books: 0,
        total: 0
      }
      books.each do |filename, tokens|
        @data[category][:total] += tokens.count
        @data[category][:books] += 1
        tokens.each do |word|
          @data[category][:words][word] += 1
        end         
      end
    end

    @knowledge = Hash.new(){[]}
    @data.each do |category, properties|
      @data[category][:words].select! {|word, count| good_token?(word)}
      @knowledge[category] = [];
    end

    @data.each do |category, properties|
      @data[category][:words].map do |word, count|
        @data[category][:words][word] = count/(@data[category][:total].to_f)
      end
    end


    @data.each do |category, properties|
      @data[category][:words].each do |word, count|
        the_all_mighty_chosen_category = nil
        all_mighty_juice = 0
        @data.each do |category, properties|
          if @data[category][:words][word] >= all_mighty_juice
            all_mighty_juice = @data[category][:words][word]
            the_all_mighty_chosen_category = category
          end
        end
        if the_all_mighty_chosen_category != nil
          @knowledge[the_all_mighty_chosen_category] << word
        end
      end
    end

    # Checks to see if each knowledge[category] array is unique
    # @data.each do |category1, properties|
    #   @data.each do |category2, properties|
    #     puts "#{category1} vs #{category2}"
    #     p (@knowledge[category1] & @knowledge[category2]).length
    #   end
    # end
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    # Always predict astronomy, for now.
    
    prediction = nil
    prediction_count = 0
    @data.each do |category, properties|
      puts "#{category} ---> #{(@knowledge[category] & tokens).length}"
      if (@knowledge[category] & tokens).length > prediction_count
        prediction = category
        prediction_count = (@knowledge[category] & tokens).length
      end
    end

    return prediction
  end
end

