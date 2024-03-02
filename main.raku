

subset ISBN13 where $_.chars ~~ 17 && $_ ~~ /^(978|979)'-'\d**1..5'-'\d**1..7'-'\d**1..6'-'\d$/;

sub MAIN (ISBN13 $book1, ISBN13 $book2) {

}
