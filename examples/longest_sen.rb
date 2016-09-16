def LongestWord(sen)
  # split sentence into array, not including punctuation, find the longest word in the sentence.
  # spliting the string at the spaces
  words = sen.split(' ')
  # set a variable equal to zero for the loop
  max = 0
  # create a variable to equal a blank string so we have a place to add the new word after our loop.
  longest_word = ""
  # instead of using |i| we can use a shortcut that will take each word or string and give us the length of that string.
  words.each do |word|
    # set a variable to remove punctuation from the strings or words in the array using the gsub method.
    clean_word = word.gsub(".", "").gsub(",", "")
    # use a conditional to scan each clean word and reset the max variable to determine the longest word in the sentence or the longest string in the array.
    if max < clean_word.length
      max = clean_word.length
      longest_word = clean_word
      # end conditional
    end
    # end loop
  end
  # call the longest word string
  longest_word
  # end defining the method
end
# put the longest word
puts LongestWord("Yesterday, I went to the park, and....... then I ran to the grocery store!")
