Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C43E5A2A
	for <linux-integrity@vger.kernel.org>; Mon, 17 Aug 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964173; cv=none; b=TUu9Dh9cV80mgQNBQC4Nn9CBHnF/M1m4zVtvBHUjRHyoG3NxJoasL7sYN1rlYFnTURJnZLjPO9PNkOvxF7aawDYMR1UJVwOJxJ4McJuVgNsSpyfAo4fCiKH0ZaWHuupjapckDYhO3+jS/CEx+LEbQqWq+k9e0uX7ha04jHnrpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964173; c=relaxed/simple;
	bh=aA9hJ8MaXdmbbKDwz3HuQOk06N1Czkgm3oa305agxao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDlhGzg+Zuheoip0NX8Bm0XSiEiVUSII2bjFmSDDMXepoHen78e1oW5Nj4ID5E4a627n/ohpZoSfz0t98kZxlQDXIMYjoVay6RNIMdHWltUYVQACGw+9daJgQECAh4FBWEFhjiAt74LgsAnVCFW6FTy4S9FJILwKABdojjFYGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=te3hj0on; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3W7V1Jtm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfV0tWrn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rBysBLW7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="te3hj0on";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3W7V1Jtm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfV0tWrn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rBysBLW7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC12F83F66;
	Mon, 17 Aug 2026 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786964162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z01BEAX5s0M6N9y9boMtIFQiNrk3vsTW4CDkHtpa7g=;
	b=te3hj0onBhkhoUSxn5Oyk+AwJxh+yQkod6AykDos3oGUSb6BuNdddTMi17mQxGDsrB8XZ2
	XqFh+gXWENSokYU17i8xHX45j5cRSKZMNaiJf0sQVDg+kqqgynb1UonAWNt+MUabVPasJF
	LnpZ6jgxr90Dg9nZdlJ36Vb/l+zwi/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786964162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z01BEAX5s0M6N9y9boMtIFQiNrk3vsTW4CDkHtpa7g=;
	b=3W7V1JtmcGe6AEBmyb0h3nh8m5fMjpso/7Uy+H3iDkjPngOsu9sGsRygzaIl/98+ko7zjw
	HWEZEwwGm8gzRuDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786964158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z01BEAX5s0M6N9y9boMtIFQiNrk3vsTW4CDkHtpa7g=;
	b=cfV0tWrnVkaOmrcTLKBYdRLPS7afZNp3kFAIlPY+25f1mIb3Bka4RGnI/Z2IBD57fwxPEb
	/tU/vZ5Pw2GWfSCufcT9sd5asNZeR/TIykorQPHNfUeUiEAVckELKHxV5/07E9psPg/Gxf
	NEd575XeNAfSz2pRAUgj1JHMbE++QRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786964158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z01BEAX5s0M6N9y9boMtIFQiNrk3vsTW4CDkHtpa7g=;
	b=rBysBLW7usYX2kFWbtCbVMjsH7A8sOCr67jYeTpiEV2dms/Ej6VqpMJPYls4975L5xxjyB
	baymvPIrEvysnoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D967941A;
	Mon, 17 Aug 2026 10:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHS/Fb7ogmqJGwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Aug 2026 10:55:58 +0000
Date: Mon, 17 Aug 2026 12:55:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_tpm.sh: update test2 to detect integrity violations
Message-ID: <20260817105556.GA1951950@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260814135704.1247403-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814135704.1247403-1-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]

Hi Mimi,

> <securityfs>/integrity/ima/violations reflects the number of
> integrity violations.  Include the "--ignore-violations" option,
> if there are any violations, on the initial IMA measurement list
> verification.

Thanks for your patch!

LGTM and it should be fixed. But there are some potential problems
(see bellow).

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../security/integrity/ima/tests/ima_tpm.sh   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 5d34d8679..acd8b6d30 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -142,6 +142,8 @@ read_pcr_tpm2()
>  get_pcr10_aggregate()
>  {
>  	local cmd="evmctl -vv ima_measurement $BINARY_MEASUREMENTS"
> +	local violations="$IMA_DIR/violations"
> +	local num_violations=0
>  	local msg="$ERRMSG_EVMCTL"
>  	local res=TCONF
>  	local pcr ret
> @@ -151,16 +153,20 @@ get_pcr10_aggregate()
>  		res=TFAIL
>  	fi

> -	$cmd > hash.txt 2>&1
> -	ret=$?
> -	if [ $ret -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> -		tst_res TFAIL "evmctl failed, trying with --ignore-violations"
You removed TFAIL (potential problem, see later).

> +	if [ ! -f "$violations" ]; then
> +		tst_res TINFO "missing $violations"
> +	else
> +		num_violations=$(cat "$violations")
> +	fi
> +
> +	if [ "$num_violations" -eq 0 ]; then
> +		$cmd > hash.txt 2>&1
> +		ret=$?
> +	else
> +		tst_res TINFO "ignoring $num_violations violations"
>  		cmd="$cmd --ignore-violations"
>  		$cmd > hash.txt 2>&1
>  		ret=$?
> -	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
> -		tst_res TFAIL "evmctl failed $msg"
And here again removed TFAIL (see later).

The main problem is that you removed the code when evmctl is not installed.

Therefore trying to rerun evmctl on failure on older release (e.g. 1.3) it will
fail due option have different name or not exist at all in evmctl < 1.2).
-a "$MISSING_EVMCTL" = 1 check had meaning "don't rerun with --ignore-violations
on old evmctl which does not have the option.

FYI the code is a bit complicated, because here on TPM2 we require evmctl 1.3.1
to have --ignore-violations (renamed from --validate), which was released in
2020 - too new for old enterprise distros to ignore; also TPM1 we require only
1.1 from 2018, probably still too new. Once SLE12-SP3 EOL (in 1 year we may just
expect 1.3.1 to simplify).

> -		return
>  	fi

>  	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $msg"
Back to removed TFAIL. While this is OK as TWARN (some problem, but not related
to testing) we might end up to TBROK "Test didn't report any results" error in
tst_test.sh which quits test with TBROK "Test didn't report any results" if
there is no TPASS/TFAIL/TCONF message.

_tst_resstr()
{
	echo "$TST_PASS$TST_FAIL$TST_CONF"
}

_tst_rescmp()
{
	local res=$(_tst_resstr)

	if [ "$1" = "$res" ]; then
		tst_brk TBROK "Test didn't report any results"
	fi
}

And this happen later in test2():
	get_pcr10_aggregate > tmp.txt
	pcr_aggregate="$(cat tmp.txt)"
	if [ -z "$pcr_aggregate" ]; then
		return
	fi

Other option would be to print TFAIL message in test2():

	get_pcr10_aggregate > tmp.txt
	pcr_aggregate="$(cat tmp.txt)"
	if [ -z "$pcr_aggregate" ]; then
		tst_res TBROK "failed to get aggregate PCR-10"
		return
	fi

Lol, I'm disappointed how complicated and error prone I wrote back then.
Part of the problem is that quit with tst_brk does not work, when code which
does it is run in a subshell (via $(...) or `...) ), which quits subshell but
not the parent shell.

Kind regards,
Petr
