sub checksum (Str $isbn) {
    my @mults = 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1;
    my $sum = [+] zip(@mults, $isbn.subst(/(\-|.$)/,'',:g).comb).map:{[*] $_};
    10-($sum mod 10) ~~ $isbn.substr(*-1)
}

my $rx = /^(978|979)\-?\d**1..5\-?\d**1..7\-?\d**1..6\-?\d$/;
subset ISBN where $_.subst(/\-/,'',:g).chars ~~ 13 && $_ ~~ $rx && checksum $_;

class Bookworm {
    has $!critrate;
    has $!hp;
    has $!dmg;

    method BUILD (ISBN $isbn) {
        $isbn.subst(/\-/,'',:g).substr(3..*);
    }
}

multi MAIN (ISBN $book) {
    # Show the stats of a single book
    
}

multi MAIN (ISBN $book1, ISBN $book2) {
    # Start a fight between the two books
}
