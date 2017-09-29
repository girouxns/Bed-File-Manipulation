#!usr/bin/perl -w
use warnings;
use strict;

die "Usage is: $0 [bed_in]" unless $#ARGV == 0;

my $bedin = $ARGV[0];

my ($a, $b, $c, $d) = ('$1', '$2', '$3', '$4');
print 'Total bp: ';
print `cat $bedin | awk -F'\t' 'BEGIN{SUM=0}{SUM+=$c-$b}END{print SUM}'`;