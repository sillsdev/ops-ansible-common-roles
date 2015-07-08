#!/usr/bin/perl
###############################################################################
# Copyright 2006-2012, Way to the Web Limited
# URL: http://www.configserver.com
# Email: sales@waytotheweb.com
###############################################################################
sub custom_line {
	my $line = shift;
	my $lgfile = shift;

# Do not edit before this point
###############################################################################
#
# Custom regex matching can be added to this file without it being overwritten
# by csf upgrades. The format is slightly different to regex.pm to cater for
# additional parameters. You need to specify the log file that needs to be
# scanned for log line matches in csf.conf under CUSTOMx_LOG. You can scan up
# to 9 custom logs (CUSTOM1_LOG .. CUSTOM9_LOG)
#
# The regex matches in this file will supercede the matches in regex.pm
#
# Example:
#	if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /^\S+\s+\d+\s+\S+ \S+ pure-ftpd: \(\?\@(\d+\.\d+\.\d+\.\d+)\) \[WARNING\] Authentication failed for user/)) {
#		return ("Failed myftpmatch login from",$1,"myftpmatch","5","20,21","1");
#	}
#
# The return values from this example are as follows:
#
# "Failed myftpmatch login from" = text for custom failure message
# $1 = the offending IP address
# "myftpmatch" = a unique identifier for this custom rule, must be alphanumeric and have no spaces
# "5" = the trigger level for blocking
# "20,21" = the ports to block the IP from in a comma separated list, only used if LF_SELECT enabled
# "1" = n/temporary (n = number of seconds to temporarily block) or 1/permanant IP block, only used if LF_TRIGGER is disabled

# sgw postfix/smtpd UNKNOWN from unknown
    if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /postfix\/smtpd[^U]*UNKNOWN from unknown\[(\d+\.\d+\.\d+\.\d+)\]/)) {
        return ("UNKNOWN from unknown from",$1,"sgw_postfix_unknown","2","25,587","3600");
    }

# sgw postfix/smtpd lost connection after AUTH
    if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /postfix\/smtpd\[\d+\]: lost connection after AUTH from [^\[]+\[(\d+\.\d+\.\d+\.\d+)\]/)) {
        return ("lost connection after AUTH from",$1,"sgw_postfix_lost","4","25,587","3600");
    }

#sgw postfix/smtpd SASL authentication failure

    if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /postfix\/smtpd[^w]*warning: ([^[]+)\[(\d+\.\d+\.\d+\.\d+)\]: SASL (LOGIN|PLAIN) authentication failed/)) {
        return ("sasl auth failure from ",$2,"sgw_postfix_sasl","3","25,587","3600");
    }

#sgw postfix discard php header check

    if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /postfix\/cleanup[^d]*discard: header X-PHP-Script: [^f]+for (\d+\.\d+\.\d+\.\d+)/)) {
        return ("discard via php header check from ",$1,"sgw_postfix_discard","2","25,587,80","3600");
    }

#sgw postfix warn php header check

    if (($lgfile eq $config{CUSTOM1_LOG}) and ($line =~ /postfix\/cleanup[^w]+warning: header X-PHP-Script: ([^f]+)for (\d+\.\d+\.\d+\.\d+)/)) {
        return ("warn via php header check from ",$2,"sgw_postfix_warn_php","2","25,587,80","3600");
    }


# If the matches in this file are not syntactically correct for perl then lfd
# will fail with an error. You are responsible for the security of any regex
# expressions you use. Remember that log file spoofing can exploit poorly
# constructed regex's
###############################################################################
# Do not edit beyond this point

	return 0;
}

1;
