using Test

include("simple_cipher.jl")


# Tests adapted from `problem-specifications//canonical-data.json` @ v2.0.0


println("\n"^2, "-"^60, "\n"^3)


@testset "Can encode." begin
    cipher = Cipher("")
    plaintext = "aaaaaaaaaa"
    @test encode(cipher, plaintext) == cipher.key[1:length(plaintext)]
end
println()

@testset "Can decode." begin
    cipher = Cipher("")
    plaintext = "aaaaaaaaaa"
    @test decode(cipher, cipher.key[1:length(plaintext)]) == plaintext
end
println()

@testset "Is reversible." begin
    cipher = Cipher("")
    plaintext = "abcdefghij"
    @test decode(cipher, encode(cipher, plaintext)) == plaintext
end
println()

@testset "Key is only made of lowercase letters." begin
    cipher = Cipher("")
    cipher.key == lowercase(cipher.key)
end
println()


#class SubstitutionCipherTest(SimpleCipherTest):
@testset "Can encode." begin
    cipher = Cipher("abcdefghij")
    @test encode(cipher, "aaaaaaaaaa") == cipher.key
end
println()

@testset "Can decode." begin
    cipher = Cipher("abcdefghij")
    @test decode(cipher, cipher.key) == "aaaaaaaaaa"
end
println()

@testset "Is reversible." begin
    cipher = Cipher("abcdefghij")
    plaintext = "abcdefghij"
    @test decode(cipher, encode(cipher, plaintext)) == plaintext
end
println()

@testset "Can double shift encode." begin
    plaintext = "iamapandabear"
    cipher = Cipher(plaintext)
    @test encode(cipher, plaintext) == "qayaeaagaciai"
end
println()

@testset "Can wrap on encode." begin
    cipher = Cipher("abcdefghij")
    @test encode(cipher, "zzzzzzzzzz") == "zabcdefghi"
end
println()

@testset "Can wrap on decode." begin
    cipher = Cipher("abcdefghij")
    @test decode(cipher, "zabcdefghi") == "zzzzzzzzzz"
end
println()

@testset "Can encode messages longer than key." begin
    cipher = Cipher("abc")
    @test encode(cipher, "iamapandabear") == "iboaqcnecbfcr"
end
println()

@testset "Can decode messages longer than key." begin
    cipher = Cipher("abc")
    @test decode(cipher, "iboaqcnecbfcr") == "iamapandabear"
end
println()
