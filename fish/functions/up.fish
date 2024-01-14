function up
    if test -n "$argv[1]" && ! test "$argv[1]" -ge 1 2> /dev/null
        echo "Argument is not a positive number!"
        return
    end

    set -l amount 1

    if test -n "$argv[1]"
        set amount "$argv[1]"
    end

    set -l --path rel_path "./"
    for i in (seq 1 "$amount")
        set rel_path "$rel_path../"
    end

    cd "$rel_path"
end
