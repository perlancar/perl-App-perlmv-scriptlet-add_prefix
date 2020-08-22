package App::perlmv::scriptlet::add_prefix;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

our $SCRIPTLET = {
    summary => 'Add prefix to filenames',
    args => {
        prefix => {
            summary => 'The prefix string',
            schema => 'str*',
            req => 1,
        },
        avoid_duplicate_prefix => {
            summary => 'Avoid adding prefix when filename already has that prefix',
            schema => 'bool*',
        },
    },
    code => sub {
        package
            App::perlmv::code;

        use vars qw($ARGS $sim $listing);

        $ARGS && defined $ARGS->{prefix}
            or die "Please specify 'prefix' argument (e.g. '-a prefix=new-')";

        if ($ARGS->{avoid_duplicate_prefix} && index($_, $ARGS->{prefix}) == 0) {
            return $_;
        }
        "$ARGS->{prefix}$_";
    },
};

1;

# ABSTRACT:

=head1 SYNOPSIS

With filenames:

 foo.txt
 new-bar.txt

This command:

 % perlmv add-prefix -a prefix=new- *

will rename the files as follow:

 foo.txt -> new-foo.txt
 new-bar.txt -> new-new-bar.txt

This command:

 % perlmv add-prefix -a prefix=new- -a avoid_duplicate_prefix=1 *

will rename the files as follow:

 foo.txt -> new-foo.txt
