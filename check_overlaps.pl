#!/usr/bin/perl -w
use warnings;
use strict;

die "Usage is $0 [bed1] [bed2]" unless $#ARGV == 1;

my ($a, $b, $c, $d) = ('$1', '$2', '$3', '$4');

my ($bed1, $bed2) = @ARGV;
my @names = (split(/\.bed/, $bed1), split(/\.bed/, $bed2));

print "Lines in intersection: ";
print `multiIntersectBed -i $bed1 $bed2 -empty -g chrom_sizes.txt -header -names $names[0] $names[1] -sorted > intersect_tmp.lst && wc -l intersect_tmp.lst`;

print "Lines overlapping: ";
print `awk '{if ($d == 2) print;}' < intersect_tmp.lst > only_overlaps_tmp.lst`;
print `wc -l only_overlaps_tmp.lst`;

print "Total bp overlapping: ";
print `cat only_overlaps_tmp.lst | awk -F'\t' 'BEGIN{SUM=0}{SUM+=$c-$b}END{print SUM}'`;

print "Total bp covered by bed1: ";
print `cat $bed1 | awk -F'\t' 'BEGIN{SUM=0}{SUM+=$c-$b}END{print SUM}'`;

print "Total bp covered by bed2: ";
print `cat $bed2 | awk -F'\t' 'BEGIN{SUM=0}{SUM+=$c-$b}END{print SUM}'`;

#print `rm intersect_tmp.lst`;
#print `rm only_overlaps_tmp.lst`;
