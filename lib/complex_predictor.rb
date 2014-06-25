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

    puts "@knowledge --> #{@knowledge}"
    puts "@data[:religion][:words]['project'] --> #{@data[:religion][:words]['project']}"

    @data.each do |category, properties|
      @data[category][:words].map do |word, count|
        @data[category][:words][word] = count/(@data[category][:total].to_f)
        # binding.pry
      end
    end


    @data.each do |category, properties|
      @data[category][:words].each do |word, count|
        puts "word --> #{word}"
        the_all_mighty_chosen_category = nil
        all_mighty_juice = 0
        # binding.pry
        @data.each do |category, properties|
          # binding.pry
          if @data[category][:words][word] >= count
            all_mighty_juice = count
            the_all_mighty_chosen_category = category
            # binding.pry
          end
        end
        # binding.pry
        if the_all_mighty_chosen_category != nil
          # binding.pry
          @knowledge[the_all_mighty_chosen_category] << word
        end
      end
    end


    p @knowledge


  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    # Always predict astronomy, for now.
    tokens_data = Hash.new() {0}
    tokens.each {|word| tokens_data[word] += 1}
    
    counter = Hash.new() {0}   
    @data.each do |category, properties|
      counter[category] = 0
    end
    
    tokens_data.each do |word, count|
      @data.each do |category, properties|
        counter[category] += count if @knowledge[category].include?(word)
      end 
    end
    p "counter: #{counter}"
    counter.sort.map do |category, count|
      return category# keys will arrive in order to this block, with their associated value.
    end
  end
end

