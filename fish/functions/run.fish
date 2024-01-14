function run --description "run <name>"
    set -l name "$argv[1]"
    if test -n "$name"
        # Set Address Sanitizer (not sure if it works :D)
        if test -n "$argv[2]"
            g++ -std=c++17 -Wall -pedantic -Wno-long-long -fsanitize=address -O2 -o "$name.bin" "$name.c"
        else
            g++ -std=c++17 -Wall -pedantic -Wno-long-long -O2 -o "$name.bin" "$name.c"
        end

        chmod +x ./"$name".bin
        ./"$name".bin
    end
end
