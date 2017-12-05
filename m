Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752773AbdLEKFV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Dec 2017 05:05:21 -0500
Date: Tue, 5 Dec 2017 08:05:19 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: Joe Perches <joe@perches.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: log message to module appraisal error
Message-ID: <20171205100519.GA16417@glitch>
References: <20171204202347.16261-1-brdeoliv@redhat.com>
 <1512430537.6321.58.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <1512430537.6321.58.camel@perches.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 04-12, Joe Perches wrote:
> On Mon, 2017-12-04 at 18:23 -0200, Bruno E. O. Meneguele wrote:
> > Simple but useful message log to the user in case of module appraise is
> > forced and fails due to the lack of file descriptor, that might be
> > caused by kmod calls to compressed modules.
> []
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> []
> > @@ -366,8 +366,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> >  
> >  	if (!file && read_id == READING_MODULE) {
> >  		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> > -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> > +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > +			pr_err("impossible to appraise a module without a file \
> > +			       descriptor. sig_enforce kernel parameter might \
> > +			       help\n");
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> You should probably use scripts/checkpatch.pl on your proposed
> patches
> before sending them.
> 
> You've got a lot of tabs and spaces after every line continuation.
> Please coalesce the format on a single line and avoid this defect.
> 
> 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> 

Oh gosh, sorry for that. You're right. I'll post a v3, changing to the
way you pointed, soon.

Thanks!


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
