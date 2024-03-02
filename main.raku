sub checksum (Str $isbn) {
    my $sum;
    for zip $isbn.subst(/(\-|.$)/,'',:g).comb, (1,3) xx 7 -> [$digit, $mult] {
        $sum += $digit * $mult;
    }
    10-($sum mod 10) ~~ $isbn.substr(*-1)
}

my $rx = /^(978|979)\-?\d**1..5\-?\d**1..7\-?\d**1..6\-?\d$/;
subset ISBN where $_.subst(/\-/,'',:g).chars ~~ 13 && $_ ~~ $rx && checksum $_;

class Bookworm {
    has $!critrate;
    has $!hp;
    has $!dmg;

    method BUILD (ISBN $isbn) {
         
    }
}

multi MAIN (ISBN $book) {
    # Show the stats of a single book
    
}

multi MAIN (ISBN $book1, ISBN $book2) {
    # Start a fight between the two books
}

