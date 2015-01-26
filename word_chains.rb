require 'set'
require 'byebug'

class WordChainer

  def initialize(dictionary_file_name = 'dic.txt')
    @dictionary = []
    File.open(dictionary_file_name).each_line {|word| @dictionary << word.chomp}

    @dictionary = Set.new(@dictionary)
  end

  def adjacent_words(word)
    len = word.length
    @dictionary = @dictionary.select {|entry| entry.length == len}
    adjacent = []
    arr = word.split('')

    @dictionary.each do |check|
      arr.each_index do |idx|

        beginning_partial = check[0...idx].split('')
        end_partial = check[idx + 1...len].split('')
        temp = arr.dup
        temp.delete_at(idx)
        partial = beginning_partial + end_partial

        if temp == partial && check != word
          adjacent << check
        end
      end
    end

    adjacent.uniq
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words =[source]

    until @current_words.empty?
      @debugger
      new_current_words = []
      adjacent = []

      @current_words.each do |fill_adj|
        adjacent = self.adjacent_words(fill_adj)
        adjacent.each do |new_adj|
          if !@all_seen_words.include?(new_adj)
            new_current_words << new_adj
            @all_seen_words << fill_adj
          end
        end
      end

      @current_words = new_current_words
    end
  end

end
