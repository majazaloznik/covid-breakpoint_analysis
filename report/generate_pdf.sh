#! /bin/bash

big_separator="========================================================="
small_separator="---------------------------------------------------------"

print_step(){
    echo $big_separator
    echo "$1"
    echo $big_separator
}

print_small_separator(){
    echo $small_separator
    echo "$1"
    echo $small_separator
}

generate_pdf(){
    # no .tex extension
    tex_file="$1"

    output_directory=".tex_output"

    mkdir -p $output_directory

    print_small_separator "Generating .pdf, .aux, .log, .toc"
    pdflatex -interaction=nonstopmode -output-directory $output_directory "$tex_file.tex"

    print_small_separator "Generating reference links"
    pdflatex -interaction=nonstopmode -output-directory $output_directory "$tex_file.tex"

    # open pdf file
    if [[ "$OSTYPE" == "darwin"* ]]; then
      \open "$output_directory/$tex_file.pdf"
      cp "$output_directory/$tex_file.pdf" "./$tex_file.pdf"
    fi
}


generate_pdf "index"
