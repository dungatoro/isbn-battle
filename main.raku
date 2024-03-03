use WWW;

sub checksum (Str $isbn) {
    my @mults = 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1;
    my $sum = [+] zip(@mults, $isbn.subst(/(\-|.$)/,'',:g).comb).map:{[*] $_};
    10-($sum mod 10) ~~ $isbn.substr(*-1)
}

my $rx = /^(978|979)\-?\d**1..5\-?\d**1..7\-?\d**1..6\-?\d$/;
subset ISBN where $_.subst(/\-/,'',:g).chars ~~ 13 && $_ ~~ $rx && checksum $_;

class Bookworm {
    has Int $!hp;
    has Int $!dmg;
    has Int $!alt;
    has Int $!type;
    has Str $!name;

    method BUILD (ISBN :$isbn) {
        my %response = jget("https://openlibrary.org/api/books?bibkeys=ISBN:$isbn&jscmd=details&format=json");
        $!name = "%response{"ISBN:$isbn"}{'details'}{'title'} worm";

        my @fields = $isbn.subst(/\-/,'',:g).substr(3..*).comb.rotor(3,:partial).map:{Int($_.join)};
        ($!hp, $!dmg, $!alt, $!type) = @fields;
    }

    method Str {
        say q:to/END/
                                                /~~\
  ____                                         /'o  |
.~  | `\             ,-~~~\~-_               ,'  _/'|
`\_/   /'\         /'`\    \  ~,             |     .'
    `,/'  |      ,'_   |   |   |`\          ,'~~\  |
     |   /`:     |  `\ /~~~~\ /   |        ,'    `.'
     | /'  |     |   ,'      `\  /`|      /'\    /
     `|   / \_ _/ `\ |         |'   `----\   |  /'
      `./'  | ~ |   ,'         |    |     |  |/'
       `\   |   /  ,'           `\ /      |/~'
         `\/_ /~ _/               `~------'
             ~~~~ 
END
;
        "$!name\n----------\n|HP: $!hp\n|DMG: $!dmg\n|ALT: $!alt\n|TYPE: $!type"
    }
}

multi MAIN (ISBN $book) {
    # Show the stats of a single book
    my $worm = Bookworm.new(isbn => $book);
    print $worm;
}

multi MAIN (ISBN $book1, ISBN $book2) {
    # Start a fight between the two books
}
