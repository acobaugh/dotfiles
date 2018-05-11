#!/usr/bin/perl -w
###
### Author: rdt12@psu.edu
### Date: March 1, 2018
### Desc: Parse input lines looking for safelinks URLs.
###       For each found, output the decoded URL.
###       The input must include the initial "https" and
###       the string "&data=".
###       More is fine, but the regular expression looks for
###       the inital https and a final &data= to delimit
###       the encoded URL.
use strict;
use FileHandle;
use URI::Encode;

my($uri) =  URI::Encode->new( { encode_reserved => 0 } );

my($mangled, $decoded);
my($line);
while ($line = <>) {
    if  ($line =~ /https:\/\/[^\.]+\.safelinks.protection.outlook.com\/\?url=(.*?)&(amp;)?data=/) {
        $mangled = $1;
        $decoded = $uri->decode($mangled);
        printf("%s\n", $decoded);
    } else {
	print $line;
    }
}
