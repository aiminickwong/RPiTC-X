package Glib::Install::Files;

$self = {
          'inc' => ' -I. -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include   -pthread -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include  ',
          'libs' => '-lgobject-2.0 -lglib-2.0   -pthread -lgthread-2.0 -lglib-2.0  ',
          'deps' => [],
          'typemaps' => [
                          'typemap'
                        ]
        };

@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/Glib/Install/Files.pm") {
			$CORE = $_ . "/Glib/Install/";
			last;
		}
	}

	sub deps { @{ $self->{deps} }; }

	sub Inline {
		my ($class, $lang) = @_;
		if ($lang ne 'C') {
			warn "Warning: Inline hints not available for $lang language
";
			return;
		}
		+{ map { (uc($_) => $self->{$_}) } qw(inc libs typemaps) };
	}

1;
