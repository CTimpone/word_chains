require 'set'

class WordChainer

  def initialize(dictionary_file_name = 'dictionary.txt')
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
end
