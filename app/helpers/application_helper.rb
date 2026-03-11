module ApplicationHelper

   # Generate a unique RGB color based on a timestamp
    def color_from_timestamp(timestamp)
        # Convert the timestamp to an integer
        time_number = timestamp.to_i
    
        # Generate RGB values based on the timestamp
        r = (time_number & 0xFF0000) >> 16
        g = (time_number & 0x00FF00) >> 8
        b = (time_number & 0x0000FF)
    
        "rgb(#{r}, #{g}, #{b})"
    end
    
    # Generate a consistent gradient using the created_at timestamp
    def gradient_from_created_at(created_at)
        color1 = color_from_timestamp(created_at.to_time.to_i)

        # Use the next second or any time manipulation to get a different color
        color2 = color_from_timestamp((created_at - 1000.second).to_time.to_i)

        "background-image: linear-gradient(to top, #{color1}, #{color2});"
    end


    def first_letters(sentence)
        words = sentence.split

        if words.size == 1
            word = words[0]
            # return word[0, 2] if word.length >= 2
            return word[0] # If the word is only 1 character long
        end

        if words.size >= 2
            first_letter = words[0][0]
            second_letter = words[1][0]
            return first_letter + second_letter
        end

    "The sentence must contain at least one word."
    end
end
