require_relative 'predictor'

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

    @data.each do |category, properties|
      @data[category][:words].select! {|word, count| good_token?(word)}
    end
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    # Always predict astronomy, for now.
    chosen_category = nil
    similar_count = 0
    @data.each do |category, properties|
      puts "#{category} ---> #{(@data[category][:words].keys & tokens).length}"
      if (@data[category][:words].keys & tokens).length > similar_count
        chosen_category = category
        similar_count = (@data[category][:words].keys & tokens).length
      end
    end
    return chosen_category 
  end
end

