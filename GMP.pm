package Games::Go::GMP;

use 5.006;
use strict;
use warnings;
use Errno;
use Carp;

require Exporter;
require DynaLoader;
use AutoLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Games::Go::GMP ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	gmp_check
	gmp_chineseRules
	gmp_create
	gmp_destroy
	gmp_handicap
	gmp_iAmWhite
	gmp_komi
	gmp_resultString
	gmp_sendMove
	gmp_sendPass
	gmp_sendUndo
	gmp_size
	gmp_startGame
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "& not defined" if $constname eq 'constant';
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($!{EINVAL}) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    croak "Your vendor has not defined Games::Go::GMP macro $constname";
	}
    }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
	if ($] >= 5.00561) {
	    *$AUTOLOAD = sub () { $val };
	}
	else {
	    *$AUTOLOAD = sub { $val };
	}
    }
    goto &$AUTOLOAD;
}

bootstrap Games::Go::GMP $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Games::Go::GMP - Low-level interface to the Go Modem Protocol

=head1 SYNOPSIS

  use Games::Go::GMP;

=head1 DESCRIPTION

This is an automatically created extension which interfaces
Perl in a very low-level way to William Shubert's GMP library.
(included in this distribution) You will probably need to be
familiar with this library to get anything out of this module.

=head2 EXPORT

None by default.

=head2 Exportable functions

  GmpResult  gmp_check(Gmp *ge, int sleep,
			    int *out1, int *out2, const char  **error)
  int  gmp_chineseRules(Gmp *ge)
  Gmp  *gmp_create(int inFile, int outFile)
  void  gmp_destroy(Gmp *ge)
  int  gmp_handicap(Gmp *ge)
  int  gmp_iAmWhite(Gmp *ge)
  float  gmp_komi(Gmp *ge)
  const char  *gmp_resultString(GmpResult result)
  void  gmp_sendMove(Gmp *ge, int x, int y)
  void  gmp_sendPass(Gmp *ge)
  void  gmp_sendUndo(Gmp *ge, int numUndos)
  int  gmp_size(Gmp *ge)
  void  gmp_startGame(Gmp *ge, int size, int handicap,
			   float komi, int chineseRules, int iAmWhite)


=head1 AUTHOR

Simon Cozens C<simon@cpan.org>

=head1 SEE ALSO

L<perl>.

=cut
