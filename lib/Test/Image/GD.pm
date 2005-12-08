
package Test::Image::GD;

use strict;
use warnings;

our $VERSION = '0.03';

use Test::Builder ();
use Scalar::Util 'blessed';
use GD qw(:cmp);

require Exporter;

our @ISA    = qw(Exporter);
our @EXPORT = qw(
                cmp_image 
                size_ok 
                height_ok 
                width_ok
              );

my $Test = Test::Builder->new;

sub cmp_image ($$;$) {
    my ($got, $expected, $message) = @_;
    _coerce_image($got);  
    _coerce_image($expected);   
       
    if ($got->compare($expected) & GD_CMP_IMAGE) {
        $Test->ok(0, $message);
    }
    else {
        $Test->ok(1, $message);
    }
}

sub size_ok ($$;$) {
    my ($got, $expected, $message) = @_;
    _coerce_image($got);  
    (ref($expected) && ref($expected) eq 'ARRAY')
        || die "expected must be an ARRAY ref";    

    if ($got->width  == $expected->[0] && 
        $got->height == $expected->[1] ){
        $Test->ok(1, $message);
    }
    else {
        $Test->diag("... (image => (width, height))\n" . 
                    "   w: (" . $got->width  . " => " . $expected->[0] . ")\n" .
                    "   h: (" . $got->height . " => " . $expected->[1] . ")");            
        $Test->ok(0, $message);
    }
}

sub height_ok ($$;$) {
    my ($got, $expected, $message) = @_;
    _coerce_image($got);  

    if ($got->height == $expected){
        $Test->ok(1, $message);
    }
    else {
        $Test->diag("... (image => (height))\n" . 
                    "   h: (" . $got->height . " => " . $expected . ")");            
        $Test->ok(0, $message);
    }
}

sub width_ok ($$;$) {
    my ($got, $expected, $message) = @_;
    _coerce_image($got);  

    if ($got->width == $expected){
        $Test->ok(1, $message);
    }
    else {
        $Test->diag("... (image => (width))\n" . 
                    "   w: (" . $got->width . " => " . $expected . ")");            
        $Test->ok(0, $message);
    }
}

## Utility Methods

sub _coerce_image {
    unless (blessed($_[0]) && $_[0]->isa('GD::Image')) {
        $_[0] = GD::Image->new($_[0]) 
               || die "Could not create GD::Image instance with : " . $_[0];
    }  
}

1;

__END__

=head1 NAME

Test::Image::GD - A module for testing images using GD

=head1 SYNOPSIS

  use Test::More plan => 1;
  use Test::Image::GD;
  
  cmp_image('test.gif', 'control.gif', '... these images should match');
  
  # or 
  
  my $test = GD::Image->new('test.gif');
  my $control = GD::Image->new('control.gif');
  cmp_image($test, $control, '... these images should match');
  
  size_ok('camel.gif', [ 100, 350 ], '... the image is 100 x 350");

=head1 DESCRIPTION

This module is meant to be used for testing custom graphics, it provides only one function
at the moment, which is C<cmp_image>, and can be used to compare two images to see if they are
visually similar. Future versions may include other testing functions.

=head1 FUNCTIONS

=over 4

=item B<cmp_image ($got, $expected, $message)>

This function will tell you whether the two images will look different, ignoring differences 
in the order of colors in the color palette and other invisible changes. 

Both C<$got> and C<$expected> can be either instances of C<GD::Image> or either a file handle 
or a file path (both are valid parameters to the C<GD::Image> constructor).

=item B<size_ok ($got, [ $width, $height ], ?$message)>

... 

=item B<height_ok ($got, $height, ?$message)>

... 

=item B<width_ok ($got, $width, ?$message)>

... 

=back

=head1 TO DO

=over 4

=item Add more functions

This module currently serves a very basic need of mine, however, I am sure as I start writing 
more tests against images I will find a need for other testing functions. Any suggestions are 
welcome.

=back

=head1 BUGS

None that I am aware of. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, below is the B<Devel::Cover> report on this module test suite.

 ---------------------------- ------ ------ ------ ------ ------ ------ ------
 File                           stmt   bran   cond    sub    pod   time  total
 ---------------------------- ------ ------ ------ ------ ------ ------ ------
 Test/Image/GD.pm              100.0   91.7   63.6  100.0  100.0  100.0   93.7
 ---------------------------- ------ ------ ------ ------ ------ ------ ------ 
 Total                         100.0   91.7   63.6  100.0  100.0  100.0   93.7
 ---------------------------- ------ ------ ------ ------ ------ ------ ------

=head1 SEE ALSO

The C<compare> function of C<GD::Image> class, that is how this module is implemented.

=head1 AUTHOR

Stevan Little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

