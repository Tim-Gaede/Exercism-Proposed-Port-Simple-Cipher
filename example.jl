using OffsetArrays

struct Cipher
    key::String

    function Cipher(key)
        if key == ""  ||  key == nothing
            alphabet = "abcdefghijklmnopqrstuvwxyz"
            key = ""
            for n = 1 : 100
                key *= rand(alphabet)
            end
        end
        new(key)
    end
end

function encode(cipher::Cipher, text::String)
    key0 = OffsetVector{Char}(undef,  0 : length(cipher.key)-1)
    for i = 1 : length(cipher.key)
        key0[i-1] = cipher.key[i]
    end


    txt0 = OffsetVector{Char}(undef,  0 : length(text)-1)
    for i = 1 : length(text)
        txt0[i-1] = text[i]
    end


    letters = "abcdefghijklmnopqrstuvwxyz"
    letters0 = OffsetVector{Char}(undef,  0 : length(letters)-1)
    for i = 1 : length(letters)
        letters0[i-1] = letters[i]
    end


    encrypted = ""
    for i_txt0 = 0 : length(txt0)-1
        i_key0 = i_txt0 % length(key0)
        shift  = indexOf(key0[i_key0], letters0)
        i_let0 = indexOf(txt0[i_txt0], letters0)
        i_enc = mod((i_let0 + shift), length(letters0))
        encrypted *= letters0[i_enc]
    end


    encrypted
end

function decode(cipher::Cipher, text::String)
    key0 = OffsetVector{Char}(undef,  0 : length(cipher.key)-1)
    for i = 1 : length(cipher.key)
        key0[i-1] = cipher.key[i]
    end


    txt0 = OffsetVector{Char}(undef,  0 : length(text)-1)
    for i = 1 : length(text)
        txt0[i-1] = text[i]
    end


    letters = "abcdefghijklmnopqrstuvwxyz"
    letters0 = OffsetVector{Char}(undef,  0 : length(letters)-1)
    for i = 1 : length(letters)
        letters0[i-1] = letters[i]
    end


    decrypted = ""
    for i_txt0 = 0 : length(txt0)-1
        i_key0 = i_txt0 % length(key0)
        shift  = indexOf(key0[i_key0], letters0)
        i_let0 = indexOf(txt0[i_txt0], letters0)
        i_dec = mod((i_let0 - shift), length(letters0))
        decrypted *= letters0[i_dec]
    end


    decrypted
end





function indexOf(val, arr::OffsetVector)
    i = 0
    while i < length(arr)
        if val == arr[i];    return i;    end

        i+=1
    end
    msg = "val not in arr for function, indexOf(val, arr::OffsetVector)."
    throw(ArgumentError(msg))
end
