
package Test::GD;

use strict;
use warnings;

our $VERSION = '0.01';

use Test::Builder ();
use Scalar::Util 'blessed';
use GD qw(:cmp);

sub import { 
    my $pkg = caller;
    no strict 'refs';
    *{"${pkg}::cmp_image"} = \&cmp_image;
}

my $Test = Test::Builder->new;

sub cmp_image ($$;$) {
    my ($got, $expected, $message) = @_;
    unless (blessed($got) && $got->isa('GD::Image')) {
        $got = GD::Image->new($got) 
               || die "Could not create GD::Image instance with : $got";
    }
    unless (blessed($expected) && $expected->isa('GD::Image')) {
        $expected = GD::Image->new($expected) 
               || die "Could not create GD::Image instance with : $expected";
    }    
    
    if ($got->compare($expected) & GD_CMP_IMAGE) {
        $Test->ok(0, $message);
    }
    else {
        $Test->ok(1, $message);
    }
}

1;

__END__

=head1 NAME

Test::GD - A module for testing images using GD

=head1 SYNOPSIS

  use Test::More plan => 1;
  use Test::GD;
  
  cmp_image('test.gif', 'control.gif', '... these images should match');
  
  # or 
  my $test = GD::Image->new('test.gif');
  my $control = GD::Image->new('control.gif');
  cmp_image($test, $control, '... these images should match');

=head1 DESCRIPTION

=head1 FUNCTIONS

=over 4

=item B<cmp_image ($got, $expected, $message)>

=back

=head1 TO DO

=head1 BUGS

None that I am aware of. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, below is the B<Devel::Cover> report on this module test suite.

=head1 SEE ALSO

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

