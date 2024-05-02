def caesar_cipher
    input = get_input
    bytes_array = input[:string].downcase.bytes.to_s.scan(/\d+/).map(&:to_i)
    shifted_bytes_array = []
    bytes_array.each do |byte|
        shifted_byte = byte + input[:shift_factor]
        special_chars = [32, 33, 39, 44, 46, 63]
        if special_chars.include? byte then                    # We don't shift space, ', !, ?, . or ,
            shifted_bytes_array.push(byte)
        elsif shifted_byte > 122                               # Wrap byte from A-Z with
            wrapped_byte = (shifted_byte - 122) + 96           # 97 being "A" and 122 being "Z" 
        elsif shifted_byte < 97
            wrapped_byte = (shifted_byte - 97) + 123
        else
            wrapped_byte = shifted_byte 
        end   
        shifted_bytes_array.push(wrapped_byte) unless wrapped_byte.nil?
    end
    shifted_string = shifted_bytes_array.pack('c*')            # Convert bytes back to string of chars
    restore_capitalization(input[:string], shifted_string)
    puts "Your ciphered text: " + shifted_string             
end

def get_input
    puts "Enter the string you'd like to cipher (Special chars: '!?.,)"
    string = gets.chomp
    puts "Enter the shift factor you'd like to apply"
    shift_factor = gets.to_i
    { string: string, shift_factor: shift_factor }
end

def restore_capitalization(original_string, shifted_string)    
    character_array = original_string.chars                                  
    character_array.each_with_index do |character, index|
        if character == character.upcase
            shifted_string[index] = shifted_string[index].capitalize
        end
    end
    shifted_string
end    

caesar_cipher