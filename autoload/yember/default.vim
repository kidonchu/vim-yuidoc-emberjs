" In order to add a doc block type to yember, following set of functions MUST be
" implemented.
" Init() - MUST return dictionary of followings:
"   * is_match(string): boolean
"     Returns whether given string is a match for current type
"   * parse_data(string): dictionary
"     Returns extracted data from given string
"   * template
"     Name of the template to be used to render doc block
