sub checksum (Str $isbn) {
    my $sum;
    for zip($isbn.subst(/(\-|.$)/,'',:g).comb, (1,3,1,3,1,3,1,3,1,3,1,3,1)) -> [$digit, $mult] {
        $sum += $digit * $mult;
    }
    10-($sum mod 10) ~~ $isbn.substr(*-1)
}

my $re = /^(978|979)\-?\d**1..5\-?\d**1..7\-?\d**1..6\-?\d$/;
subset ISBN13 where $_.subst(/\-/,'',:g).chars~~13 && $_~~$re && checksum($_);

class Bookworm {
    has $!hp;
    has $!dmg;
}

sub MAIN (ISBN13 $book1, ISBN13 $book2) {

}

