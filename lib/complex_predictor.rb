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

    @tf_idf = Hash.new()
    @data.each do |category, properties|
      @data[category][:words].select! {|word, count| good_token?(word)}
      @tf_idf[category] = {:tf => {}, :idf => {}, :tf_idf => {}};
    end

    @data.each do |category, properties|
      @data[category][:words].map do |word, count|
        @tf_idf[category][:tf][word] = count/(@data[category][:total].to_f)
      end
    end

    @data.each do |category, properties|
      @data[category][:words].each do |word, count|
        counter = 0
        @data.each do |category, properties|
          counter += 1 if @data[category][:words][word] != 0
        end
        @tf_idf[category][:idf][word] = Math.log(4.0 / counter)
      end
    end

    @tf_idf.each do |category, properties|
      @tf_idf[category][:tf].each do |word, tf_val|
        @tf_idf[category][:tf_idf][word] = @tf_idf[category][:tf][word] * @tf_idf[category][:idf][word]
      end
    end
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    @counter = Hash.new()
    @data.each do |category, properties|
      @counter[category] = 0
    end
    
    tokens.each do |word|
      @data.each do |category, properties|
        if @tf_idf[category][:tf_idf][word]
          @counter[category] += @tf_idf[category][:tf_idf][word]
        end
      end
    end
    return (@counter.max_by{|category, count| count})[0]
  end
end

